From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git list files
Date: Sun, 13 Jan 2013 09:56:02 -0800
Message-ID: <20130113175602.GD5973@elie.Belkin>
References: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?B?0KHRgtC+0LnRh9C+INCh0LvQtdC/0YbQvtCy?= 
	<stoycho.sleptsov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 18:56:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuRnS-0007C3-Su
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 18:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab3AMR4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 12:56:15 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:40195 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208Ab3AMR4L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 12:56:11 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so1834709pad.36
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 09:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hDtsL4589uq27zMmvNIWtbxONj7G8dMTyoS7ZCzUQRs=;
        b=GImLpbl8+G/OLS934V7xMF0T6Kpmjsm9+8OEZLW1PMNWCnkKJKLZsnmi5yPn1iA82F
         dSzF/uTT/lOfThhJNMTkfG705LHEhJp+hMn0n6/qbGjqyUgowfsBsM6BZwuauYE5UZMK
         74NntOomN3AtXW+2SZPeKPpxZ1ipvnJgI/KglTZAcg3awB8+0QLV8Eve/jz52JlqcIkL
         pUvslj7l3V+nv+FHzVjguIiCKYocYUREUMfWgn+1vfJobdRxMMBGAcM+22uB2SnrN4oQ
         NT650yoooLWCI/dcV2wCFKx6m7x6I61c4KTH2s0MoFyseX5W9XDri+sTNBP4oafUV+1N
         gzSQ==
X-Received: by 10.68.135.99 with SMTP id pr3mr250146786pbb.151.1358099771050;
        Sun, 13 Jan 2013 09:56:11 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id s5sm7126333pay.31.2013.01.13.09.56.04
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 09:56:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213394>

Hi,

=D0=A1=D1=82=D0=BE=D0=B9=D1=87=D0=BE =D0=A1=D0=BB=D0=B5=D0=BF=D1=86=D0=BE=
=D0=B2 wrote:

> lets, say the equivalent of the $ls -d b* within git.git root directo=
ry
> would look like:
>
> ----------------
> 98746061 jrnieder 2010-08-12 17:11 Standardize-do-.-while-0-style   b=
ase85.c
> c43cb386 pclouds  2012-10-26 22:53 Move-estimate_bisect_steps-to-li b=
isect.c
> efc7df45 pclouds  2012-10-26 22:53 Move-print_commit_list-to-libgit b=
isect.h
> 837d395a barkalow 2010-01-18 13:06 Replace-parse_blob-with-an-expla b=
lob.c
> 837d395a barkalow 2010-01-18 13:06 Replace-parse_blob-with-an-expla b=
lob.h
> ebcfa444 gitster  2012-07-23 20:56 Merge-branch-jn-block-sha1       b=
lock-sha1

You might like Peff's or Jakub's tree blame script.  The newest version
I can find is

 http://thread.gmane.org/gmane.comp.version-control.git/168323

If you use it, let us know how it goes.

Thanks for some food for thought,
Jonathan
