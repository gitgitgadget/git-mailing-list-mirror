From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: About Summer of code idea -- better big-file support
Date: Sat, 19 Mar 2011 22:13:17 +0700
Message-ID: <AANLkTimH9pgO7JxN3vOcN=Kb3QGpbM7OO4bMpL2eAs=3@mail.gmail.com>
References: <AANLkTi=Z_4cGBSPQW2YVuj=dd8mcO4YQ0G2owknt7vfw@mail.gmail.com>
 <AANLkTikHigPhaWkiozsurbxjvR5WkAGW9LUtFRT9tK8=@mail.gmail.com> <AANLkTikp5GS0gnqLVgZY4E0wBDmQBp1iftOON3MSMHea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?5b6Q6L+q?= <xudifsd@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 16:13:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0xql-0004Sz-N5
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 16:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab1CSPNv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 11:13:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36841 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab1CSPNt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 11:13:49 -0400
Received: by wwa36 with SMTP id 36so5910056wwa.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=2U687xg3PK7hHYtZJk/jICjTh3N5GSErlW4NGttSua4=;
        b=aBkrMghP7NK+jbVrLfKSaZvnPU1cWt/rQLRkrsye3xQdOlm8rAmvCPNc/jPOJqjnIJ
         ZdTrWsXNdEN9BRlTIH3RfV4lENtYy2DDrsL2myVDk0crYFNSNy11xsN2We8I6Iowhx4u
         cR+PSkt2tnZ52hFPVtvPxFYTBTmB8v+eltf0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IIiUACVOrim8LZCWTPVQHwc2xzqHOkcWLEIK8lkceyCSKP1G1U23TGz4g78xWXiGIl
         8OQItKfVrHm7R0NIOlLmkgA1R6skLsfSKbrau1gQ+Ax0lKQKVQYRn845O+bzvO/Nz1pD
         ozmfxnT0OAXAVMLpkdJKrz2+FALoZwHSw1o3g=
Received: by 10.216.120.129 with SMTP id p1mr2416168weh.81.1300547627079; Sat,
 19 Mar 2011 08:13:47 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Sat, 19 Mar 2011 08:13:17 -0700 (PDT)
In-Reply-To: <AANLkTikp5GS0gnqLVgZY4E0wBDmQBp1iftOON3MSMHea@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169435>

2011/3/19 =E5=BE=90=E8=BF=AA <xudifsd@gmail.com>:
> 2011/3/19, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>> See below link for recent discussions regarding big file support:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/165389/focus=3D=
168956
>>
>> On the store of big files, bup (at github) model might fit in as wel=
l
>> if large files change a small portion regularly.
>>
> But, why those features haven't merged into upstream developement?
> Sorry for this question, but I'm fresh here.

This is just my guess. For specific apps, you should pull their authors=
 in.

All apps experiment different ways of dealing with big files and work
in certain situations. None is generic enough to be merged upstream.
Take bup as an example, it aims at big files _only_. A file is treated
as a directory of many smaller pieces. In order to get it merged, we
need to separate those big files from the rest because it's just too
different in handling them.
--=20
Duy
