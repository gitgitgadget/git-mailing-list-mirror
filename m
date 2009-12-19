From: Bill Lear <rael@zopyra.com>
Subject: Re: Query remote repository files, blobs
Date: Sat, 19 Dec 2009 07:31:08 -0600
Message-ID: <19244.54684.250532.801766@lisa.zopyra.com>
References: <d16b1c80912182345h4163430bv810adb860575d67a@mail.gmail.com>
	<alpine.DEB.1.00.0912191159280.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Shakthi Kannan <shakthimaan@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 19 14:32:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLzQY-0007Ww-2g
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 14:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbZLSNbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 08:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbZLSNbP
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 08:31:15 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:48500
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbZLSNbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 08:31:14 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id nBJDVBA02856;
	Sat, 19 Dec 2009 07:31:11 -0600
In-Reply-To: <alpine.DEB.1.00.0912191159280.4985@pacific.mpi-cbg.de>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135479>

On Saturday, December 19, 2009 at 12:02:02 (+0100) Johannes Schindelin writes:
>On Sat, 19 Dec 2009, Shakthi Kannan wrote:
>...
>> I am able to query for list of remote heads, and tags. I would like to
>> know if it is possible to query for information on remote files, or
>> blobs?
>
>This has been discussed a number of times, but we cannot allow that for 
>security reasons.  A blob might contain confidential information, in which 
>case the branch has to be rewritten and force-pushed.  However, that does 
>not make the blob go away, but makes it only unreachable.  Until the next 
>garbage collection kicks in, that is (which you typically cannot control).

Hmm, I thought this had been addressed by git in a different way (removing
confidential information).  A company will not be satisfied that its
proprietary information is "unreachable" in your software repository.
They want absolute assurance that the information is completely
removed.

Have I remembered wrongly --- is this still not possible with git?


Bill
