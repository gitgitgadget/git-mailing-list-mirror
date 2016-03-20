From: Laurent Arnoud <laurent@spkdev.net>
Subject: Re: [PATCH] Add the tag.gpgsign option to sign all created tags
Date: Sun, 20 Mar 2016 13:20:23 +0100
Message-ID: <20160320122023.GA5139@spk-laptop>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 13:20:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahcLX-0000WB-1v
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 13:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbcCTMU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 08:20:28 -0400
Received: from ns3268618.ip-5-39-81.eu ([5.39.81.144]:51184 "EHLO
	mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227AbcCTMU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 08:20:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.spkdev.net (Postfix) with ESMTPSA id C6F16FF22F;
	Sun, 20 Mar 2016 12:20:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160320042912.GD18312@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289348>

Hi Jeff,

On Sun, Mar 20, 2016 at 12:29:12AM -0400, Jeff King wrote:
> We have commit.gpgsign, so this makes some sense. Would you want to sign
> _all_ tags created with "git tag", including lightweight tags, or only
> those that would already create a tag object (i.e., annotated tags)?

Yes those that create a tag object (annotated tags).
All you suggestions make sense and I will prepare a patch v2.

Cheers,

-- 
Laurent
