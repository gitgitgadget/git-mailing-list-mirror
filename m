From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 14:58:01 -0500
Message-ID: <ZSs3H_GRUGTI_yYwSwXULjkMD8YR-hSkoePTFq0NfYvkbDV9N7CgMw@cipher.nrlssc.navy.mil>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com> <NFLo0xGp2o-oBdtr_pq1jvwATe1ZALaD9dHkr5hmKNkU30gr_isMpQ@cipher.nrlssc.navy.mil> <4A130309.2060407@nortel.com> <0WGSJO_TdUxCKWhDCupb3MaPOyPeVNH7Rs_7iKVnQcahmxUpwu8qzw@cipher.nrlssc.navy.mil> <4A130D45.1050207@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Tue May 19 21:58:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6VS8-0004cZ-3w
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 21:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbZEST6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 15:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbZEST6G
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 15:58:06 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60204 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbZEST6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 15:58:05 -0400
Received: by mail.nrlssc.navy.mil id n4JJw20u032256; Tue, 19 May 2009 14:58:02 -0500
In-Reply-To: <4A130D45.1050207@nortel.com>
X-OriginalArrivalTime: 19 May 2009 19:58:02.0328 (UTC) FILETIME=[1DDD8D80:01C9D8BC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119563>

Chris Friesen wrote:
> Brandon Casey wrote:

> <snip>
> 
>> Starting to make sense?
> 
> Yep.  I still need whatever identifier I use to be associated with the
> head of each branch.
> 
> Based on the discussion (thanks for the explanations, by the way) I
> don't see any option other than looping through each branch and using
> tags with the branch name embedded in them to ensure uniqueness across
> the repository.

Based on this, and your other message, it sounds like you want to have a
tag named 'v1.2.3' which is treated differently for each branch.  Since
there is only a single tag namespace, this is not possible.  Tag names
must be unique.

You can also use slashes in tag names.  Perhaps you could have the illusion
of common version numbers by using tag names like $arch/$version?

-brandon
