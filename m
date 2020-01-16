Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B02C33CB6
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 19:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284B6206E6
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 19:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbgAPRAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:00:42 -0500
Received: from elephants.elehost.com ([216.66.27.132]:27999 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732675AbgAPRAl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 12:00:41 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 00GH0dsH004329
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:00:39 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [RFE]: git submodule commit push
Date:   Thu, 16 Jan 2020 12:00:34 -0500
Message-ID: <005801d5cc8e$7ae618e0$70b24aa0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXMjdSmH5M3s4I2QamMq07fSX1u7Q==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I'm finding that I have a frequent need to commit and push submodule changes
because the submodule is currently subject to a whole bunch of changes. The
submodule is pretty deep down in the java path of a maven project - so 7
directories down from the git root. It's a bloody pain to constantly change
directories to get down there and back up to where I am working. If IntelliJ
supported submodules explicitly, I might not be whining about this, but I'm
having to swap to the CLI.

My suggestion is that provision be made for the support of

git submodule commit [ --recursive ] [--] [<path>.]

and

git submodule push [ --recursive ] [--] [<path>.]

with all the trappings that come with commit and push. I have a feeling this
is a pretty big ask, as it will really pulling in a lot of other commands,
including add.

Am I barking up the wrong tree?

Thanks,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



