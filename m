From: =?windows-1251?B?0fLu6ffuINHr5e/27uI=?= 
	<stoycho.sleptsov@gmail.com>
Subject: Re: git list files
Date: Sun, 13 Jan 2013 21:16:14 +0200
Message-ID: <CAGL0X-pvarMepj6px74zcuwPxcF288-LnBE0bG-Wapzx4fQ1ZQ@mail.gmail.com>
References: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
	<vpqhaml9pr3.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 13 20:24:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuTAi-0006EN-06
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 20:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943Ab3AMTYW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 14:24:22 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50554 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab3AMTYU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 14:24:20 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so2469462lbb.19
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5bNHLUYiyVJ/paUspjjFp1v0ndMetkDqEbs9ZX602wY=;
        b=hmnLCFvkgBJ+y5Ebd8KRr2RgRUpD5+tsZHksQqXJ0BhBK1OWWJxvEzAXP/sLgHEoKF
         PUDnGgXhTZeOQfXU2OguQpSiXzQneyESpCKSCVMf2y1+vqyc55Kozr8GmEYOuka5P3PJ
         E5tK6Fn9m+7fYGifbTDZxMsclb85uEIWUCXOo4cHhMI5A4ce4VkC8L2VJyog1aSV2NAV
         sR51Cwh91eMZQwBvc+Ut8pFU6RJaT/jtG7ChviQQy8LWLSeYQw5oZjohlJs4x5E64qxM
         UViqeMXRAq5292JqLCHJ1fZ6pPt+RLGExeuuQFRvfE698tY7wl8H6nE2Vnk/1uh/sV7y
         DIKw==
Received: by 10.152.145.37 with SMTP id sr5mr22755029lab.33.1358104574841;
 Sun, 13 Jan 2013 11:16:14 -0800 (PST)
Received: by 10.112.60.36 with HTTP; Sun, 13 Jan 2013 11:16:14 -0800 (PST)
In-Reply-To: <vpqhaml9pr3.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213396>

not really,
ls-tree provides the hash of blobs and trees,
what I am searching for is"the last commit"who introduced the blob or t=
ree.

but, hey, thanks for the answer!
Blind

2013/1/13 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> =D1=F2=EE=E9=F7=EE =D1=EB=E5=EF=F6=EE=E2 <stoycho.sleptsov@gmail.com>=
 writes:
>
>> Hi,
>>
>> I was searching for some git- command to provide me a list of files
>> (in a git directory), same as ls,
>> but showing information from the last commit of the file instead.
>>
>> lets, say the equivalent of the $ls -d b* within git.git root direct=
ory
>> would look like:
>
> git ls-tree HEAD
>
> ?
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
