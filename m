Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6081F744
	for <e@80x24.org>; Sat, 18 Jun 2016 10:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbcFRKtL (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 06:49:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:53205 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbcFRKtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 06:49:10 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Md3ZK-1axEvK30UM-00I9Gu; Sat, 18 Jun 2016 12:49:04
 +0200
Date:	Sat, 18 Jun 2016 12:49:03 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/1] Fix testing of `master` on Windows
Message-ID: <cover.1466246919.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2elUAPw7xamEuz4eToC6qiiyZLDI3ek04rnmIDZBP72zaJ5jZ9q
 YCbLGJih+9RpJFhOvEARs3wpFodqYUA2+Xzgu6a8wDNkkHwB0f4R+ZLuChEHF5Yde8syC9B
 uFK0JGtE3cK3BAGUyYU6VmZFawOp05C4snmD6g38sDfozrTViqe7Xv0Ns9vS/YTXbRIADgw
 kLyNV4D1rmhIzURIka08A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:EDrz0cgBRdE=:+dSwXxyZ+mDj9xBoscyj5I
 OkVs5iemvH/Rfk5Z1lyR/gXHlZMplko1FjMMu1m8Xltg9Yz9aXsY8h3o3flvPYBjoKUt7CMza
 on1tKxYaHxIJZpg46jNcN0QWYR8CJVPRuss7w3pXiysZmwFyBtnLvel4+T3K2kzoi2XqKupBt
 HnNQpP6aappw2pj9fXvoK39VsMcWMMoBuzUx0OTvC+SiPdtDPrQqU35l/TiKsNzdtFmNJBf3z
 HB5W/RUNZV0CrI6n+/oAyWccoZ7w4h/LncMTELfP4XbJW1o88GbtDf6E62Y2VJNTZixn/+vf7
 GhVmgsBqEYac+2e9VGwmDmnKRu5lg3jaZ0UwiDt8jnwShsNXINKnV2BRfw1sv30XI2rrsqbeu
 2HHgDTasiyAwYe1nW/izq3wgwcxk5roypPbrbDjhJxXBDCcXBf/ap9OeTrhLLfOK0qRmA5Srg
 a1Vg+1xMm/Vd/4WdMn8EyhAtKyqe35YNbtiNBdaxHju7Dxk+P5qxmmk+LZ1KMoTDDcH2I6+vJ
 Du4H4A5eMfJBkyOLPTWjgKyBhN5N472W0Dx/Q0OzdEaBoV4yLwGUKTEjcTYfFltHnBLRGkhnt
 qZnGe7ZISewMKfLhxa/4yNj8WwVKVq/F/051SJUTNnS4Z7bmbI8TU3oJh95zQ1c0paltRidSe
 8j0qM7GFRhXMrZvTzfR/Naup1HrZZLUhW1tG0E/pCYF1q+h+xyV6RnfwfjMb+4NAWx350RKxi
 A6G/jo2LNt4HWPlrZhNDhfOSjPJ8WH28mU4u+lmguOKBc/0o3wig71T9xLn9679NB4HNb/X7B
 /3/JVkw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Sorry, I missed this (trivially-fixed) test breakage... FWIW this is
*not* part of the rebase--helper patches ;-)


Johannes Schindelin (1):
  mingw: work around t2300's assuming non-Windows paths

 t/t2300-cd-to-toplevel.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Published-As: https://github.com/dscho/git/releases/tag/mingw-t2300-v1
-- 
2.9.0.118.gce770ba.dirty

base-commit: 05219a1276341e72d8082d76b7f5ed394b7437a4
