From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 13:20:28 -0400
Message-ID: <20120326172028.GB12843@hmsreliant.think-freely.org>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
 <7vvclvrrad.fsf@alter.siamese.dyndns.org>
 <20120324165536.GA17932@neilslaptop.think-freely.org>
 <7v1uofqoa7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:20:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCDax-0004IU-53
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933082Ab2CZRUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:20:34 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:36959 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932742Ab2CZRUd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:20:33 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SCDan-0001xc-Vc; Mon, 26 Mar 2012 13:20:31 -0400
Content-Disposition: inline
In-Reply-To: <7v1uofqoa7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193933>

On Mon, Mar 26, 2012 at 10:12:48AM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Is there a way to differentiate a commit that is made empty as the result of a
> > previous patch in the rebase, and a commit that is simply empty?
> 
> An empty commit has the same tree object as its parent commit.
> 
Got it, thanks!

> > I agree, I think perhaps adding an --allow-empty option to the rebase logic, so
> > that empty commits (or perhaps just initially empty, as opposed to commits made
> > empty) would be very beneficial.
> 
> Yeah, that probably may make sense.
> 
Ok, cool, I'll have a patch in a few days, thanks!
Neil
