From: Alfred Perlstein <bright@mu.org>
Subject: Re: Undelivered Mail Returned to Sender
Date: Sat, 21 Feb 2015 13:18:19 -0800
Message-ID: <C6B113CE-FEEB-481D-ACDE-D239DB8E1AF0@mu.org>
References: <20150221210915.3734E341F916@elvis.mu.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Technext <varuag.chhabra@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 22:14:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPHNe-0002HF-Bw
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 22:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbbBUVOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 16:14:22 -0500
Received: from elvis.mu.org ([192.203.228.196]:21538 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbbBUVOV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 16:14:21 -0500
Received: from [10.0.1.100] (c-76-21-10-192.hsd1.ca.comcast.net [76.21.10.192])
	by elvis.mu.org (Postfix) with ESMTPSA id 38CDE341F8AC;
	Sat, 21 Feb 2015 13:14:21 -0800 (PST)
In-Reply-To: <20150221210915.3734E341F916@elvis.mu.org>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264228>


On Feb 20, 2015, at 9:16 PM, Technext wrote:

> Thanks Junio for the prompt reply! :) Yes, that's exactly how i would like
> things to be. I'll definitely try to push this thing and see if this flow
> can be implemented.
> 
> However, can you please guide me whether there's any way i could have
> figured out about the git reset command that the developer executed on his
> local? (my first query)
> 
> Also, am i right in thinking that a check cannot be implemented using hooks
> or any other similar way? (my second query)


We have this on our repo.git/config file:

[receive]
    denyDeletes = true
    denyNonFastForwards = true

This should prevent people from
denyDeletes - deleting a branch
denyNonFastForwards - force push/reset of a remote branch

-Alfred
