From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 00:45:50 +0000
Message-ID: <A61EFF37-A235-49C3-8F1F-64B4FB26D10B@simplicidade.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org> <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org> <E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org> <alpine.LSU.1.00.0801170034300.17650@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:46:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFItn-0000WH-GV
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbYAQAqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbYAQAp7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:45:59 -0500
Received: from mail.sl.pt ([212.55.140.13]:39262 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750934AbYAQAp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 19:45:59 -0500
Received: (qmail 6906 invoked from network); 17 Jan 2008 00:45:56 -0000
X-Virus-Status: Clean (0.01207 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00008 seconds / 0.57710 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.209]) (melo@[85.240.106.162])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <torvalds@linux-foundation.org>; 17 Jan 2008 00:45:56 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 85.240.106.162 as permitted sender)
In-Reply-To: <alpine.LSU.1.00.0801170034300.17650@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70791>


On Jan 17, 2008, at 12:35 AM, Johannes Schindelin wrote:
> On Thu, 17 Jan 2008, Pedro Melo wrote:
>
>> The content of the file is sacred, we both agree on that. We  
>> disagree on
>> the filename, because for me it's more important that equal strings,
>> even if encoded to different byte sequences, should be treated as the
>> same file.
>
> Why should the filename be _stored_ normalised?  I agree on the  
> lookup,
> yes, but not the storage.

Personally I don't care how you store it. It's an implementation  
detail, and you should choose the best one for your use cases. If  
that means that you store the original version and a normalized  
version just for lookups, fine.

What I think its important is that if two users use different  
encodings for the same string in a filename, git should treat that as  
the same file.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
