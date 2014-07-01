From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix filter-branch to eliminate duplicate mapped parents
Date: Tue, 1 Jul 2014 13:11:10 +0100
Message-ID: <20140701121110.GA6656@hashpling.org>
References: <1404163227-30962-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 14:18:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1x1N-0000jb-17
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 14:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbaGAMSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 08:18:44 -0400
Received: from avasout06.plus.net ([212.159.14.18]:54219 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbaGAMSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 08:18:44 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jul 2014 08:18:43 EDT
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout06 with smtp
	id M0Cc1o0072iA9hg010CdDS; Tue, 01 Jul 2014 13:12:38 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=WL/xXxcR c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=PWVUB-qd9LkA:10 a=mSBy96HJJ2wA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=BNFp--SqAAAA:8 a=qdUgMKJmKs7EP1312gMA:9
 a=CjuIK1q_8ugA:10 a=mzCf-x2ZkIwA:10 a=92rhvNbd_XgA:10 a=oZTla_5d5ToA:10
 a=OdfyYJfdu2kA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1X1wty-0001mp-4H
	for git@vger.kernel.org; Tue, 01 Jul 2014 13:11:10 +0100
Content-Disposition: inline
In-Reply-To: <1404163227-30962-1-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252715>

On Mon, Jun 30, 2014 at 10:20:27PM +0100, Charles Bailey wrote:
> From: Charles Bailey <cbailey32@bloomberg.net>
> 
> This change ensure that duplicate parents are pruned before the parent
> filter and ensures that --prune-empty is idempotent, removing all
> empty non-merge commits in a singe pass.

s/change ensure/change ensures/
