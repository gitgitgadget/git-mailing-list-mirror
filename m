From: debugging data <debugging.data@gmail.com>
Subject: Re: push rejected (non-fast-forward)
Date: Tue, 25 Nov 2014 19:16:11 -0500
Message-ID: <443C531A-FD94-40F2-B661-209F6327A1A0@gmail.com>
References: <C2E11014-CFE8-490E-A21A-DB42CC8E4175@gmail.com> <xmqqsih7rsyu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 01:14:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtQFF-0001m6-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 01:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbaKZAOF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 19:14:05 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:38816 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaKZAOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 19:14:04 -0500
Received: by mail-yk0-f169.google.com with SMTP id 79so799713ykr.28
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 16:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=d32vu/pDotAtZ9cAthmiG9gNVL3X+jMGcoUwPCsRtOw=;
        b=w8vmYP4LIraSqNar5ljGSVM1NvA+PIzYY/ee/EyvDoobffH27CAgMgic5CwoEeY0yO
         9wE16ZBVycDz9C2iLsG2Az772/o77eC9IJUTa3PoHyz1Rwl+3vxNP7xC8iZ98mREVaB7
         MeSK0kew5KhQ1OD6d3jgBQUtTuFKd9Lq2sidvXiSf1h3ov6GlnupwrLeC4LhJwOW3TlN
         k6UGUUPdqiSXyT5FJvIds/SmNqtLeefe666shZx2ATNR+8R1Ys0zvIO46Vm2E29ZIqRE
         ogQukGDRoV8Lu0UKRowm5GyW3WyMBCx9g2moY8fvzJJMSGPm+CZUBa9DY05AGgO5Mhdx
         gcZg==
X-Received: by 10.236.230.40 with SMTP id i38mr27767533yhq.34.1416960842805;
        Tue, 25 Nov 2014 16:14:02 -0800 (PST)
Received: from [10.0.0.15] (c-69-136-29-70.hsd1.fl.comcast.net. [69.136.29.70])
        by mx.google.com with ESMTPSA id c76sm1442082yho.12.2014.11.25.16.14.02
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:14:02 -0800 (PST)
In-Reply-To: <xmqqsih7rsyu.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260253>

Thank you Junio.

Do you know how the

    $ git pull origin so-much-foo`=20

command manages to keep user-two=92s branch up-to-date with remote?

It seems counterintuitive since I am pulling from origin and not explic=
itly working with remote.
=20
Would what you see here been an acceptable scenario?
https://github.com/user-one/project/pull/1

I performed a `git pull` and merged the changes manually. This looks li=
ke an awful lot to keep track of, and I=92m not sure if it=92s acceptab=
le for larger projects.

My goal here is to prepare myself to help out with a large open source =
project.

Also, if anyone has the patience, would you mind explaining what=92s go=
ing on here?

$ git show-branch FETCH_HEAD so-much-foo
! [FETCH_HEAD] changed foo/foo.txt contents to "so much foo"
 * [so-much-foo] foo/foo.txt from "so much foo" to "foo\nfoo"
