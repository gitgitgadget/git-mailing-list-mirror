From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 0/2] Add submodule-support to git archive
Date: Sun, 25 Jan 2009 13:53:40 +0900
Message-ID: <20090125135340.6117@nanako3.lavabit.com>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 05:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQx2g-0004JA-4w
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 05:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671AbZAYEyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 23:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbZAYEyX
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 23:54:23 -0500
Received: from karen.lavabit.com ([72.249.41.33]:56770 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819AbZAYEyX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 23:54:23 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 8E1CFC8409;
	Sat, 24 Jan 2009 22:54:22 -0600 (CST)
Received: from 5343.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id BMP79QN2NVZN; Sat, 24 Jan 2009 22:54:22 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=jX5G5rMn+tAYDMrSiUtpwQnND94dlrb60ne42c3jGPPXoflRtT5riA+GzrcwPYYJ/EefWNmxv/laGvD9YpVo1jltPmplPtAp5vzjH98bxkBRP6PbgiNnl3A2CLjNmRtw3AaVMwK9ZI9JKa9aN2bylHmE/jBMkubYrMWcbFwv0ec=;
  h=From:To:Cc:Subject:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107038>

Quoting Lars Hjemli <hjemli@gmail.com>:

> This is a cleaned up version of my previous patches which allows git archive
> to include submodule content in the archive output.
>
> The main difference between this series and the previous ones is that the
> behaviour of `git archive --submodules` are now predictable; the content
> included from submodules is defined by the gitlink entries found when
> traversing the <tree-ish> specified on the command line, and the set of
> submodules to include are defined by specifying either `--submodules=all` or
> `--submodules=checkedout` (which is the default mode of operation, i.e. what
> you get by only specifying `--submodules`).

I wanted to try this because I use submodules in a repository at my work, but your patches conflicted a lot with your previous series of patches that are already in the next branch of Junio's. What would I do to try this new series? Fork a branch from Junio's master branch, apply your new patches, and merge the result to Junio's next?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
