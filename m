From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: send an email with logs after push
Date: Fri, 13 Nov 2009 11:42:02 +0100
Message-ID: <vpqocn6iu4l.fsf@bauges.imag.fr>
References: <1258101999.17624.1345023113@webmail.messagingengine.com>
	<a2633edd0911130055y199955a2n93888b03c5f9b985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: michele <michele@mailc.net>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 11:42:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8tbz-00083u-VW
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 11:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108AbZKMKmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 05:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756059AbZKMKmM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 05:42:12 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55469 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108AbZKMKmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 05:42:11 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nADAevQq030618
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 13 Nov 2009 11:40:59 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N8tbO-0000Sp-Ms; Fri, 13 Nov 2009 11:42:02 +0100
In-Reply-To: <a2633edd0911130055y199955a2n93888b03c5f9b985@mail.gmail.com> (Pascal Obry's message of "Fri\, 13 Nov 2009 09\:55\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 13 Nov 2009 11:41:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nADAevQq030618
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1258713660.21613@+bs+L4I1axJSkVSkxGum2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132832>

Pascal Obry <pascal@obry.net> writes:

> Michele,
>
>> Do you have any suggestion to implement this?
>
> I'm doing that. In the post-receive hook I have:

See also post-receive-email in git/contrib/hooks/, probably installed
somewhere like by your distro. In the .git/hooks/post-receive.sample
installed by default by "git init", this should be a matter of
uncommenting one line.

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
