From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 18:38:47 +0000
Message-ID: <10F7A0B4-AF3C-456A-BC2A-7687FF264E31@simplicidade.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <6E1A0E9A-34D7-4D85-BD4B-CF56CE3927CA@simplicidade.org> <alpine.LSU.
 1.00.0801171817340.5731@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:39:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZe4-0002Qo-IR
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbYAQSiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYAQSiv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:38:51 -0500
Received: from mail.sl.pt ([212.55.140.13]:60823 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752127AbYAQSiu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 13:38:50 -0500
Received: (qmail 18691 invoked from network); 17 Jan 2008 18:38:48 -0000
X-Virus-Status: Clean (0.01523 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00008 seconds / 0.72879 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.209]) (melo@[81.193.151.201])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <mjscod@web.de>; 17 Jan 2008 18:38:48 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 81.193.151.201 as permitted sender)
In-Reply-To: <alpine.LSU.1.00.0801171817340.5731@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70897>

Hi,

On Jan 17, 2008, at 6:18 PM, Johannes Schindelin wrote:
> On Thu, 17 Jan 2008, Pedro Melo wrote:
>> On Jan 17, 2008, at 6:09 PM, Mark Junker wrote:
>>
>>> IMHO it would be the best solution when git stores all string meta
>>> data in UTF-8 and converts it to the target systems file system
>>> encoding. That would fix all those problems with different  
>>> locales and
>>> file system encodings ...
>>
>> +1.
>
> -1.
>
> It's just too arrogant to force your particular preferences down the
> throat of every git user.

Do you agree that you need to store or at least calculate a  
normalized version of each filename to see if you are already  
tracking the file, to take in account all the the filesystems out  
there who are not case-preserving, case-sensitive?

If so, do you think those rules should be an option? Or a preference?

Should I specify in my config file that I want my filenames to be  
normalized?

Ignoring encoding, and case-sensitive issues in the git index creates  
problems for those people who want/need to use non-ascii chars in  
their filenames, and have some change of being able to collaborate  
with other users on different operating systems.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
