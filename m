From: =?ISO-8859-1?Q?Nicolas_Despr=E8s?= <nicolas.despres@gmail.com>
Subject: Re: git ignore regression in 1.8.3
Date: Wed, 29 May 2013 15:54:03 +0200
Message-ID: <CAPqtr1KUArgPQJ-+UGsjZdtekVwneXX8qWzREkHqOqykTr8L3w@mail.gmail.com>
References: <CAPqtr1KjmqRZZuVwput6=rKJrivb7siYePqT5QEOLJApg+phEg@mail.gmail.com>
 <CACsJy8BT_3aUAO+eMT6F3SWwLOWeFwJ2rxxru-+NtBRD3RTSFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:54:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhgph-0001Tc-IR
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935159Ab3E2NyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 09:54:25 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:42590 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935138Ab3E2NyZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 09:54:25 -0400
Received: by mail-wi0-f171.google.com with SMTP id hq7so3552981wib.16
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hllpBCyFMs7KJnCtxE5S5mFbFDzMGnMrp/xjQ1ZReKI=;
        b=x0WjAXrMQ64wmkhjXf6g/GXJOIYUsqQSgZNI/6NjZm7UOTWaOGJ6j8DzCEVAVPVEqV
         CxVUT87RQNys4SG0wHm4bIhhJF+UvS8qba55pH3HLN09Rl3ZUxwF9MCAELjrhSwPbyBY
         kPYAMBSVRDnOpxb58A9diJIF/omoOmMQmmKnhrHRM1e2CED6pTC1jaUp65NbWGVM9KdL
         ECTx0CpzGIr9PWqCL7Sr76FZJbzpH1f+lsy90s04dUymwdLixuHkYkBhc5yaqzP2ick0
         FZDZmsl0ciKNG4ypaGCqvvdr36r2RrOzjzeWTkf2XLS2T5U9XB3EoF5ajqZGUmY+onhW
         /Riw==
X-Received: by 10.180.87.162 with SMTP id az2mr15902217wib.10.1369835663861;
 Wed, 29 May 2013 06:54:23 -0700 (PDT)
Received: by 10.194.175.34 with HTTP; Wed, 29 May 2013 06:54:03 -0700 (PDT)
In-Reply-To: <CACsJy8BT_3aUAO+eMT6F3SWwLOWeFwJ2rxxru-+NtBRD3RTSFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225829>

On Wed, May 29, 2013 at 3:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 29, 2013 at 7:31 PM, Nicolas Despr=E8s
> <nicolas.despres@gmail.com> wrote:
>> I have noticed a regression in the behavior of ignore rules in 1.8.3=
=2E
>
> Yeah, it looks like everybody suddenly realizes this regression soon
> after the release, not before :( This has been reported three times s=
o
> far. You may want to check the discussion (and hopefully progress
> soon) in this thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/225675/focus=3D=
225713
>

Oups! I'm sorry I searched the archives but did not find this one.
Thanks for your reply and the link

> We really need to add some real world use cases of gitignore in the t=
est suite.

There is kind of one included in to my post (minus the assert statement=
s).

--
Nicolas Despr=E8s
