Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41960C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 02:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB9260F38
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 02:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhJKCyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 22:54:21 -0400
Received: from sender4-pp-o93.zoho.com ([136.143.188.93]:25384 "EHLO
        sender4-pp-o93.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhJKCyU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 22:54:20 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Oct 2021 22:54:20 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1633919836; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UIDmkzFtXQ6s2oa+Ts+BWT6Ypx8zybT0XSz6XZCy5GKXNdA3tMb5Me/FUIWjjZLIC6+o8hKZe7b5JvAx0KJnGzZ8dpl/aRbDNdLv1B/FaomGE7NceQgaB4CwAwYYDewD+KaPyQFYJ4kZsDwX/83jQED9SPRWGiJJbm3JZcxSVMc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1633919836; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=HdfKEbuvj2YaMEN+U7ekLP123z0S/VLUkKY6l9zwP84=; 
        b=Di7SWrUeHmzFgW4mldxYCeErJf+rJ9w7O/MiwO2HGaCadgqwZJxKgJHEs5ZU+IlayIqcIUbtd3xLWxnKGkvv4oDy3JwhGHVprWw5ji98mPWwld0RVOAtHFRqv0BL7+03XrB+O9CFvko/pBYG5H+xeIIraJOOeX2xmKabV6EqEiY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=ToddAndMargo@zoho.com;
        dmarc=pass header.from=<ToddAndMargo@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:to:from:subject:content-type; 
  b=OuCNiWpF4NfdPUXFgg/icEHASvhmbcuqlh1Wg8bkCd6eGGpYYMzhgfVnoM4dAH2tZ7LP8OSV5kqd
    9uKZmd3pMNu6MSKfJVeqz8XOJhSgUXGEeIBQ+nlctI4rerwqV3Tf  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1633919836;
        s=zm2020; d=zoho.com; i=ToddAndMargo@zoho.com;
        h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:Content-Transfer-Encoding;
        bh=HdfKEbuvj2YaMEN+U7ekLP123z0S/VLUkKY6l9zwP84=;
        b=A6MPxXCz6Q03PXg7UZUlMI7512cYYtPCeoW/m8gDoThCnJCHDotWpkxm2DcS1W6C
        HSyTE1v9tEULA/zT5ueAwnaxTWYOV2aleYrm4EQonFja/NUIuihclUM84OUygLAINVN
        61lrQkGmzALk51VIhQ5pNJSnISLf9Rc869wkoLAw=
Received: from [192.168.250.117] (50-37-29-217.grdv.nv.frontiernet.net [50.37.29.217]) by mx.zohomail.com
        with SMTPS id 16339198339065.5547762005908226; Sun, 10 Oct 2021 19:37:13 -0700 (PDT)
Message-ID: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
Date:   Sun, 10 Oct 2021 19:37:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
To:     git@vger.kernel.org
Content-Language: en-DE
From:   ToddAndMargo <ToddAndMargo@zoho.com>
Subject: I just want the revision
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ZohoMailClient: External
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgQWxsLA0KDQpJIGFtIHRyeWluZyB0byB3cml0ZSBhIHNjcmlwdCB0byB0ZWxsIG1lIHRo
ZSBsYXRlc3QgcmV2aXNpb24NCnNob3dpbmcgb24NCg0KaHR0cHM6Ly9naXRsYWIuZnJlZWRl
c2t0b3Aub3JnL3NwaWNlL3dpbjMyL3NwaWNlLW5zaXMvLS90cmVlL21hc3Rlcg0KDQp3aGlj
aCBpcyAndmlydGlvLXdpbjogcmViYXNlIG9uIDAuMTY0IiwgYnV0IEkgY2FuIG9ubHkgc2Vl
IHRoaXMNCmZyb20gYSB3ZWIgYnJvd3NlciwgYXMgdGhlIHBhZ2UgaXMgZHluYW1pYy4NCg0K
SSBkbyBoYXZlIGFjY2VzcyB0byB0aGUgZ2l0IGxpbmsgb24gdGhhdCBwYWdlOg0KDQpodHRw
czovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvc3BpY2Uvd2luMzIvc3BpY2UtbnNpcy5naXQN
Cg0KRG9lcyBnaXQgKG9yIHNvbWUgb3RoZXIpIGhhdmUgYSB3YXkgb2YgdGVsbGluZyBtZQ0K
SlVTVCB0aGUgcmV2aXNpb24gd2l0aG91dCBoYXZpbmcgdG8gZG93bmxvYWQgdGhlIHR1cmtl
eT8NCg0KSWYgSSBjb3VsZCBnZXQgc29tZXRoaW5nIHRoYXQgY29udGFpbmVkDQogwqDCoMKg
wqAgwqAgdmlydGlvLXdpbjrCoHJlYmFzZcKgb27CoDAuMTY0DQpJIGNvdWxkIGRpZyBvdXQg
dGhlIHJldmlzaW9uDQoNCk1hbnkgdGhhbmtzLA0KLVQNCg0KDQoNCg==
