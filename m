From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: how to analyze binary delta compression
Date: Wed, 25 Apr 2012 16:15:32 -0500
Message-ID: <jn9phl$t7s$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 23:15:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN9Z2-00029V-QY
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 23:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759317Ab2DYVPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 17:15:48 -0400
Received: from plane.gmane.org ([80.91.229.3]:49003 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759147Ab2DYVPr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 17:15:47 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SN9Yu-0001zJ-7Y
	for git@vger.kernel.org; Wed, 25 Apr 2012 23:15:44 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 23:15:44 +0200
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 23:15:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196338>

I need to assess the delta compression efficiency of various types of 
binaries.  Can I do it this way:

(1) Run git diff between two versions of a binary and pipe the result to 
a file.  (Sample different types of binaries and changes.)
(2) Assess the output by size or format or content to determine how well 
it delta differenced?  How would I determine this?  What are good 
absolute delta sizes?  What are good delta size ratios compared to total 
file size?  Is the number of hunks in the delta important?
(3) Compress the delta file with gzip (or something) and then assess the 
compression ratio?  What is a good compression ratio?  What are good 
delta compressed absolute sizes?  What are good delta compressed 
relative sizes to total file size?

I'm sure I may be missing some things here.  I'm new to assessing delta 
compression efficiency of binaries in general, and specifically for git. 
  Please advise.

v/r,
neal
