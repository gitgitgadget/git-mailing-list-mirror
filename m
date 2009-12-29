From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Wrap completions in `type git' conditional statement.
Date: Wed, 30 Dec 2009 06:54:32 +0900
Message-ID: <20091230065432.6117@nanako3.lavabit.com>
References: <44A6FDEB-71B6-42E1-99E3-D6A595FF1B58@metablu.com> <20091229200530.6117@nanako3.lavabit.com> <20091229150217.GB6152@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Sung Pae <sung@metablu.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 22:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPk27-00022l-Fu
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbZL2VzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbZL2VzI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:55:08 -0500
Received: from karen.lavabit.com ([72.249.41.33]:60531 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbZL2VzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:55:07 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id EF264157541;
	Tue, 29 Dec 2009 15:55:04 -0600 (CST)
Received: from 9445.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id ZQ4XDMYS9EET; Tue, 29 Dec 2009 15:55:04 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=S+4SeHoJF8nTti6QsV48DTFUNgw6W2yIscVTCUfD1vA8kS1pcOyxKvN0Py73PqxfSlR8VlJtHLV7kL8u0q8BRCLkmjgjtIrZ2qtAZlSjqAsvz1tQfaCv//1Fw/keaUFGzqSHwon/EsQ2baT3pVpzZE46V0BofFl70dW2TewTMgI=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091229150217.GB6152@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135836>

Quoting Shawn O. Pearce <spearce@spearce.org>:

> Nanako Shiraishi <nanako3@lavabit.com> wrote:
>> Junio, could you tell us what happened to this thread?
>> 
>> The patch avoids failing completion script when git is not there.
>> No discussion.
>
> Actually, that's probably my fault.  I never sent an ack or nak,
> or anything else really, on this thread.
>
> Originally this was because the completion was trying to run git
> as it loaded.  In 1.6.6 this is no longer true, the completion list
> is generated lazily on demand during the first completion attempt.
>
> With the lazy loading, I didn't see a reason to add this ugly block
> around the entire script.
>
> -- 
> Shawn.

Thank you for your explanation.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
