Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64E121F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbeAYOY0 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 25 Jan 2018 09:24:26 -0500
Received: from elephants.elehost.com ([216.66.27.132]:11070 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeAYOYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:24:25 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (d72-38-205-26.commercial1.cgocable.net [72.38.205.26])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0PEONkU064086
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 25 Jan 2018 09:24:23 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Basin Ilya'" <basinilya@gmail.com>, <git@vger.kernel.org>
References: <e9518459-ebcd-d415-474f-8504472b7a1d@gmail.com>
In-Reply-To: <e9518459-ebcd-d415-474f-8504472b7a1d@gmail.com>
Subject: RE: pushing a delete-only commit consumes too much traffic
Date:   Thu, 25 Jan 2018 09:24:16 -0500
Message-ID: <001101d395e8$31d94430$958bcc90$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI6yB04ulyuwbhKBQwXrx3kFgdBl6K2PyCg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 25, 2018 9:15 AM, Basin Ilya wrote:

> I had a 60Mb worth of unneeded jar files in the project. I created a new
> branch and performed `git rm` on them. Now while I was pushing the change
> the counter of sent data reached 80Mb. Why is that?

Can you provide more info? Were the 60Mb of jars previously pushed in a commit that already existed on the upstream? Was the delete an actual removal of history or did you commit with the jars deleted, then pushed? Did you do a merge squash or delete branch to effect the removal. More info please.

Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



