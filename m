From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Fri, 05 Dec 2008 17:26:00 -0800
Message-ID: <7vtz9iw0uv.fsf@gitster.siamese.dyndns.org>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200812060134.22959.jnareb@gmail.com>
 <7vabbaxh8y.fsf@gitster.siamese.dyndns.org>
 <200812060209.42906.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 02:27:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8lxL-0007vq-SL
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbYLFB0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 20:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbYLFB0K
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:26:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbYLFB0J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:26:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D5DD84D3D;
	Fri,  5 Dec 2008 20:26:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7ECED84D3C; Fri,
  5 Dec 2008 20:26:02 -0500 (EST)
In-Reply-To: <200812060209.42906.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat, 6 Dec 2008 02:09:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB5287BE-C334-11DD-B44E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102429>

Jakub Narebski <jnareb@gmail.com> writes:

> But we have also 'snapshot' feature, which like 'patches' is not simply
> on/off but is configurable feature, like 'patches' adds new action and
> does modify existing actions only by adding extra links... and which is
> enabled by default.

If my "git log" is telling the true story, "snapshot" was introduced in
cb9c6e5 (gitweb: Support for snapshot, 2006-08-17) and it was disabled by
default.

The "feature" mechanism was introduced after that, with ddb8d90 (gitweb:
Make blame and snapshot a feature., 2006-08-20).  To avoid surprises,
"blame" were marked disabled by default to match the then-current default.
"snapshot" somehow ended up enabled with that change, though, which might
have been a mistake.

But "we erred before" is not a good excuse to deliberately err again, is
it?
