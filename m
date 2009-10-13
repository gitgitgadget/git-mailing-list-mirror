From: Tony Finch <dot@dotat.at>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Tue, 13 Oct 2009 18:46:18 +0100
Message-ID: <alpine.LSU.2.00.0910131842440.11815@hermes-1.csi.cam.ac.uk>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca> <20091012135910.ujqifycf9cwsk4ss@webmail.demarque.qc.ca> <f488382f0910121106h64571b93jb92372a1d7720b10@mail.gmail.com> <81b0412b0910121115s26c6c08s1ea54c28851faf05@mail.gmail.com>
 <20091012142017.vrs4v2cc8wgws8g4@webmail.demarque.qc.ca> <20091012183519.GA10686@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sylvain@demarque.qc.ca, Alex Riesen <raa.lkml@gmail.com>,
	Steven Noonan <steven@uplinklabs.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 19:55:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxlaf-0006ip-7J
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 19:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760384AbZJMRrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 13:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757493AbZJMRrT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 13:47:19 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:44688 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbZJMRrS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 13:47:18 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:46700)
	by ppsw-5.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.155]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MxlRz-0005UP-GB (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 13 Oct 2009 18:46:19 +0100
Received: from fanf2 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MxlRy-0004Ff-WA (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 13 Oct 2009 18:46:19 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <20091012183519.GA10686@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130170>

On Mon, 12 Oct 2009, Jeff King wrote:
>
>   $ cd /
>   $ git init
>   $ cd /etc/whatever
>   $ git add .

One reason that you don't want to do this (even if it does work) is that
careless use of git (e.g. by a user who is not the sysadmin playing with
git in their home directory) is going to find the root repository when you
expect it not to find any repository.

Also, I suggest this little wrapper script:
http://dotat.at/cgi/git?p=git-deploy.git;a=blob;f=git-root.sh

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
