From: supadhyay <supadhyay@imany.com>
Subject: Re: cvs2git failed in pass2 ...
Date: Tue, 21 Feb 2012 06:19:49 -0800 (PST)
Message-ID: <1329833989049-7304832.post@n2.nabble.com>
References: <1329828722466-7304605.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 15:20:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzqZN-0001G1-Oc
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 15:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab2BUOTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 09:19:50 -0500
Received: from sam.nabble.com ([216.139.236.26]:50572 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755364Ab2BUOTu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 09:19:50 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <supadhyay@imany.com>)
	id 1RzqZJ-0001Bk-1s
	for git@vger.kernel.org; Tue, 21 Feb 2012 06:19:49 -0800
In-Reply-To: <1329828722466-7304605.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191156>

Hi All,

Can any one know how to overcome this error... I tried with --encoding=UTF8
but the same error.

I also gave a try with --fallback-encoding but seems like its exclude
comments from their output as shown below:

Time for pass2 (CleanMetadataPass): 0.590 seconds.
 
cvs2svn Statistics:
------------------
Total CVS Files:              9025
Total CVS Revisions:         39243
Total CVS Branches:          76789
Total CVS Tags:            1276127
Total Unique Tags:             480
Total Unique Branches:          32
CVS Repos Size in KB:       872465
First Revision Date:    Mon Aug  2 15:07:28 2004
Last Revision Date:     Fri Feb 17 13:10:27 2012
------------------
*(These are unaltered CVS repository stats and do not
 reflect tags or branches excluded via --exclude)
Timings (seconds):*
------------------
530.3   pass1    CollectRevsPass
  0.6   pass2    CleanMetadataPass
530.9   total

--
View this message in context: http://git.661346.n2.nabble.com/cvs2git-failed-in-pass2-tp7304605p7304832.html
Sent from the git mailing list archive at Nabble.com.
