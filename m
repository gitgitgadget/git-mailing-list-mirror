From: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
Subject: Re: Error on git clone
Date: Wed, 6 Oct 2010 01:13:14 -0700 (PDT)
Message-ID: <960844.34400.qm@web114603.mail.gq1.yahoo.com>
References: <193301.7835.qm@web114608.mail.gq1.yahoo.com> <4CAC18C7.8020302@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 06 10:13:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3P7s-0004CQ-Ma
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 10:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758671Ab0JFINR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 04:13:17 -0400
Received: from web114603.mail.gq1.yahoo.com ([98.136.183.20]:41012 "HELO
	web114603.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757252Ab0JFINP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 04:13:15 -0400
Received: (qmail 36770 invoked by uid 60001); 6 Oct 2010 08:13:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1286352794; bh=sMCyWZGOtOYDn5NJ3iZHa2hX/tzUXEvoCGoR6vj8HmQ=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=iOvhp0ULeApnQGuWeDA9MwMOlM5FHaKvfAtPAf1Y6O5r6ARt1VKUMbif+ABuLjfbMiYNXeT021+xd4YjXliTrjV+AHuLuqsaWeEFE2WvSw6lTER1KeSeaD3U5FYh+HNEcgQ8PqjK5qmkggnF3+iR7MmViT4WJibYP4E6p/SE6FQ=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=LvpT3UztaxXaBzNXOSXru6NdeoIt7SPv62KC5130T3uPvLP2GwA1JXDHIaq3NRJ4hTRAleP+CyaZMxjK/ZxAUv4mmgT2DuuOXosKdGkLbf4uhTNB96byhDL19g9PqtJvJkUnBDSCkIfR7w9ZDZB1+fJtznR3rROH1hwtOnXmG7U=;
X-YMail-OSG: mvxAw_MVM1n8VZhvMlsyiJB3n.lHDPYFpMnpflxJvGZgK95
 y6nq0Kb2SE1DJWYEbTGmH6iOrbzDsOmz4AEkyM7iNvCQp1FiRVRtbghfYorR
 kliXHcumzPCaysIl9_bBFfnM7UsdkHquUXulDkoRXb8xPdKVyu3jYH2k5zld
 pZ_TcqW0PzsTt9xrUHhxEThnP7iXJMgVYHBrwz01EqDAnVeJIedE26bZAa8Y
 8StuGh6WfI.xXWt11_7AcF0jBHBSy5bMkhWrixh0L0V0cY_0l0lDVKwoGQyU
 8tOGLfB8-
Received: from [76.83.7.252] by web114603.mail.gq1.yahoo.com via HTTP; Wed, 06 Oct 2010 01:13:14 PDT
X-Mailer: YahooMailRC/497 YahooMailWebService/0.8.105.279950
In-Reply-To: <4CAC18C7.8020302@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158271>

Hi Hannes,

I could consistently reproduce the problem.  The command that I used is:
    git clone -v git@github.com:XXX/YYY.git sss
where XXX & YYY are replaced with the actual data.

The additional log messages from -v option do not help much.  (See below)

To prevent the print over of the log messages, do you think I could use
1. any other option on git clone;
2. redirect the log messages to a file; or 
3. pipe them into a tee command?

Or do you have any suggestion on how to prevent the print over of the log 
messages?

Thanks so much again.
Hoca


$ git clone -v git@github.com:XXX/YYY.git sss
Initialized empty Git repository in c:/.../.git/
Enter passphrase for key 'C:\.....\privateKey':
Server supports multi_ack_detailed
Server supports side-band-64k
Server supports ofs-delta
want 713.....8ef (refs/heads/master)
done
remote: Counting objects: 478, done.
remote: Compressing objects: 100% (303/303), done.
remote: Total 478 (delta 21), reused 436 (delta 3)
Receiving objects: 100% (478/478), 96.57 MiB | 156 KiB/s, done.
Resolving deltas: 100% (21/21), done.
tagging': Invalid argumenttory at 'public/images/tagging






----- Original Message ----
From: Johannes Sixt <j.sixt@viscovery.net>
To: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
Cc: git@vger.kernel.org
Sent: Tue, October 5, 2010 10:35:51 PM
Subject: Re: Error on git clone

Am 10/6/2010 6:20, schrieb Hocapito Cheteamo:
> Hi,
> 
> I'm a newbie on using git. I installed Git 1.7.0.2 on my PC laptop running 
> Windows XP Prof. SP 2.  When I run the command,
>     "git clone git@github.com:......git sss", 
> I got these log messages:

You didn't show the command that you used.

> Initialized empty Git repository in c:/...../.git/
> Enter passphrase for key 'C:\.....\privateKey':
> remote: Counting objects: 478, done.
> remote: Compressing objects: 100% (303/303), done.
> remote: Total 478 (delta 21), reused 436 (delta 3)
> Receiving objects: 100% (478/478), 96.57 MiB | 148 KiB/s, done.
> Resolving deltas: 100% (21/21), done.
> tagging': Invalid argumenttory at 'public/images/tagging
> 
> Does anyone have any clue on what this "Invalid argumenttory" error is all 
> about?  It did not finish unpacking all the files in folder sss.  It aborted 
> after this error.  Thanks so much for the help.

The error is "Invalid argument" and was printed over a line that said
something about a "repository". Can you reproduce the problem?

-- Hannes



      
