From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 18:12:53 +0000
Message-ID: <6E1A0E9A-34D7-4D85-BD4B-CF56CE3927CA@simplicidade.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mark Junker <mjscod@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:13:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZFB-0008Lg-5H
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbYAQSM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbYAQSM5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:12:57 -0500
Received: from mail.sl.pt ([212.55.140.13]:44343 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752902AbYAQSM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 13:12:57 -0500
Received: (qmail 5512 invoked from network); 17 Jan 2008 18:12:53 -0000
X-Virus-Status: Clean (0.01066 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00008 seconds / 0.33425 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.209]) (melo@[81.193.151.201])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 17 Jan 2008 18:12:53 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 81.193.151.201 as permitted sender)
In-Reply-To: <478F99E7.1050503@web.de>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70889>

Hi,

On Jan 17, 2008, at 6:09 PM, Mark Junker wrote:
> Linus Torvalds schrieb:
> IMHO it would be the best solution when git stores all string meta  
> data in UTF-8 and converts it to the target systems file system  
> encoding. That would fix all those problems with different locales  
> and file system encodings ...

+1.

And I would suggest the use of RFC 3454 as the guidelines for UTF-8  
normalization.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
