Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8180A20193
	for <e@80x24.org>; Fri, 12 Aug 2016 02:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbcHLCB2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 22:01:28 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34228 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbcHLCB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 22:01:27 -0400
Received: by mail-io0-f175.google.com with SMTP id q83so13058734iod.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 19:01:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=B5GiEq3uoL2EKzDAs0k07Mg0TQ32NPPFVWExu1MgQIU=;
        b=Wm9Dw5y9EGDzz6IctJGAD2/NdtfEi+3dc2do6ciekOcZyH/fk5tmzl3IRxtPtCXX9T
         s5UEmj4A4/OqOPYWmBz6gtWlRRVnrMppaHLtGNly6Xj7GajPzh9x+lUUoPwQ8o4XVt/s
         SzVQDBEclnOvgA9Avue+XAL2nWJnm2NVPPKsg/SJ7AzZcbDBXWH2Lrw66Gq3hpGQsRag
         OXaajPeqhz13oRaoVhdP2idbEwzV6kpH+TVRPjHRWUZXFrod/81EamwRgxe88JNIUZ9Y
         JlwAbUWQGu31+t7AFobOoWRfKRMSckeZ0i/aBPI1x+J7XYCXqhcyB0r2RDSIbx7h2vAf
         2DoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=B5GiEq3uoL2EKzDAs0k07Mg0TQ32NPPFVWExu1MgQIU=;
        b=iDOB3CLcguVNmMo6vt1D2Ff32KI65VUlLztkL9jjp2U9sXYO2qSn3UC7hN5esOVYT4
         qmB/sXrxkdav7jLsWl/xu43MWUbJVf7lW4qdq1Kx04sBOHHKVw7b/fU9VrcRuEXFHOtf
         lLa7P70RObU+3mLNJX3KJoYA7WFqI+azhMu7GEvSJgqz6sjZm+FwzFA3OEIFxS530FN8
         scUw6y+Ahg/OYCXJ4qxrBZbpkC61EfAIptIB5DPXTGuL8Qx2niSJSTIRMBYaYDluYXVs
         nouaX23aVJEWwF30qHBz4vZiIniBJ//Z5gQ1IDtH6SIaqxS/Ly9nIgmNiMmjV85i2lHM
         otjA==
X-Gm-Message-State: AEkooutNPz2OFmvNwTS46CNyMuAw1UvzXUjuo+fluzLQD6YJxTfUkPh88nevBzpCP0+MWkHmNw8KiSrE4IfGRQ==
X-Received: by 10.107.50.79 with SMTP id y76mr15142211ioy.46.1470967286824;
 Thu, 11 Aug 2016 19:01:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.213.66 with HTTP; Thu, 11 Aug 2016 19:00:56 -0700 (PDT)
From:	Joseph Musser <me@jnm2.com>
Date:	Thu, 11 Aug 2016 22:00:56 -0400
X-Google-Sender-Auth: rNp00ctNKHGbD3tF6YSha3oi1s4
Message-ID: <CAKRjdd4WdVTgbT0gcR=a267+aEwD2Exztrc9gNau1nOXroC=ng@mail.gmail.com>
Subject: `git stash --help` tries to pull up nonexistent file gitstack.html
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Looks like a simple typo.


Joseph Musser
