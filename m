From: Liam Clarke <liam.clarke-hutchinson@adscale.co.nz>
Subject: Re: git merge auto-commit doesn't fire pre-commit hook
Date: Thu, 17 Feb 2011 18:05:25 +1300
Message-ID: <542F1586-F49F-4CD4-A15A-0C7002EB8CE1@adscale.co.nz>
References: <1F3B7FF9-6348-4197-A6B7-23C4DA144920@adscale.co.nz> <AANLkTimCdQL879kBZiktB49eSvoAGT0pX5DKX0SHFOVB@mail.gmail.com> <6F190320-19AF-4F4A-9AE9-0DDA0839C5FD@adscale.co.nz> <AANLkTim+_s5S46QwhHLquMLsoqCwLASdyeW1Lu6md=TB@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 06:05:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppw3k-0001rg-1z
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 06:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab1BQFF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 00:05:28 -0500
Received: from 85.25.69.111.dynamic.snap.net.nz ([111.69.25.85]:54290 "EHLO
	mail.toc.org.nz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751780Ab1BQFF0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 00:05:26 -0500
Received: from imac24.toc.org.nz (imac24.toc.org.nz [10.13.11.74])
	by mail.toc.org.nz (Postfix) with ESMTP id 6A1C2282EEF4;
	Thu, 17 Feb 2011 18:05:25 +1300 (NZDT)
In-Reply-To: <AANLkTim+_s5S46QwhHLquMLsoqCwLASdyeW1Lu6md=TB@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167040>

It can't affect the merge, but I could check for the data's existence, rm it, commit the deletion, and then scold the naughty developer... Yeah, not a bad idea actually. :) Cheers Jay.

On 17/02/2011, at 5:52 PM, Jay Soffian wrote:

> On Wed, Feb 16, 2011 at 11:44 PM, Liam Clarke
> <liam.clarke-hutchinson@adscale.co.nz> wrote:
>> What about when I'm merging my own feature branches into master? Also, past performance indicates that yelling about bad stuff in merges works quite well when they're in the same office as you...
> 
> BTW, why not just use the post-merge hook to amend the merge after the fact?
> 
> j.
