From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Fri, 14 Aug 2009 17:54:50 -0500
Message-ID: <200908141754.51393.luke@dashjr.org>
References: <200908121726.52121.luke-jr@utopios.org> <200908141539.18087.luke@dashjr.org> <20090815063958.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Luke Dashjr <luke-jr+git@utopios.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:55:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc5fs-00077B-NI
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 00:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265AbZHNWy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 18:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757259AbZHNWy7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 18:54:59 -0400
Received: from unused ([66.216.20.21]:55151 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757242AbZHNWy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 18:54:58 -0400
Received: from tsuruki.localnet (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	(Authenticated sender: luke-jr)
	by zinan.dashjr.org (Postfix) with ESMTPSA id 72D7AB9C259;
	Fri, 14 Aug 2009 22:54:54 +0000 (UTC)
User-Agent: KMail/1.12.0 (Linux/2.6.27-gentoo-r7; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090815063958.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125966>

On Friday 14 August 2009 04:39:58 pm Nanako Shiraishi wrote:
> Second of all, if a race condition makes an "add" fail, isn't it a good
> thing? If your "add" ignored such a failure, you'd be recording an
> inconsistent or incomplete state.

If the file doesn't exist, it is no longer in the current state.

> IMHO, fixing your racy script is a much cleaner solution to your problem
> than forcing "git add" to ignore errors.

In this situation, the race condition is not a bug, it is normal operation.
