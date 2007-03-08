From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Git building is borked
Date: Thu, 8 Mar 2007 15:19:14 +0000
Message-ID: <C8A6CE49-CBAE-415E-8F40-D1062ECBD2F9@cam.ac.uk>
References: <4BBB354C-B000-4EF7-B3FF-7B2A4D6DE538@cam.ac.uk> <F0177878-0A2B-43B0-9838-E032FB3A0A58@cam.ac.uk> <20070308145532.GA30674@spearce.org> <C5E8BD06-1404-403B-88D0-F24F386A14AF@cam.ac.uk> <20070308151302.GC30674@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:19:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPKPK-0003ZP-81
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 16:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbXCHPTm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 10:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbXCHPTm
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 10:19:42 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:48449 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbXCHPTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 10:19:42 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from pcuxsup2.csi.cam.ac.uk ([131.111.10.66]:49815)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:587)
	with esmtpsa (PLAIN:aia21) (TLSv1:AES128-SHA:128)
	id 1HPKOh-0002fj-Vh (Exim 4.63)
	(return-path <aia21@cam.ac.uk>); Thu, 08 Mar 2007 15:19:16 +0000
In-Reply-To: <20070308151302.GC30674@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41750>

On 8 Mar 2007, at 15:13, Shawn O. Pearce wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>> On 8 Mar 2007, at 14:55, Shawn O. Pearce wrote:
>>> What version of Git specifically are you building with?  How did
>>> you obtain these source files?
>>
>> On my old workstation (Linux) which has the git git tree on it I
>> tarred up the files in the git directory (not including the .git
>> directory), then scp-ed the tar ball to my new workstation (OSX),
>> untarred it there and tried to build git to boot strap...
>
> Since you solved your problem, this is more for the list archives
> than anything:
>
> Use `make dist` instead.  It uses your currently installed Git
> to generate a tarball from the revision in HEAD, then appends in
> the 4 critical files.  I use this all of the time (almost daily,
> or close to it) to do builds of Git on Cygwin and Solaris 9.
> In both cases I am building without `git` (or .git) available,
> and am relying on just the output of `make dist`.

Ah, that is cool.  Thanks.  I will use that next time.  (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
