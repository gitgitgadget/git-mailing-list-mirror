From: Eugene Sajine <euguess@gmail.com>
Subject: git gc error - cannot lock ref 'RENAMED-REF..1'
Date: Thu, 1 Apr 2010 22:08:45 -0400
Message-ID: <g2x76c5b8581004011908r35cbaf3au545b7f11bd6db8fc@mail.gmail.com>
References: <j2k76c5b8581004011037rb81d80cdu1a4713cde31d4b56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 04:09:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxWJr-0003Ga-Vp
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 04:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001Ab0DBCIt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 22:08:49 -0400
Received: from mail-gx0-f209.google.com ([209.85.217.209]:38579 "EHLO
	mail-gx0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0DBCIr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 22:08:47 -0400
Received: by gxk1 with SMTP id 1so1391756gxk.16
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Rq+j2HG5pJ6ImeJZqBN75TCnMGAtLHImvxrNJ7Uufng=;
        b=fOFFBmPW/z3UYiCU/qQiA0EA3CWE458HOT0GHdFoLx4WjKDdp1dT63SJHpeJC86ECO
         wulYFkkUs9d6/LHsfROGEyZgmSm4zud25fQy2dP8Ji1D38jGn3otE6Q+ygfYExGjHI81
         6y6EXoXfuhGYKPG7ERBaFRgHWjntbRz/mAI1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Yf41QNce/ThczKFbneBJHev02YmbPoNCXdqbrH9vp++FEYXe0h8f4OGeQ+bON+wAwR
         POR3JO4xYZrZhLKkn8zYKKrLAj3+KGhRKCJStspiCW2z1gVft5IP/qmz+Okx05jI5d+Q
         KaLP3SLAVhoBU65XNNtgyxWOCaLHWR87IveNI=
Received: by 10.231.155.143 with HTTP; Thu, 1 Apr 2010 19:08:45 -0700 (PDT)
In-Reply-To: <j2k76c5b8581004011037rb81d80cdu1a4713cde31d4b56@mail.gmail.com>
Received: by 10.151.28.13 with SMTP id f13mr2243422ybj.143.1270174125403; Thu, 
	01 Apr 2010 19:08:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143771>

Hi,

I was running git gc weekly on my machine and today for some reason it
failed on one of my repos with an error saying

Error: cannot lock ref =E2=80=98RENAMED-REF..1=E2=80=99
Error: failed to run ref-log

The problem is I have no idea what it is talking about=E2=80=A6 =E2=80=9C=
git show-ref=E2=80=9D
doesn=E2=80=99t show anything even close to this name. Fools day joke?;=
)
Any advice?

Thanks in advance,
Eugene
