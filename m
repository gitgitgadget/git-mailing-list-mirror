Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049FCC433F5
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 08:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhLYIjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 03:39:55 -0500
Received: from ms11p00im-qufo17282101.me.com ([17.58.38.58]:33482 "EHLO
        ms11p00im-qufo17282101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229471AbhLYIjz (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Dec 2021 03:39:55 -0500
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Dec 2021 03:39:55 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1640421020;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=Lc7eFsLOC50qIktv/t7RADvJ9qsJqKMKSA8AZCtVkD9rebtSHrbAERGRyeo4IMdPE
         DPF8aO7zZT96g4EMg+xvkWNVpHK1MG8me5TCSNEgd5CHiOc6jk7Ps1ff+pNcbPzxlq
         nZ2KBvRCI2171iaHcwjPP+sI1NdtR7ZxO6grauycpbr/SeZA0PYzZuUoqqa0eeQGfh
         Pc6sCo+93YFk3jZ8VCSHvlnk5VK6S8xVwabJzZxIHCbw9VDTTjNPJcOGzECp+hcOkj
         SB1sKWed0OiEYbMehIjeeAFkw5vxRjj29+0c5g/pEkTivBKh0KydN8X6mgW1TUbkka
         LuCcGhJAyxS8w==
Received: from [100.111.46.1] (unknown [212.102.40.150])
        by ms11p00im-qufo17282101.me.com (Postfix) with ESMTPSA id 59D1D8C029F;
        Sat, 25 Dec 2021 08:30:20 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Joseph Mitchell <josephmitchell36@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 25 Dec 2021 02:30:18 -0600
Subject: Re: My git repo is broken, how to fix it ?
Message-Id: <19E9B3EE-705B-4275-8615-4C09ECA45BC7@icloud.com>
Cc:     git@vger.kernel.org, litvinov2004@gmail.com
To:     torvalds@linux-foundation.org
X-Mailer: iPhone Mail (18B92)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-25=5F02:2021-12-22=5F01,2021-12-25=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=472 mlxscore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112250042
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
