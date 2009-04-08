From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git config'
 access
Date: Wed, 08 Apr 2009 11:51:51 -0700
Message-ID: <7vtz4zm114.fsf@gitster.siamese.dyndns.org>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
 <20090406092942.GW17706@mail-vs.djpig.de>
 <1239058276.31863.19.camel@maia.lan> <m3prfo1xh6.fsf@localhost.localdomain>
 <7vbpr7r72w.fsf@gitster.siamese.dyndns.org>
 <49DC736F.1030007@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Sam Vilain <samv@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:54:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrcuV-0007aP-0M
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763992AbZDHSwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 14:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762757AbZDHSwE
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 14:52:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760005AbZDHSwB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 14:52:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8870FA8198;
	Wed,  8 Apr 2009 14:52:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9C6E3A8193; Wed,
  8 Apr 2009 14:51:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 57C6F074-246E-11DE-9307-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116110>

Sam Vilain <samv@catalyst.net.nz> writes:

> I'm not quite sure what you want squashed where, maybe just edit the
> below list to be how you'd like it,
>
> pick d43238e perl: add new module Git::Config for cached 'git config' access
> pick 5ea135d perl: make Git.pm use new Git::Config module
> pick b2865bc perl: make Git::Config use --null
> pick 28eecdc perl: fix no value items in Git::Config

For example, if Git::Config is a new thing that this series brings in, and
if the final decision made before the series is integrated into my tree is
that it should read from --null output, then that makes the third one an
"Oops, it was a thinko---I should have used --null from day one" fix-up
that shouldn't be in the resulting series as a separate commit, doesn't
it?  I think the same applies to the last "fix no value 'true' variables"
one.
