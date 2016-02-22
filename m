From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Mon, 22 Feb 2016 16:00:11 +0530
Message-ID: <CA+DCAeQADoW-r5ppDNXVBj0=16FXKi=3pedAzhRuCD9uDJz_YQ@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
	<CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
	<CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
	<CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
	<vpq8u2er7ae.fsf@anie.imag.fr>
	<CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com>
	<vpq1t85rj44.fsf@anie.imag.fr>
	<CA+DCAeQGPqZvvn5RSA0UweM4sQLat-2OPo4BdEDyvUbq+eLi=w@mail.gmail.com>
	<CACsJy8BKko=esR5Q3dsq=Z-pdX1EtocJr25tH4Fn+E-pOns=_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	karthik nayak <Karthik.188@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:30:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXnl2-0004Bh-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 11:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbcBVKaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 05:30:13 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34682 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbcBVKaM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 05:30:12 -0500
Received: by mail-qk0-f180.google.com with SMTP id x1so53798824qkc.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 02:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fmBmeePt2NSl2GOdAUGUkYhViAoCGBc584IOt7dy0CU=;
        b=V+GvbB3XKetVRMc53N8sFZfyE9iaWpjQoQuUPIOykB+/vRnlxN2LSdTVzBsbkrzDrm
         Wp3YU3yxcBoUTOaXqb6Z+bdi/+SX/PvnuWlrTujahrjd42Ng7DXbLcj7VJj9PS5I0sG1
         BU7CLv6Pafn0IlYhj/IFdO4MUdXrtXPA8DiRAb1n9BbfKLOsPCbvS8peU+uesDCyRRO9
         gqG7zXFne4yJUNFo5RLAbRLZ1E6NGYPN1BpPlIifBV7D2EBwv0NcAG5QahMZXRs/dG+w
         qQZlkbiw/A7Avpm/n1s7cfrb+q3Lxp4j5MVsbVMogdSvClZ6K4XTkb1XaaXfzEFBwQQv
         XVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fmBmeePt2NSl2GOdAUGUkYhViAoCGBc584IOt7dy0CU=;
        b=FQfebZ4BDwEd/cLwuGaQPINGSAxYJ6tmhhyvztRN29+5+XEGSFBy97g/1dnG/RmvDF
         G2D898TS9jL4DzdXhi+ZZszAEoUBoCJt2wenPIF8FHgeP/lwUF7EPiHpvRh3oWf5e+2K
         x/JBJbvL/9wjpt1khGFcmv/LC/zuyCnmAh5gpprFzX90ZhSzsfVPTNXGnv4HLfOI3rNw
         UtRuWMfir4uRO/0JAoPyE/5Cc06MT3rjY8ea0JP61DQ5c1JtEHcVcRpC/gROW8bn9ZwT
         eAag5nDI+DS5d2iAXRLJsqsO0rAY65286sEcMJIQ+o0EWOymQMNKccr5QIaroJA/bjpe
         bbqg==
X-Gm-Message-State: AG10YOQLdOcqhvDVq6H7LQnSvV0OXWrKLiqzmcAW+pT3fdiYEbmNEhXn2PmV3g3yVIc0Ngi6pzHw4vP29k8r9g==
X-Received: by 10.55.209.148 with SMTP id o20mr16086383qkl.5.1456137011582;
 Mon, 22 Feb 2016 02:30:11 -0800 (PST)
Received: by 10.55.154.205 with HTTP; Mon, 22 Feb 2016 02:30:11 -0800 (PST)
In-Reply-To: <CACsJy8BKko=esR5Q3dsq=Z-pdX1EtocJr25tH4Fn+E-pOns=_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286905>

On Mon, Feb 22, 2016 at 3:50 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> You may have an http server installed but not suitable for these
> tests. Try running one test file alone with -v -i, e.g.
> ./t5539-fetch-http-shallow.sh -v -i and post the output.

Here's the output :-

expecting success:
    git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
    git clone $HTTPD_URL/smart/repo.git clone &&
    (
    cd clone &&
    git fsck &&
    git log --format=%s origin/master >actual &&
    cat <<EOF >expect &&
7
6
5
4
3
EOF
    test_cmp expect actual
    )

Cloning into bare repository '/home/mj/git/t/trash
directory.t5539-fetch-http-shallow/httpd/www/repo.git'...
remote: Counting objects: 15, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 15 (delta 0), reused 15 (delta 0)
Receiving objects: 100% (15/15), done.
Checking connectivity... done.
Cloning into 'clone'...
fatal: unable to access 'http://127.0.0.1:5539/smart/repo.git/': The
requested URL returned error: 403
not ok 2 - clone http repository
#
#        git clone --bare --no-local shallow
"$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
#        git clone $HTTPD_URL/smart/repo.git clone &&
#        (
#        cd clone &&
#        git fsck &&
#        git log --format=%s origin/master >actual &&
#        cat <<EOF >expect &&
#    7
#    6
#    5
#    4
#    3
#    EOF
#        test_cmp expect actual
#        )
#
