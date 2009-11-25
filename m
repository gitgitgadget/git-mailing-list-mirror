From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: OS X and umlauts in file names
Date: Wed, 25 Nov 2009 23:43:54 +0100
Message-ID: <m21vjmkyxh.fsf@igel.home>
References: <4B0ABA42.1060103@syntevo.com>
	<alpine.LNX.2.00.0911231403100.14365@iabervon.org>
	<4B0CEFCA.5020605@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQam-00062F-RZ
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759881AbZKYWnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 17:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759878AbZKYWny
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:43:54 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38351 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759875AbZKYWnx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:43:53 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 68B9C1C15A2B;
	Wed, 25 Nov 2009 23:43:58 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id DB19B904F9;
	Wed, 25 Nov 2009 23:43:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id WzE5Egmh-z+u; Wed, 25 Nov 2009 23:43:56 +0100 (CET)
Received: from igel.home (DSL01.83.171.177.175.ip-pool.NEFkom.net [83.171.177.175])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 25 Nov 2009 23:43:56 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 6FEADCA28C; Wed, 25 Nov 2009 23:43:56 +0100 (CET)
X-Yow: I'm having a MID-WEEK CRISIS!
In-Reply-To: <4B0CEFCA.5020605@syntevo.com> (Thomas Singer's message of "Wed,
	25 Nov 2009 09:50:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133691>

Thomas Singer <thomas.singer@syntevo.com> writes:

> I've did following:
>
>  toms-mac-mini:git-umlauts tom$ ls
>  =C3=9Cberl=C3=A4nge.txt
>  toms-mac-mini:git-umlauts tom$ git status
>  # On branch master
>  #
>  # Initial commit
>  #
>  # Changes to be committed:
>  #   (use "git rm --cached <file>..." to unstage)
>  #
>   #	new file:   "U\314\210berla\314\210nge.txt"
>  #
>  toms-mac-mini:git-umlauts tom$ git stage "U\314\210berla\314\210nge.=
txt"
>  fatal: pathspec 'U\314\210berla\314\210nge.txt' did not match any fi=
les

Try $'U\314\210berla\314\210nge.txt' instead.
"U\314\210berla\314\210nge.txt" is the same as
"U\\314\\210berla\\314\\210nge.txt" to the shell.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
