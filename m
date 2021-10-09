Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A351C433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 07:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DE260F6F
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 07:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJIHx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 03:53:27 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54]:59771 "EHLO
        pv50p00im-tydg10021701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhJIHx0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Oct 2021 03:53:26 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Oct 2021 03:53:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1633765398;
        bh=MaSmgt9J1e3DhLQIhgmjsAo22Ac/6Yj17EMxtkS6jpk=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=IHmd6pskMOd2ViqewCoxnwMJ+oBRP3ANgY6G+YRfOMU2FTXc8JCAAajwwOuLhlI4n
         3QfPk8ivdYLYWr13frICgvnyIJnZDjZk7t+jMy6gwNyuvH1ZlVVvoI0mvrIn0a1/Pv
         RLxiuwn6NNy/Bfi5Kr/TApGeiMWCs83GPABEoX0c7JA/1hmcDEJQnu77xvTzS7AyKL
         hTh0N4Yz1jPOdLhZFY8fdbsTHZNfBK18J1dBM6Q1h5pnZ2VHWOnFkMB09YShCQclu7
         ZX2/9QPmnUwMutUvQNXGkDCQXrsUagbRlGJfGHos6UOEXmjuXu8DpmdV3V3Fgz1ITi
         qpJqz8691UBEg==
Received: from smtpclient.apple (unknown [42.120.75.142])
        by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id BF12A8404B5
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 07:43:17 +0000 (UTC)
From:   ZhangJinbao <zhang709787793@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Some problems for git beginners
Message-Id: <2EC9E24E-A8FD-4851-9F6A-F3D104465A23@icloud.com>
Date:   Sat, 9 Oct 2021 15:43:14 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-10-09_01:2021-10-07,2021-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=490 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110090054
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello! Sorry to bother you in your busy schedule.

As a git beginner, I have a few simple questions to ask you

First, how to implement the algorithm when there is file renaming in Git =
directory?

By comparing the SHA1 value of the file, and then calling the GIT MV =
command?

Second, how to implement the algorithm when there is file movement in =
Git directory?

How is the tree object updated?

Third, when a commit event occurs, the current blob file stores the full =
amount of data, while the previous version stores the incremental data

But I didn't find out how to (local git database) when I actually used =
it.

When git clone is used, the results are close to the conclusion

These are not found in the book, so I have to bother you.

I hope you can help me solve my confusion when you are free

thank you very much indeed=
