From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: [PATCH] Make git-cvsexportcommit "status" each file in turn
Date: Wed, 15 Aug 2007 16:47:56 +0100
Organization: Insert joke here
Message-ID: <1187192876.13096.60.camel@murta.transitives.com>
References: <1187184448.13096.54.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 17:47:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILL5Z-0000Ke-HA
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 17:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761099AbXHOPrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 11:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbXHOPrN
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 11:47:13 -0400
Received: from mx.transitive.com ([217.207.128.220]:53243 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751503AbXHOPrN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 11:47:13 -0400
Received: from [192.168.2.164] (helo=[192.168.2.164])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1ILKwM-0008Pu-1e
	for git@vger.kernel.org; Wed, 15 Aug 2007 15:37:46 +0000
In-Reply-To: <1187184448.13096.54.camel@murta.transitives.com>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55913>

On Wed, 2007-08-15 at 14:27 +0100, Alex Bennee wrote:
> Hi,
> 
<snip>

> I also slightly formatted the warn output when it detects problems as
> multiple line wraps with long file paths where making my eyes bleed :-)

Which I seem to have missed a bunch of crucial ;'s from

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index ee02c56..65c12b2 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -204,9 +204,9 @@ if (@canstatusfiles) {
 foreach my $f (@afiles) {
     if (defined ($cvsstat{$f}) and $cvsstat{$f} ne "Unknown") {
        $dirty = 1;
-       warn "File $f is already known in your CVS checkout.\n"
-       warn "  Perhaps it has been added by another user.\n"
-       warn "  Or this may indicate that it exists on a different
branch.\n"
+       warn "File $f is already known in your CVS checkout.\n";
+       warn "  Perhaps it has been added by another user.\n";
+       warn "  Or this may indicate that it exists on a different
branch.\n";
        warn "  If this is the case, use -f to force the merge.\n";
        warn "Status was: $cvsstat{$f}\n";
     }

-- 
Alex, homepage: http://www.bennee.com/~alex/
Love may laugh at locksmiths, but he has a profound respect for money
bags. -- Sidney Paternoster, "The Folly of the Wise"
