From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [ANNOUNCE] Git 1.7.0.rc1
Date: Sun, 31 Jan 2010 10:36:45 +0100
Message-ID: <vpq3a1maa4y.fsf@bauges.imag.fr>
References: <7vaavvi4r5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 10:40:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbWIA-000154-ON
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 10:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab0AaJkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 04:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450Ab0AaJkV
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 04:40:21 -0500
Received: from imag.imag.fr ([129.88.30.1]:33629 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564Ab0AaJkU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 04:40:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o0V9ajsd027810
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 31 Jan 2010 10:36:46 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NbWEX-0006bW-SX; Sun, 31 Jan 2010 10:36:45 +0100
In-Reply-To: <7vaavvi4r5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 30 Jan 2010 14\:53\:34 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 31 Jan 2010 10:36:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138538>

Junio C Hamano <gitster@pobox.com> writes:

>  * "git status" is not "git commit --dry-run" anymore.  This change does
>    not affect you if you run the command without pathspec.

This is not exactly true, since the list of command line options of
the new "status" are different. For example, the change affect people
who've been taught to always use "git commit" and "git status" with
-a.

I suggest s/pathspec/argument/ in the sentence above:

* "git status" is not "git commit --dry-run" anymore.  This change does
  not affect you if you run the command without argument.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
