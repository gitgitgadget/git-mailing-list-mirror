From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Add getTaggerIdent, getShortMessage, getFullMessage to RevTag
Date: Wed, 28 Jan 2009 21:10:48 +0100
Message-ID: <200901282110.48899.robin.rosenberg.lists@dewire.com>
References: <1233117316-3291-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:12:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSGlr-0006KO-Hl
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 21:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbZA1UK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 15:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZA1UK5
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 15:10:57 -0500
Received: from mail.dewire.com ([83.140.172.130]:22465 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbZA1UK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 15:10:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C39A3147E704;
	Wed, 28 Jan 2009 21:10:50 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mW+F4C3DZc3W; Wed, 28 Jan 2009 21:10:49 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id B801D147E703;
	Wed, 28 Jan 2009 21:10:49 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <1233117316-3291-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107567>

onsdag 28 januari 2009 05:35:16 skrev Shawn O. Pearce:
> These methods make the RevTag API more like the RevCommit API, such
> that it is more consistent for applications to access the "fields"
> of a tag object in the same way that they access the fields of any
> commit object.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> 
>  Actually, this has also gone through Gerrit2.  If you want to see
>  what the same patch looks like (just for fun):

The reviewer is biased :) Where are the unit tests?

I'm kind of surprised you did not optimized skipping past the object header,
like the parents are skipped when parsing commits.

-- robin
