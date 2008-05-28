From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Completion: Hint whether amend is the right thing to do.
Date: Thu, 29 May 2008 01:33:48 +0200
Message-ID: <200805290133.48490.robin.rosenberg.lists@dewire.com>
References: <200805281608.02000.robin.rosenberg.lists@dewire.com> <7v63sywhkr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 01:37:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VCV-0003dW-SR
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 01:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbYE1XgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 19:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbYE1XgG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 19:36:06 -0400
Received: from av12-2-sn2.hy.skanova.net ([81.228.8.186]:51285 "EHLO
	av12-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbYE1XgF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 19:36:05 -0400
Received: by av12-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id C878638860; Thu, 29 May 2008 01:36:01 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id A9CE83885A; Thu, 29 May 2008 01:36:01 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 92FFC37E51;
	Thu, 29 May 2008 01:36:01 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v63sywhkr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83148>

onsdagen den 28 maj 2008 17.53.40 skrev Junio C Hamano:
> Does this mean that it would help reduce mistakes if "git commit --amend"
> noticed the presense of .dotest-merge but absense of .dotest-merge/amend
> and refused to operate, I have to wonder?

Well I found myself making these mistakes. That would probably be better. 
Shouldn't one block commit without amend too then? And then rebase needs
another option to be able to commit. Fixing the prompt was easier at the time .)

-- robin
