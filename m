From: Zabre <427@free.fr>
Subject: Re: Force commit date
Date: Thu, 29 Jan 2009 11:48:57 -0800 (PST)
Message-ID: <1233258537869-2240926.post@n2.nabble.com>
References: <1233253817209-2240539.post@n2.nabble.com> <1233254709681-2240602.post@n2.nabble.com> <200901291955.10769.markus.heidelberg@web.de> <1233255759118-2240702.post@n2.nabble.com> <alpine.LNX.1.00.0901291406000.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 20:50:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LScu9-0001dO-N7
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 20:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbZA2Ts7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 14:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZA2Ts7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 14:48:59 -0500
Received: from kuber.nabble.com ([216.139.236.158]:43245 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbZA2Ts7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 14:48:59 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LScsj-0001oI-SY
	for git@vger.kernel.org; Thu, 29 Jan 2009 11:48:57 -0800
In-Reply-To: <alpine.LNX.1.00.0901291406000.19665@iabervon.org>
X-Nabble-From: 427@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107721>



Daniel Barkalow wrote:
> 
> You may want to consider whether those dates make most sense as the date 
> of the commit, or the date the changes were done; git tracks both of 
> these separately, in part because it's easy to have some work done at one 
> time, and only make the commit that becomes part of the official project 
> history much later (and these may be done by different people).
> 
> The date for the changes being done is set with GIT_AUTHOR_DATE
> 

Thank you Daniel, this is very interesting, having a GIT_COMMITTER_DATE and
a GIT_AUTHOR_DATE enables me to have both dates, and no need to trick the
system then.
-- 
View this message in context: http://n2.nabble.com/Force-commit-date-tp2240539p2240926.html
Sent from the git mailing list archive at Nabble.com.
