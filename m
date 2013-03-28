From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: which files will have conflicts between two branches?
Date: Thu, 28 Mar 2013 12:17:18 -0400
Message-ID: <20130328161717.GC23946@google.com>
References: <5153694B.2010405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:17:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFWW-0003yQ-BR
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757052Ab3C1QR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 12:17:26 -0400
Received: from mail-la0-f74.google.com ([209.85.215.74]:63508 "EHLO
	mail-la0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757000Ab3C1QRV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:17:21 -0400
X-Greylist: delayed 766 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2013 12:17:21 EDT
Received: by mail-la0-f74.google.com with SMTP id fo13so708478lab.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 09:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8mwWGuamw5w88mvYnUV+l29HVOh9UqEoGd+od1D7rro=;
        b=DRY8bpLeu0iZMIs/Tt41v2AH/rYPz+Fd9WQeAUsWuADPw432yB93gPE5jXOIylf5Vf
         3ocvbVXqjlp1AkOUoKaxggQdPg4u40CMmlyGDAcHVJ3Dxe0HC0g1IB3vKkynWHjHUxI/
         0nVlKC0fny+3tfGyhOJTBRvhWx9tsJClDaiqZMEmqPYbMmmqtN7G3/NEtd1Yoa5oHmJm
         MoqY8UKWfVvnmr2ocIDmmga78kKWHdVEkqSX5JyjcLYELLFSa23IC0dVibgoGL9mRFjZ
         gYZZq2shtwqtMj7TWPCxtM1wpg1M8yqxojgXe3DIcsWYTWBOY0nHlc6kO4v9CLOCfuha
         VLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent:x-gm-message-state;
        bh=8mwWGuamw5w88mvYnUV+l29HVOh9UqEoGd+od1D7rro=;
        b=W94PEb2xiQ7SKcu6JL0uvVFczCDHsz8pq4qcpaAXHSe/yLLkefWfayBG3XQa5jHCrj
         OxG26mS3SFgnqfHF+cJTfYDmfTuIaBZCiRDVdDwtKbpYztJPHefKauX35rGPjEWqMKmM
         1xJfCQQmAjxsR5ATnunSy7x6Zb2MfHaQvC7uIzFxasfdRHDhuEM/qib6H4XxtCdpkSek
         uXLSnjAFByV6zQEQn1YxOfvKspH5eVncYJwTG+YSTZsAbZ7HpSxiGEvdYUcCMZkNRtxW
         6+U4ZHkuM7ig1WhDiLqy9xAlJAR4UuauDTiAY0XZnGYL5mmqTH5cCmwPAFkBEOvayzsF
         bU5Q==
X-Received: by 10.15.21.137 with SMTP id d9mr28233511eeu.1.1364487439642;
        Thu, 28 Mar 2013 09:17:19 -0700 (PDT)
Received: from corp2gmr1-1.eem.corp.google.com (corp2gmr1-1.eem.corp.google.com [172.25.138.99])
        by gmr-mx.google.com with ESMTPS id 47si5651055eeh.1.2013.03.28.09.17.19
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 28 Mar 2013 09:17:19 -0700 (PDT)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-1.eem.corp.google.com (Postfix) with ESMTP id 73ABA1CA1D6;
	Thu, 28 Mar 2013 09:17:19 -0700 (PDT)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id DB2BD40658; Thu, 28 Mar 2013 12:17:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <5153694B.2010405@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkfYcoA2l5f3R+1+4q6DgO5G6AJGr2lymXYYSt5O/zgroDBwqF07BSSQFbXXLUPQufDR5fynIgonsRQzevl7jt8+5hFs/ai7eX3+pqJY+8fKKTQHpGKcI1d0SMs5us3nUa88Mz0NUULys739PDvDDkVhCQbHf6JViq9MUCRg1X10jtkepIpw5gjyZt0BYFgCmoZMrUa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219421>

On Wednesday, March 27, 2013 at 17:48 EDT,
     "J.V." <jvsrvcs@gmail.com> wrote:

> I have two local branches (tracked to remote) that are in sync (did
> a git pull on both branches from their corresponding remote).
>=20
> Is this the best way to merge?
>=20
> I would be merging local/branch1 =3D> local/branch2 (test this branch=
)
> and then push local/branch2 =3D> origin/branch1  (and would expect no
> merge conflicts if anyone has not checked in anything.

Except for maybe unusual corner cases I don't see how the merge order
(branch1 into branch2 or vice versa) makes any difference. If nothing
has happened with origin/branch1 since you merged from it to your local
branches the push will succeed. If there have been upstream commits
you'll have to update your local branch first (which might result in
conflicts) before you'll be able to push.

> Also with two local branches, Is there a way to get a list of files
> (one line per file) of files that would have merge conflicts that
> would need to be resolved?

You'd have to perform an actual merge for that, perhaps with
--no-commit to avoid creating the actual commit object. Inspect the
"git status" output to find the files with conflicts. In a script,
use "git ls-files -u" instead.

--=20
Magnus B=E4ck
baeck@google.com
