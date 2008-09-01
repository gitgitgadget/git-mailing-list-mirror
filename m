From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH v2] Improve portability: Cast pid_t's to intmax_t
Date: Mon, 01 Sep 2008 17:54:41 +0900
Message-ID: <buood382qlq.fsf@dhapc248.dev.necel.com>
References: <20080901082801.29621.qmail@science.horizon.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sn_@gmx.net
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 10:56:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka5Cf-0000QX-IR
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 10:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbYIAIy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 04:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYIAIy6
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 04:54:58 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:40812 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbYIAIy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 04:54:58 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m818sdm8019470;
	Mon, 1 Sep 2008 17:54:43 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Mon, 1 Sep 2008 17:54:43 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay21.aps.necel.com with ESMTP; Mon, 1 Sep 2008 17:54:42 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 56F05586; Mon,  1 Sep 2008 17:54:42 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20080901082801.29621.qmail@science.horizon.com> (George
	Spelvin's message of "Mon, 01 Sep 2008 04:28:01 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94545>

"George Spelvin" <linux@horizon.com> writes:
> You can be paranoid if you like and cast to long, but I don't think
> even a massive 64-bit cluster is likely to have more than 2G processes
> in the forseeable future.

But it isn't it possible for some OS to use a sparse PID namespace?

-Miles

-- 
Brain, n. An apparatus with which we think we think.
