From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-commit: '--no-status' Allow suppression of status
	summary in commit msg
Date: Thu, 28 Aug 2008 21:13:02 +0200
Message-ID: <20080828191302.GA2704@blimp.local>
References: <1219949215-10189-1-git-send-email-marcus@griep.us>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:14:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYmwd-0001Rs-Kl
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbYH1TNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 15:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbYH1TNG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:13:06 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:60633 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbYH1TNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:13:05 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20hf4kO7
Received: from tigra.home (Faa1f.f.strato-dslnet.de [195.4.170.31])
	by post.webmailer.de (mrclete mo61) (RZmta 16.47)
	with ESMTP id o03921k7SFWooU ; Thu, 28 Aug 2008 21:13:02 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id B00A7277AE;
	Thu, 28 Aug 2008 21:13:02 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id A747236D1D; Thu, 28 Aug 2008 21:13:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1219949215-10189-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94116>

Marcus Griep, Thu, Aug 28, 2008 20:46:55 +0200:
> Currently, using any editor to edit a commit message for 'git commit'
> kicks of a 'git status' which is then included as comments to give
> the commit author some context. However, in some situations, such as
> having a working tree of many hundred thousand files or on an inefficient
> filesystem, a 'git status' can take a long time to process before
> displaying the commit for editing.
> 
> This patch provides an option to disable the status summary, documents it
> and provides test cases for its operation.

There is prior art:

    http://thread.gmane.org/gmane.comp.version-control.git/66183/focus=66251

and resolution (in the thread, somewhat unclear).
