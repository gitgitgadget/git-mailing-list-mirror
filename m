From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 00:43:30 +0000
Message-ID: <16C3D0BC-3A70-441C-89D9-71B5F0DA0790@simplicidade.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161619420.2806@woody.linux-foundation.org> <alpine.LSU.1.00.0801170032230.17650@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:44:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFIrr-0008Ob-VY
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbYAQAn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbYAQAn7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:43:59 -0500
Received: from mail.sl.pt ([212.55.140.13]:58994 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750921AbYAQAn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 19:43:58 -0500
Received: (qmail 5937 invoked from network); 17 Jan 2008 00:43:55 -0000
X-Virus-Status: Clean (0.01221 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00007 seconds / 0.04867 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.209]) (melo@[85.240.106.162])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <torvalds@linux-foundation.org>; 17 Jan 2008 00:43:55 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 85.240.106.162 as permitted sender)
In-Reply-To: <alpine.LSU.1.00.0801170032230.17650@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70790>

Hi,

On Jan 17, 2008, at 12:33 AM, Johannes Schindelin wrote:

> On Wed, 16 Jan 2008, Linus Torvalds wrote:
>
>> So if you are a case-insensitive filesystem, then normalization is  
>> sane.
>
> Actually, no.  Even an case-challenged filesystem should keep the
> _original_ name around, if only for the exact same argument you used
> earlier: if the user chooses to capitalise some letters, but not  
> others,
> it is not the filesystem's place to "correct" that.

For the record, HFS+ is case-insensitive but case-preserving so I  
believe they keep the original filename around. I don't have the spec  
in front of me, but from memory I believe that this is what they do.

But I think that focusing on HFS+ is loosing sight of the real  
problem. It's not about encoding at the filesystem, but encoding  
inside the git structures.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
