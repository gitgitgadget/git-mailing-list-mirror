From: David Barr <davidbarr@google.com>
Subject: Re: How to reorder all commits include the initial commit
Date: Sun, 18 Mar 2012 01:06:56 +1100
Message-ID: <CAFfmPPOhjDhdry2yqgSyAVhaPF-fhXOPOAWRahFkFFssQmz89A@mail.gmail.com>
References: <CAFT+Tg_DmqxiK1qw1YvNZtY07ZaZ89+JWohdWw2fm8f=6hAwiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 17 15:07:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8uHf-0007Th-Kq
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 15:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab2CQOG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 10:06:58 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55896 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab2CQOG5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 10:06:57 -0400
Received: by yhmm54 with SMTP id m54so4939569yhm.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=Jnyoo8Ns7ht0nhHtRgy0/u3+1nz0XRHClUqQY3EmUOk=;
        b=ctAm/YvRPuM1BiRzD706WRuPxvyPndBmtv+aRrR8LPcsl3G7+swqekNyOmCs+jTMat
         GHOlhRvzPrR2u7SR4zgixlA/lOg6QENXf29GJRuWCcKomsfDwVK6RGee+wWmlx5QI2Ly
         ZLoloq2WY9Q761i1u+BP/i3mDjkPWbT8rz0/7GPhu6a7PZ8FXMfmyjOgOfNitgWn1vbB
         0aJNyfldxuqUN3g1btRGbdwAXR2GhtFoVt3/6GchdafVaornWyDASsvc+Tasac4VHZZp
         +fdCjJzfJ0w152W0xGdo123CCxZ8J6VYyKqWFjks23TxpboRIFGdzd1UkEv6e7zcVHKb
         NhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=Jnyoo8Ns7ht0nhHtRgy0/u3+1nz0XRHClUqQY3EmUOk=;
        b=RjUuUFNtiO6DhTCU3dwrrYLBvZ7hGoRJzYYULlVDFK3PhL9OPOuPTBDDZF9b6ej1Sj
         k4gFNSo2Q7ttZKHwGCupAqBrXUWX1Mbu5Uo14CjW2/yLwIqj+xBwbghjSlmSVZ4qJra2
         Ra5WOh+ebl2vMyvQQyRbU3zZL+0xYMQRRnoV+2zzoWSRB7cFGP8J7p0p4VqNT5Vla8mc
         enumHuHJPNRkPw/3GPlx2LVQYM6eEvn6ipk5XOaARRO7n2B738XuNQy4tj8lEKpZIXab
         F6CfIdhQ9vK7Ot/XePjqhi5Ewj5piHslDWETvQ54QGKY1BdSI/OrinMEfJ+7ROMC3sBj
         1RNA==
Received: by 10.236.173.195 with SMTP id v43mr6603057yhl.40.1331993217019;
        Sat, 17 Mar 2012 07:06:57 -0700 (PDT)
Received: by 10.236.173.195 with SMTP id v43mr6603051yhl.40.1331993216909;
 Sat, 17 Mar 2012 07:06:56 -0700 (PDT)
Received: by 10.101.154.34 with HTTP; Sat, 17 Mar 2012 07:06:56 -0700 (PDT)
In-Reply-To: <CAFT+Tg_DmqxiK1qw1YvNZtY07ZaZ89+JWohdWw2fm8f=6hAwiQ@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkvKHvzRa8Q6G1mEj74QJHrJRXSNPlluF02eU8E+9VAV97iD6VcPukGPteBmszAmukbYBE+1VP4Pg1yC+Y3Jcz07zObNu3RC5D/+WaDQ8R3zkMOpqjHWu1euOKNnw5hbX5scGQKiBk0KttKUXckDEGWU0B/hQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193325>

On Sun, Mar 18, 2012 at 12:15 AM, =EC=9D=B4=EC=9D=91=EC=A4=80 <semtleno=
ri@gmail.com> wrote:
> Sometimes, I need to reorder all commits, which include the initial
> commit, in my branch.
> So I tried it using git-rebase as follows, but it failed with the fat=
al error.
>
> (supposing the initial commit is=C2=A0793ea88)
> $=C2=A0git rebase -i 793ea88^
> fatal: Needed a single revision
> invalid upstream=C2=A0793ea88^
>
> How can I do that?

=46rom my reading of git-rebase(1), this is currently unsupported.
However, I was able to reorder linear history including the root using
git format-patch and git am.

  git init test
  cd test/
  echo a>b
  git add b
  git commit -m '1'
  echo c>d
  git add d
  git commit -m '2'
  git init new
  cd new/
  git am ../0002-2.patch
  git am ../0001-1.patch

--
David Barr
