Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26E2208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 03:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeHHGQc (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 02:16:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42531 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbeHHGQc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 02:16:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 46A0821E50;
        Tue,  7 Aug 2018 23:58:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 07 Aug 2018 23:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=fnAXaeMNSIBqd3FH3VzUMY90PBTCDtqVEKaCORXjK+g=; b=ZNWe60WQ
        kXtRVQriaw/oFLs5/OXCsENuhKyQMtQw4WgSx2y+E4EQM50YsJauLhoyqdWlKkRt
        SlPFdEgtf4PtbIeMwD4Z+q1EagN41p6NxmAxHOXhJbcz2GUwnU4GAlAFkSn6SLuf
        OKq82Odr65wJ7qSfQ55Stc5W55fgnUuYETanex6C424pIA6Ck7xQ73Sxf4HBIV8i
        TznLRTWtfCs3pyvGWTeHRV99jyheRZAbP0myvNmyhQuFzJSJrLuPONDSeUX/vJmF
        iYMYSfSqovl5yN2sqywKgbbAzvJntrkpCgRev89UnJgy3W8xQuy07PmDMVSb29b+
        chhNBEuCFnHn3g==
X-ME-Proxy: <xmx:f2pqW5cJY7Hrnk7NFSZDzBKi1eHY8WkXjVVBeUDL-vZw--L4RtS2Ng>
    <xmx:f2pqW3VAjlXjkD2f-nbe4hKDqLUb0FEZzA0gKVGeZhpW7qkG8AqJvg>
    <xmx:f2pqW6eZKYvAlXMLVfE1RrRljlDofFD80zljIhbL474iKIbnBX8Kjw>
    <xmx:f2pqW7M25XsdMiDSgSdu0XaT0oj-iAzbYfPqK0xYjjyWq-wJ2HDTRQ>
    <xmx:f2pqWwgqq8T78rTnaKBUvFfN7Nlf7l3E5TkbwV7QP90z7RkIWo7ZTQ>
    <xmx:f2pqW9mW2xPyzZ8gbNrrEf6BbgqEwvrinygAZ109V_BuIRksshgW1Q>
X-ME-Sender: <xms:f2pqW6a_OneUl5njHLWusZiLQdDaUVVfGTnsIpVlgzBNsKG-GCUU9A>
From:   Brady Trainor <mail@bradyt.com>
To:     git@vger.kernel.org
Subject: Page content is wider than view window
Date:   Tue, 07 Aug 2018 20:58:51 -0700
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <20180808035854.49D69E450E@mailuser.nyi.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I am reading the git book or manual (https://git-scm.com/), and zoom
in, and/or have browser sized to a fraction of the screen, I cannot see
all the text, and have to horizontally scroll back and forth to read at
that zoom.

This may also be for smaller laptop screens, so those with larger
desktop monitors may not see this often.

Can site designer consider this in layout?

For example, I find it easier to read manuals at
https://gitirc.eu/git.html.

(This is unfortunately a very common problem on websites, including
github's help pages.)

Thank you,

--
Brady
