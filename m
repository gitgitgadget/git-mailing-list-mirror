From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: merge help
Date: Wed, 27 Mar 2013 10:10:40 -0400
Message-ID: <20130327141039.GA11161@google.com>
References: <51521C1B.3080307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 15:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKr4I-0008W0-Nk
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 15:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab3C0OKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Mar 2013 10:10:43 -0400
Received: from mail-gh0-f202.google.com ([209.85.160.202]:61437 "EHLO
	mail-gh0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab3C0OKm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 10:10:42 -0400
Received: by mail-gh0-f202.google.com with SMTP id z10so484910ghb.3
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LAhj/B4CdHu4QQ5FRVrtOCNt2oD5PBSdfutPIIu5yM0=;
        b=YnRWD9IYneEbJsPJBYSCoBwjxwSe1KNpv6g1/LNRZmUcTlN7jUGeqszl1QMxbvMnH4
         JmMbqtcmqsZ5sT/pryfToQAQV2FskG2dRnEvUgrasMH7fyCRiy3YdMy/iVQrBx4NzCO8
         +x8CPPJerQN9tdrKzxvO+/aSLBKcVxU5rp2brBcQsjrjl6pzrRF56FJWEma8HmpfnyVa
         a3WSYkmrB1xe29G1phfnFYtKo6YkIofbJQhLOFMeajRXPzB4L4nhGVp3qK6utH5HNu0A
         ISuUvzZGsiSi0D5lrPLo65+GzgQqJDt0z+eha+IZegAd81TGn2vR7nh8SgH1QMmTfomK
         xhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent:x-gm-message-state;
        bh=LAhj/B4CdHu4QQ5FRVrtOCNt2oD5PBSdfutPIIu5yM0=;
        b=iDZRhhJ4H7qi4UFdl13dXtPPW8Z4iFp0xu1WOhCE1JksqHAmMlz5VHYkkUbOfMA+WQ
         L7G7z0ahHL0tpgmgzTgIyyjrxWKPstte4M18JTT/mfBrszT+mvzjI8/AfkIJfxALxJUI
         t7v7OIfYYyN7i5Kb7iDgjvxxr5GOGJlzJ4vPa7Qzh1ENOYGbZMmpi50jIEoD3SPM38zB
         ovIkhG/ejVZIoLw204nPeWdq4itixeEL71qcZMtvI27EgdSdm4uUC9HcceleSWEGTVAZ
         T98624fgg3hfQ1Owtx2GIVZXCdLG26DeKfpNtdegiePWwTyGF+GwN2em+Fpii51xK5o0
         ku5Q==
X-Received: by 10.224.185.201 with SMTP id cp9mr11613636qab.6.1364393441330;
        Wed, 27 Mar 2013 07:10:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x1si3136472qci.2.2013.03.27.07.10.41
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Wed, 27 Mar 2013 07:10:41 -0700 (PDT)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2AF275A4005;
	Wed, 27 Mar 2013 07:10:41 -0700 (PDT)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id B557040717; Wed, 27 Mar 2013 10:10:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <51521C1B.3080307@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkQPN2DBUxbrEkMGTR5cnlkErHw3R71+8KhwcarIoRqgaswS5m66Z7bTbNDl8anXuCyoOeQ5pFGXvNK9UMh3HMOjoMyJfqjoIztMJynBNuiMSvLuGTSApTY9qnkqt1DjBDqgqeanRmQL5gE3ZA+nhSHsYOX3Yv7l/Y4Cvkf75cVwRTsWulGiI/KDuiSKGIPBrLGQAdq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219250>

On Tuesday, March 26, 2013 at 18:07 EDT,
     "J.V." <jvsrvcs@gmail.com> wrote:

> I have a branch for which I have made 0 (nada) changes.  I did the
> following:
>=20
> $git pull --rebase --no-stat -v --progress origin mybranch
>=20
> I get the following
>=20
> U       java/Profile.java
> Pull is not possible because you have unmerged files.
> Please, fix them up in the work tree, and then use 'git add/rm <file>=
'
> as appropriate to mark resolution, or use 'git commit -a'.
> ----------   (there is no local master branch), because of the
> conflict I was put on (no branch)
> * (no branch)
>   branch1
>   dev
>   tmpWork
>=20
> Question 1)
> Why did I get a merge conflict if I have not changed any files?

The error message indicates that you already had a pending merge
conflict when you initiated the pull. Why you had that is impossible
to tell.

> Question 2)
> What is the command to show the difference between the files? (is
> there a visual tool that would let me merge)?

You're looking for this form of "git diff":

       git diff [options] <commit> <commit> [--] [<path>...]

Example:

       git diff origin/master HEAD -- file.c file.h

There are many graphical diff and merge tools that you can configure
for use with Git, e.g. kdiff3 and meld. See git-difftool(1) and
git-mergetool(1).

[...]

--=20
Magnus B=E4ck
baeck@google.com
