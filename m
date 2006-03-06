From: Belmar-Letelier <luis@itaapy.com>
Subject: Re: SSH with alternative port number?
Date: Mon, 06 Mar 2006 23:01:10 +0100
Message-ID: <440CB126.7080707@itaapy.com>
References: <20060306214418.66E153525CB@atlas.denx.de>
Reply-To: luis@itaapy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 22:59:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGNk6-00009T-3m
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 22:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbWCFV7f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Mar 2006 16:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbWCFV7f
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 16:59:35 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:41117 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1752448AbWCFV7e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 16:59:34 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0307.wanadoo.fr (SMTP Server) with ESMTP id 408C51C00216
	for <git@vger.kernel.org>; Mon,  6 Mar 2006 22:59:33 +0100 (CET)
Received: from [192.168.2.13] (ATuileries-153-1-88-167.w83-202.abo.wanadoo.fr [83.202.107.167])
	by mwinf0307.wanadoo.fr (SMTP Server) with ESMTP id DC7F81C001F7;
	Mon,  6 Mar 2006 22:59:32 +0100 (CET)
X-ME-UUID: 20060306215932903.DC7F81C001F7@mwinf0307.wanadoo.fr
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: fr, en
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060306214418.66E153525CB@atlas.denx.de>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17306>

Wolfgang Denk a =E9crit :
> Hi,
>
> is there any way to specify an alternative port number for SSH  based
> remote repository access?
>
> Best regards,
>
> Wolfgang Denk
>

Use your .ssh/config file

$ more /home/luis/.ssh/config
host 217.111.187.226
hostname bmi
port 1234



Luis


--=20
Luis Belmar-Letelier
