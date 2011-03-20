From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: Re: About Summer of code idea -- better big-file support
Date: Sun, 20 Mar 2011 20:33:50 +0800
Message-ID: <AANLkTimTWLqkaFkiruqZ8FU8y3YX9C4ujPOPTTJzdRtk@mail.gmail.com>
References: <AANLkTi=Z_4cGBSPQW2YVuj=dd8mcO4YQ0G2owknt7vfw@mail.gmail.com>
	<AANLkTikHigPhaWkiozsurbxjvR5WkAGW9LUtFRT9tK8=@mail.gmail.com>
	<AANLkTikp5GS0gnqLVgZY4E0wBDmQBp1iftOON3MSMHea@mail.gmail.com>
	<AANLkTimH9pgO7JxN3vOcN=Kb3QGpbM7OO4bMpL2eAs=3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 13:33:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1HpW-00012u-7N
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab1CTMdx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 08:33:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63900 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab1CTMdv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2011 08:33:51 -0400
Received: by iyb26 with SMTP id 26so5540983iyb.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 05:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r8Svsmted3CGBEKKetJsY1v0LGMzcx5MFMvLpUbF6WM=;
        b=RCCQ6aVXcMTNGbc1051xXtsX9POAWLYillZtpdiJVi8fuhfwj5+iShDWv0Mi8Ej8Ww
         T9SYp+2+rTXtiA8agm4B8W/aKBJQpRwU8mcjZYFNvCetq6ugwsnqerDU51oVRypoYapc
         CUamCmvn1We0z/xikD5bB+iqXkAnd2zhqhad8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nBxrS6AeWOrm/IOx6MnG6YKUVu3ekFhPawILzE67j1lHpsleRuY6V7s9l+uoecB9WL
         Kx7WO3IPXxxzc0ZZ1Dlgk/DvbexkOHOwyxM5F/RGMcFwd6iCs6md6vosXMn8f27oh+ES
         +zzODi3E/jtvfv4TvJLkVEVluJsi9IMBJ9mX0=
Received: by 10.42.168.198 with SMTP id x6mr4856084icy.273.1300624430921; Sun,
 20 Mar 2011 05:33:50 -0700 (PDT)
Received: by 10.42.174.201 with HTTP; Sun, 20 Mar 2011 05:33:50 -0700 (PDT)
In-Reply-To: <AANLkTimH9pgO7JxN3vOcN=Kb3QGpbM7OO4bMpL2eAs=3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169500>

2011/3/19 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> 2011/3/19 =D0=EC=B5=CF <xudifsd@gmail.com>:
>> 2011/3/19, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>>> See below link for recent discussions regarding big file support:
>>>
>>> http://thread.gmane.org/gmane.comp.version-control.git/165389/focus=
=3D168956
>>>
>>> On the store of big files, bup (at github) model might fit in as we=
ll
>>> if large files change a small portion regularly.
>>>
>> But, why those features haven't merged into upstream developement?
>> Sorry for this question, but I'm fresh here.
>
> This is just my guess. For specific apps, you should pull their autho=
rs in.
>
> All apps experiment different ways of dealing with big files and work
> in certain situations. None is generic enough to be merged upstream.
> Take bup as an example, it aims at big files _only_. A file is treate=
d
> as a directory of many smaller pieces. In order to get it merged, we
> need to separate those big files from the rest because it's just too
> different in handling them.
> --
> Duy
>

Thanks for that timely link, I think I should do some more research now=
 :P
