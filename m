From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Create 'git gc' to perform common maintenance operations.
Date: Wed, 27 Dec 2006 14:11:13 +0100
Message-ID: <20061227131113.GB6115@admingilde.org>
References: <20061227071759.GA23057@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 14:11:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzYYx-0007WO-2o
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 14:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbWL0NLQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 08:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbWL0NLQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 08:11:16 -0500
Received: from mail.admingilde.org ([213.95.32.147]:51189 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805AbWL0NLP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 08:11:15 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GzYYr-0005qI-O4; Wed, 27 Dec 2006 14:11:13 +0100
To: "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20061227071759.GA23057@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35469>

hoi :)

On Wed, Dec 27, 2006 at 02:17:59AM -0500, Shawn O. Pearce wrote:
> Junio asked for a 'git gc' utility which users can execute on a
> regular basis to perform basic repository actions such as:
> 
>  * pack-refs --prune
>  * reflog expire
>  * repack -a -d

what about doing "git-repack -a -d -l" by default?

-- 
Martin Waitz
