From: Jagan Teki <jteki@openedev.com>
Subject: Git patch shows tab but files doesn't
Date: Fri, 12 Feb 2016 21:32:32 +0530
Message-ID: <CAD6G_RTJuNsR6qawgco1H+ocKPThk1HsQLvhQigmzUb_c7UdaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 17:02:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUGB9-000613-J5
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 17:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbcBLQCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 11:02:40 -0500
Received: from server159.web-hosting.com ([68.65.120.118]:33486 "EHLO
	s159.web-hosting.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbcBLQCj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 11:02:39 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36280)
	by server159.web-hosting.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.86)
	(envelope-from <jteki@openedev.com>)
	id 1aUGB0-000Sbk-1h
	for git@vger.kernel.org; Fri, 12 Feb 2016 11:02:38 -0500
Received: by mail-lf0-f44.google.com with SMTP id 78so54400958lfy.3
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 08:02:33 -0800 (PST)
X-Gm-Message-State: AG10YOSooASzQnWMJXR5WHQ7bAGSzZE2ngrj8CGodGyJwyrFtCc01ahkWAk2TzF761oM5Mrj3UVhETR2U725Kw==
X-Received: by 10.25.21.90 with SMTP id l87mr964846lfi.64.1455292952502; Fri,
 12 Feb 2016 08:02:32 -0800 (PST)
Received: by 10.25.25.149 with HTTP; Fri, 12 Feb 2016 08:02:32 -0800 (PST)
X-Gmail-Original-Message-ID: <CAD6G_RTJuNsR6qawgco1H+ocKPThk1HsQLvhQigmzUb_c7UdaQ@mail.gmail.com>
X-OutGoing-Spam-Status: No, score=-2.9
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server159.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - openedev.com
X-Get-Message-Sender-Via: server159.web-hosting.com: authenticated_id: jteki@openedev.com
X-Authenticated-Sender: server159.web-hosting.com: jteki@openedev.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286056>

Hi,

I edited a file as one space between #define and macro and tab space
between macro and BIT value, similar as below.

#define USE_FSR           BIT(6)
#define SNOR_WR         BIT(7)

Once I created the patch looks different as tab space between #define
and macro and 2 tab spaces between macro and BIT value looks like it's
added tab spaces while creating a patch as below.

+#define        USE_FSR                              BIT(6)
+#define        SNOR_WR                            BIT(7)

Any help how to fix this, was it an issues with vim or do we have any
git-config fixes for this?

-- 
Jagan.
