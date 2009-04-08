From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 14/14] difftool/mergetool: refactor commands to use
 git-mergetool--lib
Date: Tue, 07 Apr 2009 23:56:55 -0700
Message-ID: <7vvdpfpr9k.fsf@gitster.siamese.dyndns.org>
References: <1239145213-76701-1-git-send-email-davvid@gmail.com>
 <200904080733.01030.markus.heidelberg@web.de>
 <7vtz4zr80v.fsf@gitster.siamese.dyndns.org>
 <20090408064037.GA9372@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>,
	git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 08:59:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRkm-0002ka-Ol
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 08:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbZDHG5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 02:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762303AbZDHG5H
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 02:57:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761339AbZDHG5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 02:57:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3BA8CA8473;
	Wed,  8 Apr 2009 02:57:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 71670A8472; Wed,
  8 Apr 2009 02:56:57 -0400 (EDT)
In-Reply-To: <20090408064037.GA9372@hashpling.org> (Charles Bailey's message
 of "Wed, 8 Apr 2009 07:40:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 76F3D688-240A-11DE-93DB-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116050>

Charles Bailey <charles@hashpling.org> writes:

> I have been skimming this series, but most of the times that I thought
> I could apply the series and have a thorough review, another comment
> and re-roll has come through and I've decided to wait until it's
> stable.
>
> My slight concern is that this series has been changing very rapidly,
> is everyone else happy that it is stable enough for merge into next?
> Would you like my further input?

I'd feel safer to pick up v5 of 14/14 from David and park the result in
'pu' for a few days.  I expect myself to be overloaded with the day job
for the rest of the week and shouldn't be advancing topics without having
enough concentration myself anyway.
