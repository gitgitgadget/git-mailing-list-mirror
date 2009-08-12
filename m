From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: Re: [PATCH 2/2] Add PathSuffixFilter class which is TreeFilter.
Date: Tue, 11 Aug 2009 17:58:57 -0700
Message-ID: <4A8213D1.3070204@tuffmail.com>
References: <1250038581-31241-1-git-send-email-grek@tuffmail.com> <1250038581-31241-2-git-send-email-grek@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 03:08:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb2KL-0004bi-EP
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 03:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbZHLBIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 21:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbZHLBIU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 21:08:20 -0400
Received: from fallback-out2.mxes.net ([216.86.168.191]:24424 "EHLO
	fallback-in2.mxes.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753161AbZHLBIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 21:08:19 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2009 21:08:19 EDT
Received: from mxout-08.mxes.net (mxout-08.mxes.net [216.86.168.183])
	by fallback-in1.mxes.net (Postfix) with ESMTP id E4C682FD7BF
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 21:00:05 -0400 (EDT)
Received: from glacegreek.mtv.corp.google.com (unknown [216.239.45.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 2C81C509DB
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 20:58:58 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <1250038581-31241-2-git-send-email-grek@tuffmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125637>

Grzegorz Kossakowski wrote:
> From: Grzegorz Kossakowski <grek@google.com>
>
> Added a simple TreeFilter that filters all entries that have path with
> given suffix. This filter is always recursive.
>
> Signed-off-by: Grzegorz Kossakowski <grek@google.com>
> ---
>  .../treewalk/filter/PathSuffixFilterTestCase.java  |  110 ++++++++++++++++++++
>  .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   33 ++++++
>  .../jgit/treewalk/filter/PathSuffixFilter.java     |   74 +++++++++++++
>  3 files changed, 217 insertions(+), 0 deletions(-)
>  create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathSuffixFilter.java
>
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
> new file mode 100644
> index 0000000..6042119
> --- /dev/null
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
> @@ -0,0 +1,110 @@
> +// Copyright (C) 2009 The Android Open Source Project
> +//
> +// Licensed under the Apache License, Version 2.0 (the "License");
> +// you may not use this file except in compliance with the License.
> +// You may obtain a copy of the License at
> +//
> +// http://www.apache.org/licenses/LICENSE-2.0
> +//
> +// Unless required by applicable law or agreed to in writing, software
> +// distributed under the License is distributed on an "AS IS" BASIS,
> +// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
> +// See the License for the specific language governing permissions and
> +// limitations under the License.
> +
>   
Oups. Wrong headers.

I'll resend these patches.

-- 
Grzegorz Kossakowski
