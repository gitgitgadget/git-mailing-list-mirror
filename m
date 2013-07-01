From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v8 0/5] Reroll patches against Git v1.8.3.2
Date: Tue,  2 Jul 2013 03:18:59 +0400
Message-ID: <cover.1372719264.git.Alex.Crezoff@gmail.com>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 01:19:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtnNa-00078t-5q
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 01:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345Ab3GAXTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 19:19:13 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:59881 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab3GAXTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 19:19:12 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so5038655lab.31
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 16:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3vFgRuL9Y3Dazn6ghujWAP2ONSOTVisO4srCscWS58A=;
        b=JOD/1GqptGL7Gy0vZJp87PDIRIs6Imz4wSERUtPliuwS8LfkvzcxfZTP8Vq/zG0+2+
         C4zNovKp98OIyyiq09v8u2g900I09W20+rW+99ufms7px7A1qOE0x2F03+G7n15yWKZb
         H4Ub9wOXjcG0+3cQTmePAR37kY78UsPd+bXnA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3vFgRuL9Y3Dazn6ghujWAP2ONSOTVisO4srCscWS58A=;
        b=U6+BeWjgPZe5Kea27MwM4jy8PM7MYvspEXSOSqDdr00QTbtJIXbEkrDJmtC9Tpyoq4
         ohMIgaS57w2yhCLm1EONFhblVmIhUHxfS/v0Rzd3s8lgOQV2SsYVkcijvUojeInypsrm
         /BxK985yo3TiadiE1wBIhODbzQc8goi4Bkiwt38es6JzRvH9Wrh1gJAZWlUfku9xDDC8
         4rexH1pwt/B8ZdKIKIPMjwqmmd9jOXu1sRFYBZwMreuhZQgUXRFEa3zcnEIVmiPQoaIp
         xQQCpGPb96pM1a28lPXB/wB0huD6I1Ak4jJ8ZrB6vXeCED7hKHsrrwXtg6Hl27fNgZaz
         6e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=3vFgRuL9Y3Dazn6ghujWAP2ONSOTVisO4srCscWS58A=;
        b=Lksr3IuC8Sjip7UtGzzw6DZ4aQ5zx1GUiDr+dOK0mBnrcnZC5Fj4qerg/V8SKtvCqu
         eM4rqSs9MwAHMVWtCWUykcTUXcjTiAsUQsVzRPFit56I8viEO7hfp4g9lDCixOpt6Vb4
         a6OpRXPUbYckDqNpdk2+fVjltoBM/RRZGl8K4lLwI3mUXZYlUOiuFH7WhvT08AqSp4x4
         u7xuZhUIybpWr+2wqQ/onUn94nZDrKUA9uqFtn9p16Y0Z7OBc32hZE2Xsu1wKrK6UrlH
         /Mexxfo0tCrO4o4vKg54kwJHXhKX9XMq36aqP8xkgBexqtW1VAfbOEGea5umanyNveA/
         OXYg==
X-Received: by 10.152.22.232 with SMTP id h8mr12954329laf.37.1372720750185;
        Mon, 01 Jul 2013 16:19:10 -0700 (PDT)
Received: from localhost (ppp91-77-20-158.pppoe.mtu-net.ru. [91.77.20.158])
        by mx.google.com with ESMTPSA id c4sm8053445lae.7.2013.07.01.16.19.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jul 2013 16:19:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.16.gce2c52e
In-Reply-To: <cover.1372240998.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQnEphdj5iQYEmnZyazXHsaQMoca73xthnjxEc2bdna4K9o/1+VWr+ph1CIYdCEJFZpd/k7B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229348>

v8 of this patch series includes the following changes against v7:
1. [PATCH v8 1/5] t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
        untouched
2. [PATCH v8 2/5] t7102 (reset): don't hardcode SHA-1 in expected outputs
        untouched
3. [PATCH v8 3/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
        untouched
4. [PATCH v8 4/5] pretty: Add failing tests: --format output should honor logOutputEncoding
    Includes suggestions of Johannes Sixt:
    iso-8859-1 encoding replaced with its more "ancient" synonym "iso8859-1" already used in tests
    t/t6006-rev-list-format.sh:
       `test_format` function become simplier and more readable 
       `complex body` & `complex subject` tests are reverted back (to its "initial" state)
       2 tests added to test encoding conversions with i18n.commitEncoding unset
    t/t7102-reset.sh:
       `commit_msg` function become more readable

5. [PATCH v8 5/5] pretty: --format output should honor logOutputEncoding 
    untouched

P.S.
It's all started here [http://thread.gmane.org/gmane.comp.version-control.git/177634]

Alexey Shumkin (5):
  t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
  t7102 (reset): don't hardcode SHA-1 in expected outputs
  t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
  pretty: Add failing tests: --format output should honor
    logOutputEncoding
  pretty: --format output should honor logOutputEncoding

 builtin/reset.c                  |   5 +-
 builtin/rev-list.c               |   1 +
 builtin/shortlog.c               |   1 +
 log-tree.c                       |   1 +
 submodule.c                      |   1 +
 t/t4041-diff-submodule-option.sh |  25 +++--
 t/t4205-log-pretty-formats.sh    | 126 ++++++++++++++++--------
 t/t6006-rev-list-format.sh       | 204 +++++++++++++++++++++++++--------------
 t/t7102-reset.sh                 |  39 +++++++-
 9 files changed, 270 insertions(+), 133 deletions(-)

-- 
1.8.3.1.16.gce2c52e
