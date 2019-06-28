Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6AFB1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 09:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfF1J5q (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 05:57:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:60475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfF1J5q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 05:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561715864;
        bh=vtskkw8TPeecL7ranWau3kJfJnBiZpHnYrLj74JV0XE=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=WGe5l0qvWSzUQR8zC4i8O23Yqk2rdkn5iqJKi0VOsDCKtjWvNptF5GUElc/+KtifN
         VK2nmacuQqWsSHHSVesgBfL1FpOm60OOZioQpkhoI/7HVrmu+mLc0VyGE7q5iG1lIA
         yXmmzgPi+YKSI57pRLhGt/rCP3guDTviLWk6WO3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([94.79.149.170]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3HU-1hnOHQ2zM0-00FPo3; Fri, 28
 Jun 2019 11:57:44 +0200
Message-ID: <34d6121da46f35e4b81d38169b1b86ca123cef37.camel@gmx.net>
Subject: git p4 sync: "str expected, not %s"
From:   "Massimo B." <massimo.b@gmx.net>
To:     git@vger.kernel.org
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 28 Jun 2019 11:57:41 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.30.5 
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DnfIuxW/IoEuX8IJApaDg0Ia7YlgCxt1eFVX2SqN8XoDBYjcdoo
 sC/gX0aUFHALRQW0ubmICXilSlrqBbNDexZ4h/Aptxp2PIcr7OTElDM+UQCUi5owbTC0o7t
 XXdt9Xd3BXmo8gd4S1GbZc9fIs5UvXbz8oaeXB45eXROVvRrL8/8qEt/eW9WA5QGr5vmxtJ
 OtHESM+zD2gvAycR8BFoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QrmbSKIdqEU=:HHhzlgMsZxE9DFYXUSgw66
 dYO4TDzAu1PAnLO/qIgzNlWX+RfzLCDJG0leKcEackTp7fpND8Qfgk8IwJ79IGkonWRMofGi0
 8KAjYfQH19+08O4o9abKCJa8i4wjg0eez0nQalnMOAjSltfwcg58VQ4Ix8BxZBtWT1FNQq5C+
 MMc5WT1WHVM2DuIEsf0ytJygUC6IS7E7AsmbgiTmx/Za2FOVOSDJBq8eFkUx3vkliO2SY9B0O
 7sHKgb1/Q61MMbRo8c3mVLYBOU9I8xYqUU/LnNM8iGrklsqdVwFRuXpqz2L2vOcPIA+qRhKKS
 Y5U3WFPLLFzckZJJaWigj4bltHWOLBDOievcXUhiXbOMTswZzTFShwRPB8fozBvNW81qrRBCt
 mN1gBSevrlJ25LvhSmdm7RiLbfmo7au21nWfkhT+FkHp18t4tFbVzBp14XdAfFRyF3uQtp5iS
 ZfOC66zfaRPFW2TYrVkvIFkgbAVZ1lGY3I0LNgDEd+Sn76oOj8jhw3aKQMUcrBOohN6Mz216d
 VU4TLllFhXWAuSOYAOemKY6vrFXktNwuZ7oNI+fs90bxNeB/ZGY1kivFusywLZ5CRFzn77iT6
 I9YxTBxE7wlygaCCVFHCOnX4nL80MPbN2lUkuxb968isujc97ZKXDiIyH8Y44LStxMsCZCxkk
 FgYouBkl1KTonQSP9uxyhTumuvvLamvoFTgG7fSSi00GMDrJideFPGqPKlLgG4CrpEYRkMVdj
 Z6L9u7HTYVsu82x2NHBCgWIZfAtUEOcb2TDN5f+wRZ1T6N/hVbImVxfhL97ppFdrekt00EjlO
 EoZqhVpWhxwvQC901JT3RWcIulk5qzpPujy1RSp7rTAD2PeWwii+CJtOhv5RV5R3XFEMOlO4P
 s19r3woUNpKvgF87FIANZd7oCq7ghSlwrLT8kMTfix9UpRXF8gthDocGXQVqtCZYCOonA50rv
 fsXyRHFS/X+3EqDZBq3jzN7BAotDWR4s2AdkRshLY1sp1PEHaudUL8ZcuzQc06OHq8kIO075x
 sCuT5iG9R8icLQEWznqa381Qpvjv1TODS+MIaFdCxiZ/Me4KgU4OBCxzarIgx5uJiWsV+l+Me
 r5hfj7KCn0/ZAfLprVbfmShzpchqSxseiji
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everybody,

since last updates, git p4 does not work anymore:

# git p4 sync --verbose
Reading pipe: ['git', '--git-dir', '/mnt/data/userspace/project-pb/MM6.test/.git', 'rev-parse', '--git-dir']
Reading pipe: git rev-parse --git-dir
Reading pipe: git rev-parse --show-cdup
Reading pipe: ['git', '--git-dir', b'.', 'rev-parse', '--git-dir']
Traceback (most recent call last):
  File "/usr/libexec/git-core/git-p4", line 4163, in <module>
    main()
  File "/usr/libexec/git-core/git-p4", line 4155, in main
    os.environ["GIT_DIR"] = cmd.gitdir
  File "/usr/lib64/python3.6/os.py", line 674, in __setitem__
    value = self.encodevalue(value)
  File "/usr/lib64/python3.6/os.py", line 744, in encode
    raise TypeError("str expected, not %s" % type(value).__name__)
TypeError: str expected, not bytes

git version 2.22.0
Gentoo Linux
Global Python is 3.6.

Last working version I found: 2.20.1

Best regards,
Massimo

