From: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
Subject: Re: Error on git clone
Date: Wed, 6 Oct 2010 01:50:13 -0700 (PDT)
Message-ID: <972161.65826.qm@web114601.mail.gq1.yahoo.com>
References: <193301.7835.qm@web114608.mail.gq1.yahoo.com> <4CAC18C7.8020302@viscovery.net> <960844.34400.qm@web114603.mail.gq1.yahoo.com> <4CAC31C4.5060809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 06 10:50:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Phf-00045n-0m
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 10:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758765Ab0JFIuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 04:50:16 -0400
Received: from web114601.mail.gq1.yahoo.com ([98.136.183.10]:22698 "HELO
	web114601.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755179Ab0JFIuO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 04:50:14 -0400
Received: (qmail 66730 invoked by uid 60001); 6 Oct 2010 08:50:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1286355013; bh=RMyU0ZU2wB4VrIgTjw0cQPX3WUuo20ETNyzS6qsTeU8=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=dTKWFaYc7aJW8a1IW91KZvdSmK08gDeVTYhP18KUzcct76jDwAJLh8wEUYyWGecYlmZu2KdD62h0XtKR2vMTS2xG0OfjWoFLFrS9SbsDQF+bsF2nK41f2117RK5RfhJvpwwLdQqAYGhynNodD+lW3iUaE7V7A84LPUmbsdikoi0=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=vJF32WZQcVDhLGlnWhtu8ozB7cZO6QC0pArPL3b6OKAo7ejmgj+Y7X5TOjx2Xe6cbV9fkLLfWI1/eZy8pD7c8Up64pFF0Cb5rlNRcZqf4975XlYrY2nBpJLutPnEaEhCrpv+Hg3Xp/Y/hZegqbI+3NN75ClvwJVRMC8PUNimIZc=;
X-YMail-OSG: X1lTstgVM1nTUsUxFULnDelGWFlwSPRvzuTwk3Z6.V_FC4a
 u65RTB_ri315Fo3imBLYBxuH_M2FNcKGc3ENQU0amJ.V3S51lAfBDfyEnHoL
 fIqg54ITb7gt7aD0qfpu1LbFMPLQtxDK1U7TBAdbaFl2_TfXeX81dgQxQNWT
 xzaa9Z2RVIDiuK6VFZguk3PjFFvV3VuxYnDtF0AyOcv17vSflARMMSY9Kbym
 eBMxJHIFOzwL4ZtYqIYGJUrKEYrXWApYiRuzsKXUYLwt7dcW3JDFF3dtY6Fg
 gL217s7w-
Received: from [76.83.7.252] by web114601.mail.gq1.yahoo.com via HTTP; Wed, 06 Oct 2010 01:50:13 PDT
X-Mailer: YahooMailRC/497 YahooMailWebService/0.8.105.279950
In-Reply-To: <4CAC31C4.5060809@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158275>


Yes, this is with "Git for Windows" (a Git Bash Shell window).

So I did what you suggested:

mkdir sss3
cd sss3
git remote add origin git@github.com:XXX/YYY.git

Then an error occurs:
fatal: Not a git repository (or any of the parent directories): .git

Any thoughts?

Thanks.
Hoca




----- Original Message ----
From: Johannes Sixt <j.sixt@viscovery.net>
To: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
Cc: git@vger.kernel.org
Sent: Wed, October 6, 2010 12:22:28 AM
Subject: Re: Error on git clone

Am 10/6/2010 10:13, schrieb Hocapito Cheteamo:
> I could consistently reproduce the problem.  The command that I used is:
>     git clone -v git@github.com:XXX/YYY.git sss
> where XXX & YYY are replaced with the actual data.

Just to make sure: This is with "Git for Windows", not Cygwin's git?

Do the clone in separate the steps:

mkdir sss
cd sss
git remote add origin git@github.com:XXX/YYY.git
git fetch
git checkout -b master origin/master

Do you see any errors?

-- Hannes



      
