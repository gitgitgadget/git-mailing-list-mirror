Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069FE1F858
	for <e@80x24.org>; Sun, 31 Jul 2016 20:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbcGaUSq (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 16:18:46 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38558 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbcGaUSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 16:18:45 -0400
Received: by mail-wm0-f50.google.com with SMTP id o80so217461029wme.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2016 13:18:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Yvlmk4heYi1sPE1kwLzTd6Q2stq2ErTJMKku+7WH+iA=;
        b=kHLcvjEuVdpFI+ds2jbdVitn5alibu2a13BvZn4VzIlHWJ7rW1lrbm5PExBS3HSd6Q
         ZzagV067WHapZSxDUtqmTYYNyZzIizhWlotmvS9TqAuFfoobkG3iWl9Vz5SF7EhTzcca
         eNUzUH/uRnZD0K0hjJhs0nsOTu/gQ+1tBVsUmSnlgbfnAZzMh2bKyJsFHV5QHn1QLNdi
         E7+VWmFf5IuSPCieHNRLWiCifiQKKOetuM/HUn6MEaa0DEp052tIFghJAiaNBpHOXxR0
         3eWE6GUTVzHkOnGReic+XTkuHR6UzRiA97pUJq3L5eMeKfQzFN73O4j58IMoH6Mkvv5U
         k3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Yvlmk4heYi1sPE1kwLzTd6Q2stq2ErTJMKku+7WH+iA=;
        b=GERmqwAyRMhsmZ67lT84E8PeGCxLvXsENfh4JjUAT8UjpsHq+QRI6DLY88+bkRiAtV
         gQ9p+QwNK9U7t9y38bRs1SwqFRzVvMWAgcnSpfpE1wqwpbH9BtfugpGM/qmN0A1feUDz
         +mh8g3erq+I8vV+GZauTi096sz1+vWdYJaGG/WHBOBoN/K+qDsyCs5gdw49bgFCb8+Bd
         7NQVtN2T/nvE0/dA95DoEfGT+G8SFomkPa6ayAe+WzfG7FAnFFV9DjL/T9yXg2V0RTcI
         qlk2xmbINRBXScH7cxxzT37fzH5Xx51pzfnfLNrY3taRhte4CIiwBzyebWxECTyrHOOw
         SHSQ==
X-Gm-Message-State: AEkoousTtOhInj1oxb/ahYqHDFPxg2AvT4WPwF4H5gUO66F8VPfPAm8EZSvsSZMbaGXlV8J3LCiw/ZmkP/eBCA==
X-Received: by 10.194.26.166 with SMTP id m6mr46393904wjg.120.1469996323506;
 Sun, 31 Jul 2016 13:18:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.124.228 with HTTP; Sun, 31 Jul 2016 13:18:42 -0700 (PDT)
From:	Britton Kerin <britton.kerin@gmail.com>
Date:	Sun, 31 Jul 2016 12:18:42 -0800
Message-ID: <CAC4O8c9Zmh0hvx_u2qRsVUkSw0MKodJ5Vhf074ApfavkKDFOtA@mail.gmail.com>
Subject: gitk should maybe keep focus on same file when switching patch->tree view
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

if you're looking at the patch for a given file (have it selected in
the lower right window), then when
you switch to tree it would be nice if it started at that file.  I
realize you can view Old version/New version but that doesn't help
with landing the the right level of the tree for projects with
subdirs, and sometimes you want to just switch to looking at the file
sans all diff markup.

Britton
