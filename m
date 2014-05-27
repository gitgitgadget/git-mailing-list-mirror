From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: Can we stage all files using "git add" command, except some specific files ?
Date: Tue, 27 May 2014 09:34:08 +0630
Organization: CognitiveClouds
Message-ID: <5153533.2ydIqZPOTZ@linux-wzza.site>
References: <8392138.j8Dle5WGbS@linux-wzza.site> <11486854.4deTbW34tQ@linux-wzza.site> <CALZVapnUgEnw6rv630awF7AjnfhRzzK8H5wP6jTLN6XZGVJDEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 06:03:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp8cI-0004Sn-W9
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 06:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbaE0EDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 00:03:55 -0400
Received: from nm25-vm8.bullet.mail.sg3.yahoo.com ([106.10.151.103]:46994 "EHLO
	nm25-vm8.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750772AbaE0EDz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2014 00:03:55 -0400
Received: from [106.10.166.118] by nm25.bullet.mail.sg3.yahoo.com with NNFMP; 27 May 2014 04:03:53 -0000
Received: from [106.10.167.172] by tm7.bullet.mail.sg3.yahoo.com with NNFMP; 27 May 2014 04:03:52 -0000
Received: from [127.0.0.1] by smtp145.mail.sg3.yahoo.com with NNFMP; 27 May 2014 04:03:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1401163433; bh=v8bXfsorAe68UnEn2mpCthZrqDOW8VtDE7QTwCONDjc=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=0n76z4XiBKeG0oxV8HwF8tgP+fBzApe//swEq7E9AkYSMJyZlcvSXTCsy9+9HAOcFLygqwDqC6eX1qYR6wjYJkKvx7t+04SBur/TXOuBKR69+nRRq5QaNhxNDUC8mxYeGfV2TAu7gtHI0pz2hJDRQ5amP41TDLm92k1yOFbDNHs=
X-Yahoo-Newman-Id: 18255.47756.bm@smtp145.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: 06vvGegVM1lLW.JtvDxJhKfJyPGlBwy1.PuyO8AhSXx3A5e
 L.Z_h4qiy6wtnfqZ6xUZWXdQcSsYN_abLQGdVxIbvuvUsaWniuZnxaTbKbFL
 vgQO0X1GJvURNGe0bytvPS2gByILre.th85vI9TY99uSFVG9cMbrwdlGfHTK
 VliE1BUonwwINm5DSbTGQUAbDNyyQazWXv5pheL9Ra6qcYzdeN_ifTXOS4Qw
 lEXRuMueHVV_hMQqPsKQ4fWXgnfPkuYIvinttbtPh.rtCcwYuNK9N.opY0tc
 mS1Z6GPQahPjUTpnAihVohzDKTobiDsYjyJ95ERtsW3ys5tjuhwHG.Xjytwu
 7EWjP8x0ZH4.2USGdAL_wdVXYiGlJlCxF6rKg6EtSD6cKhkkSU8P8ByeMsFz
 fFng3QSf_9Igfl7eZJQpiHC_Qf6sQ1Un13S7iBOO2rPvc_3MrjZ6AndJLPjc
 RY71ZF5ou0HHAn3YOIDWXi5uF8ydLG5g37Po.gAakz17AUSCaGAcD7kaIxng
 _7IOyVDJY5HS7QsufZXzqqcEAziG2LsTWuFZgLe42JTBb5omRrVuJyVmEAqa
 os9gvHzlKPYR_EtqPrmaeXTk8hMdkG6oqjebiBWIeqOebH2FJoHX_vcE3wv7
 j6CAgK_yZr3iAYrZE_llIKcpYBhunz2pY
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@101.222.229.17 with plain [106.10.150.171])
        by smtp145.mail.sg3.yahoo.com with SMTP; 26 May 2014 21:03:52 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-11-default; KDE/4.11.5; i686; ; )
In-Reply-To: <CALZVapnUgEnw6rv630awF7AjnfhRzzK8H5wP6jTLN6XZGVJDEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250140>

On Tuesday, May 27, 2014 12:06:34 AM you wrote:
> If you don't want an specific file, but you neither the .gitignore,
> just use .git/info/exclude file for project specific or
> $HOME/.config/git/ignore for user level.
> 
> Anyway, this is all in man gitignore
> 
> [1] Git ignore man page: http://git-scm.com/docs/gitignore
> Javier Domingo Cansino

Hum. That I know, but I show that in my post, just as an example. Here 
question was other files, not _.gitignore_. Anyway, I understand now, that I am 
looking for is not available in Git. The way, I was doing, is the only way to 
do it.

Thanks for your reply.

-- 
===============
Regards,
Arup Rakshit
