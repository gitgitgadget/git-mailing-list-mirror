From: Stefan Beller <sbeller@google.com>
Subject: Re: Minor Bug in Renaming Branches
Date: Mon, 6 Jun 2016 12:35:25 -0700
Message-ID: <CAGZ79kb77m8ymDkJGMaWi8yOdSphpYifDPHQ=+nZMBhRi47i9w@mail.gmail.com>
References: <CA+wHs3MSax1eo9V_5hnsbEte0k5tX22dAgSUAEzN7aw22rUnhA@mail.gmail.com>
 <54505ef2-7db6-8bc4-0ffb-0ac28c7d6046@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Samuel Lijin <samuel.lijin@formlabs.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:35:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA0JC-0007n1-BH
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 21:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbcFFTf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 15:35:29 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34097 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcFFTf3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 15:35:29 -0400
Received: by mail-qg0-f44.google.com with SMTP id p34so47740950qgp.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wApMewSAb+jpFAcW02ZEZlFA1G7Y+U1Tei5GwunrYjc=;
        b=FVd48mj8w8qO6ZManq/iJm462sa6wgmvj1tep2abZOQ90JWO8ovvtFfdsue0N/9pg/
         x60Cf6oHLIp8ytcu4+GuXYGVPFHWv1Kll9t9Yom2DsksPXSuLnhn9zjVY0/d+XfvcqYh
         IRwjgeED8oSqkJHFPswuQaBtzeru2Z3ISqrEyF7hJ9JNeWNfW+bJH0tQA4qJnkwrbypR
         tjPWC0UZS2+9WyM0uPOtZZuBAMhf6Q5ZsQoT/TQBmpr7s7Oa0x3rBi/IRdZ6d2PzXZAl
         1sZJQyUn+PYq4cUOae4TejyiKZdaLpyV/ckBekGdWAD0a2WqUCjj/FRdk3D+D1pnQc2P
         Kvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wApMewSAb+jpFAcW02ZEZlFA1G7Y+U1Tei5GwunrYjc=;
        b=mRl+vyTuTZB0bDi4E0Z6NJLLC6wIR1iu+CyI9EJRjh1R3y920NmKeOOt/lh68VcxHV
         xe1N0iPerg07BKMQkBIXMuhjGxPsd8GGvE8ZJCfa5xmpPjnT3P4zrBZn3GyQJbEnRwtJ
         KauFNNSfLVQgE4YboMgBpGFM3yUYwbxiF2i0y4fkLj6wlJ21HmMzn5pub4UFqB+oVXrx
         p2h93YaMyRL5kNFwU6Zbd36IucVAdNHpJdfI8wmPz/1jzWweGYmCca3mgZf114va6BnG
         IFoHAOd1WrLWkOH7tZmQSMj37Rxa7/f2FgtmTdsgNvLEJ0vGEqMz0SIhc526hDbietBw
         c6Dw==
X-Gm-Message-State: ALyK8tIaTGX7xGb0eVVg2XFBl5wTqb3silO7N4bLa5CH1wvz/BCkHcZmK0slzLo6k8U2USoM7rby8ZhrEDD7fxGQ
X-Received: by 10.140.81.145 with SMTP id f17mr16784510qgd.84.1465241727946;
 Mon, 06 Jun 2016 12:35:27 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Mon, 6 Jun 2016 12:35:25 -0700 (PDT)
In-Reply-To: <54505ef2-7db6-8bc4-0ffb-0ac28c7d6046@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296557>

On Mon, Jun 6, 2016 at 12:17 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:

> A limitation is introduced by Mac OS and Windows:
> BRANCH/NAME and branch/name refer to the same object in the file
> system.
> As a workaround, you can pack the branch names:
> git pack-refs --all


Once you packed a branch into the packed refs file, you can
create another loose branch of different capitalization,
which then 'hides' the packed ref?

That sounds error prone to me, as a seemingly unrelated branch
changed its value:

    git branch BRANCH 012345
    git pack-refs --all
    git branch branch BRANCH^
    git rev-parse BRANCH
    (I'd expect BRANCH^ as return)

(I don't have a windows machine for testing here, so that
is pure speculation)

Thanks,
Stefan
