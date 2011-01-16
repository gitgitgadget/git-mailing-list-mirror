From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] rebase -i: reword in-editor documentation of "exec"
Date: Sun, 16 Jan 2011 11:27:47 +0100
Message-ID: <vpq39otrvmk.fsf@bauges.imag.fr>
References: <vpq62ziv788.fsf@bauges.imag.fr>
	<1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
	<20110116015941.GA28137@burratino> <20110116020132.GB28137@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 11:31:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PePtP-00084L-Es
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 11:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab1APKbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jan 2011 05:31:20 -0500
Received: from imag.imag.fr ([129.88.30.1]:64721 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab1APKbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jan 2011 05:31:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p0GARmEL001435
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 16 Jan 2011 11:27:48 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PePps-0005Z1-4a; Sun, 16 Jan 2011 11:27:48 +0100
In-Reply-To: <20110116020132.GB28137@burratino> (Jonathan Nieder's message of "Sat\, 15 Jan 2011 20\:01\:32 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 16 Jan 2011 11:27:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165160>

Jonathan Nieder <jrnieder@gmail.com> writes:

> -#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
> +#  x, exec = run command using shell, and stop if it fails

I don't think this is a good change to remove the <cmd> part. All
other commands are used with

<command> <sha1> <subject line>

and I don't think the user would be able to guess that exec is
different without a hint.

If the problem is the wording of the sentence that may imply that
<cmd> should be the shell itself, then why not

x <cmd>, exec <cmd> = run command <cmd> using shell, and stop if it fails

?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
