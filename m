From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Thu, 21 Feb 2008 15:55:15 +0100
Message-ID: <873armbbqk.fsf@lysator.liu.se>
References: <87odaa4tcl.fsf@lysator.liu.se>
	<87ve4itpw0.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexandre Julliard <julliard@winehq.org>
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 15:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSCpt-0006ZQ-Gb
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 15:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbYBUOzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2008 09:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753422AbYBUOzJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 09:55:09 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:53871 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbYBUOzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 09:55:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 6782E200A220;
	Thu, 21 Feb 2008 15:55:05 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 00882-01-34; Thu, 21 Feb 2008 15:55:04 +0100 (CET)
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id BEE33200A1F6;
	Thu, 21 Feb 2008 15:55:04 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 161DA7B4078; Thu, 21 Feb 2008 15:55:15 +0100 (CET)
In-Reply-To: <87ve4itpw0.dlv@maison.homelinux.org> (Remi Vanicat's message of "Thu\, 21 Feb 2008 14\:12\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74620>

Remi Vanicat <vanicat@debian.org> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> This allows easy access to git grep from Emacs.
>>
>
>
> You might want to add a menu:

Note that git-grep is completely independent of git-status. But a menu
entry in git-status might still be a good idea.

> @@ -1497,6 +1497,7 @@ amended version of it."
>        ["Diff File" git-diff-file t]
>        ["Interactive Diff File" git-diff-file-idiff t]
>        ["Log" git-log-file t]
> +      ["Grep" git-grep t]
>        "--------"
>        ["Mark" git-mark-file t]
>        ["Mark All" git-mark-all t]

--=20
David K=C3=A5gedal
