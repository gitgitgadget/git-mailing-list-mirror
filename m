From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Fri, 28 Feb 2014 09:14:26 +0000
Message-ID: <20140228091426.GA30620@hashpling.org>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
 <20140226202601.GK7855@google.com>
 <857g8f1ugu.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 10:20:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJcc-0007Fx-C4
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbaB1JUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:20:39 -0500
Received: from avasout06.plus.net ([212.159.14.18]:51583 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaB1JUg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:20:36 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2014 04:20:36 EST
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id XlES1n00C2iA9hg01lETrS; Fri, 28 Feb 2014 09:14:31 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=dodVCjQ4 c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=zd_RDMET5nsA:10 a=LvP0_KzCtzkA:10 a=mSBy96HJJ2wA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=Ew9TdX-QAAAA:8 a=XqX2msqmRPgA:10
 a=pGLkceISAAAA:8 a=DSyDzioMT5iJJgsouxwA:9 a=CjuIK1q_8ugA:10 a=MSl-tDqOz04A:10
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1WJJWU-00082n-Gn; Fri, 28 Feb 2014 09:14:26 +0000
Content-Disposition: inline
In-Reply-To: <857g8f1ugu.fsf@stephe-leake.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242918>

On Fri, Feb 28, 2014 at 03:01:53AM -0600, Stephen Leake wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> > And for experienced users, this would be a bad regression.
> 
> Backward incompatibility is a real concern.
> 
> It might be best if "git reset" (with _no_ option) be made to error out,
> so all users have to specify what they want.

This is just as much of a regression (if less dangerous) as changing
the default behaviour of git reset to touch the working tree.

'git reset' is a very, very common action for me and simply means
'reset [my index] [to HEAD]'. I frequently find myself resetting so
that I can stage something a bit different to what I had originally
intended.
