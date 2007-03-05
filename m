From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Conflict editing
Date: Mon, 5 Mar 2007 01:25:09 -0500
Message-ID: <190CCFDA-7BCC-4CC9-81D5-F38B14D8D54D@silverinsanity.com>
References: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 07:25:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO6dY-00080b-4f
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 07:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbXCEGZO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 01:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbXCEGZO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 01:25:14 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:46154 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbXCEGZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 01:25:13 -0500
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id AE2131FFC02B;
	Mon,  5 Mar 2007 06:25:12 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41402>


On Mar 4, 2007, at 7:43 AM, Johannes Schindelin wrote:

> Of course, this script is dumb and has no way to edit files whose  
> names
> contain spaces

Wouldn't using xargs fix that?

> "${VISUAL:-${EDITOR:-vi}}" $(git ls-files --unmerged | cut -b51- |  
> uniq)

git ls-files --unmerged | cut -b51- | uniq | xargs "${VISUAL:-$ 
{EDITOR:-vi}}"

~~ Brian Gernhardt
