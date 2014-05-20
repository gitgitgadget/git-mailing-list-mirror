From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: untracked file deleted from the master branch, when checked out to it from a local branch
Date: Tue, 20 May 2014 23:50:17 +0630
Organization: CognitiveClouds
Message-ID: <2726779.MFtIaLB4b4@linux-wzza.site>
References: <2525467.KRXv8a3gWS@linux-wzza.site> <1949847.AaDQEtxZHd@linux-wzza.site> <537B8BA9.7060207@storm-olsen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 20:20:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmodt-0006zW-I6
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbaETST6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:19:58 -0400
Received: from nm31-vm7.bullet.mail.sg3.yahoo.com ([106.10.151.198]:31153 "EHLO
	nm31-vm7.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750766AbaETST5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2014 14:19:57 -0400
Received: from [106.10.166.116] by nm31.bullet.mail.sg3.yahoo.com with NNFMP; 20 May 2014 18:19:55 -0000
Received: from [106.10.167.135] by tm5.bullet.mail.sg3.yahoo.com with NNFMP; 20 May 2014 18:19:55 -0000
Received: from [127.0.0.1] by smtp108.mail.sg3.yahoo.com with NNFMP; 20 May 2014 18:19:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1400609995; bh=YVvViLo9IVF9IY8nx8kzGLrd8sxcSkySoGntYshtEhU=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=YN5vgEGFrPi7vZKN87zwSzWbGCYcH/3+/9j02nQ+YwkxA4PILuZDj0/RrWO6yVu+2sAvHrthm/sxuY5rY7LupfRtxckYce0+nB/EhX+mHigicGjSjLRi4D9B/RN+26h06m5KubMIyQmS4/JloMkdUEhkAQcz8ufDragyEvqjJpY=
X-Yahoo-Newman-Id: 274329.61949.bm@smtp108.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: NmlA7nYVM1mnNd5lPTuwOupsAR2wawmvCHhOGL3.IqdFnI2
 EulpChVFUpO90.X_I8jmRwSXXoJ4BBXCwbw8.q7_6.Px6N0uzAb5K2IXB4c_
 b_FE_B9jKKisR7mA4xtVKgobosfc0IKUdTXHBocX3eC0JuW8mkXQKLrPxBNd
 RS0fVVKofvsFqj6iao8LlhtwgpBhk7rr.4gbMPQXmbSLCxCzb6284wmcspWx
 dos5YgE7LAnaF8t4rof1ar0WeVM37yhr5rHJLJ96KE5tEFuesECRhxluFITQ
 4CpZ.tSuiSIk_bvA9HdRukAyIgIagWlncZjukofo6W.BnTeZfz_80jZkWMgp
 xKDXCLNeke5jDB8oUzYlVRiIFqTQ94567kuroqFnJuZ44WZoirsqbTplWyTF
 Z7c7TfRa47vOPDiKuR4tfP_6ruD1lDcKSJj3NWgHdqyBuRq7WdCkjxZSd0sO
 Dfko7oTZib4L8bn8pqrE0.2MAJ0h7vWd3jV9PIDpnQOKPk4PoxQ6Ascz0g4B
 Ixuj5v3mW_yhES0.mkCJOKzgzLdh7F5xEJk55CsaOyXRKrmzABx_JvQp3IOP
 uZryQOQylPOjRAQ--
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@101.222.245.191 with plain [106.10.150.171])
        by smtp108.mail.sg3.yahoo.com with SMTP; 20 May 2014 11:19:55 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-7-default; KDE/4.11.5; i686; ; )
In-Reply-To: <537B8BA9.7060207@storm-olsen.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249716>

On Tuesday, May 20, 2014 12:06:49 PM you wrote:

> 
> It never "came to the new branch", as it was never version controlled,
> it was an untracked file left behind when you switched branches.
> 
> Once you added it to the new branch, change_class, it became a version
> controlled file, 

This is still  didn't get it. If an untracked file didn't come in the new 
branch, how would I able to add it to stage ? I am not getting this part. You 
are right, but I am not able to understand this one, my bad! :(

-- 
===============
Regards,
Arup Rakshit
