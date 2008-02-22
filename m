From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Fri, 22 Feb 2008 10:18:54 +0100
Message-ID: <87tzk19wn5.fsf@lysator.liu.se>
References: <87odaa4tcl.fsf@lysator.liu.se>
	<m3myptcqji.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexandre Julliard <julliard@winehq.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 10:19:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSU3t-0000kv-Kv
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 10:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbYBVJSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 04:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbYBVJSq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 04:18:46 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:34901 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbYBVJSp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 04:18:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 24217200A207;
	Fri, 22 Feb 2008 10:18:44 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 25845-01-15; Fri, 22 Feb 2008 10:18:43 +0100 (CET)
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id D721D200A1FE;
	Fri, 22 Feb 2008 10:18:43 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 699727B4078; Fri, 22 Feb 2008 10:18:54 +0100 (CET)
In-Reply-To: <m3myptcqji.fsf@localhost.localdomain> (Jakub Narebski's message of "Fri\, 22 Feb 2008 01\:03\:35 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74708>

Jakub Narebski <jnareb@gmail.com> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> This works for me, but before including it someone else should try
>> it. It might only work in Emacs 22, for instance.
>
> 1077:[emacs@git/contrib/emacs]# LC_ALL=3Den_EN make
> emacs -batch -f batch-byte-compile git.el
> Loading /usr/share/emacs/site-lisp/site-start.d/php-mode-init.el (sou=
rce)...
> [...]
> While compiling toplevel forms in file /home/jnareb/git/contrib/emacs=
/git.el:
>   !! File error (("Cannot open load file" "grep"))
> Done
> make: *** [git.elc] Error 1
>
> 1078:[emacs@git/contrib/emacs]# emacs --version
> GNU Emacs 21.4.1

As I suspected. The problem is that the grep commands were rewritten
for Emacs 22, and lots of it can be reused. So to write a similar
command for Emacs 21 probably requires a bit more work. And since I
use Emacs 22 I'm not sure I will feel motivated enough...

--=20
David K=C3=A5gedal
