From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: How to restore changes to the remote master branch to its previous stage ?
Date: Sat, 07 Jun 2014 12:37:11 +0630
Organization: CognitiveClouds
Message-ID: <1409256.vCu7BMQsbW@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 09:07:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtAj1-00043R-3u
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 09:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbaFGHH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 03:07:27 -0400
Received: from nm35-vm2.bullet.mail.sg3.yahoo.com ([106.10.151.45]:29891 "EHLO
	nm35-vm2.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752720AbaFGHH0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jun 2014 03:07:26 -0400
Received: from [106.10.166.125] by nm35.bullet.mail.sg3.yahoo.com with NNFMP; 07 Jun 2014 07:07:24 -0000
Received: from [106.10.167.173] by tm14.bullet.mail.sg3.yahoo.com with NNFMP; 07 Jun 2014 07:07:24 -0000
Received: from [127.0.0.1] by smtp146.mail.sg3.yahoo.com with NNFMP; 07 Jun 2014 07:07:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1402124844; bh=WpmKOGYotRtDAlTHcTWcUbYtVQRRmxFac7cdjYBl89Q=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:MIME-Version:Content-Transfer-Encoding:Content-Type; b=YtivGiY2TtLvDKmN7wzoIChWeufWPbWguHchG4QOOz1GIPLWj9y7DVCxhTgYWcF1xS4U4souYFlRua9n6ntBC535MC9yAvK+WTDtUX1yYNla4Ji7k22l41bIFDaLT0IUn/TzKTpyGjo8Aigo4F+pvn6eFQGso58RWKA03aN3Ysg=
X-Yahoo-Newman-Id: 623293.28414.bm@smtp146.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: SF.tpWQVM1kytTrBWwFPoOjcfyd3VAr4fIkXh4i_joz9MZh
 nT5LRMK_ApudJ4Q1LIA.gzFavKal.FV7CgiNDHwFySXT7H5f.JiWRVtXvH2P
 7nH83UanrvgjlSRFtNKAvbUAQycqZH5L0k_QoX_VrljGPRIg8V1szAV8UF_P
 GPmRx9erhT.XA0F2vVqXWmwEOlTAMoJCteAb5zTcxTXrl3ixadQrJ7ekUeTr
 O71KO_quTE9pidyyc0BUL5MlJrD.gLkzTN4vNyXbXXYguh_9uwyTx2kpqFbY
 4MptJrZYE6I.NvrpIsJl5Pcx8_QgMvd5.AvDEqysy0SKcsnXBTIYOB11WAYQ
 XhFDN18FrnCkLNe5ThfOcg8zgAOccpNlaSykul6xMQY9r9NrICOx2Pq4ZKvX
 4Hj7NMRLyJYf15f.HH__vBOo.0AJRBM1jNn3l7.0_zThjvlkWvCXZdBqxg_D
 GL1FKK32ynLp29YLk2UpxkmsYy.MSOY4AltFcanx7fJoMbawOJodhtfILo..
 tX1rDQk5BLt53gsFGqvpgdiz4xf9pLqXGq7KcUz_jbRJbj09SR3goATn9Xy3
 ntr4uOhnn_21ApilTnmbQ6w--
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@42.104.1.18 with plain [106.10.150.171])
        by smtp146.mail.sg3.yahoo.com with SMTP; 07 Jun 2014 00:07:24 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-11-default; KDE/4.11.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251030>

Hi,

I am working in a project, where I am using *Git*. Today, I have been advised  
by my manager to do some change and it was an urgent request. I did the change 
and tested also, All was working fine. The big mistake I did, all the changes I 
made in the *master* branch without creating a topic a branch. So, once I done 
with the changes I did *git push origin master* and the changed got merged to 
*master* branch of the remote repository. I know this is not a good practice, 
all happened accidentally. 

Now my question is in such a case, if I see, something wrong I pushed and 
merged to the remote repo's *master* branch, how to restore it to its previous 
stage using *git* ? 

- 
================
Regards,
Arup Rakshit
================
Debugging is twice as hard as writing the code in the first place. Therefore, 
if you write the code as cleverly as possible, you are, by definition, not 
smart enough to debug it.

--Brian Kernighan
