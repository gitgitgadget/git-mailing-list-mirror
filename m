From: Mark Junker <mjscod@web.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 19:36:32 +0100
Message-ID: <478FA030.9010807@web.de>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <6E1A0E9A-34D7-4D85-BD4B-CF56CE3927CA@simplicidade.org> <alpine.LSU.
 1.00.0801171817340.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:37:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZc0-0001Y6-Nn
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbYAQSgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbYAQSgn
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:36:43 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:53185 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbYAQSgm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 13:36:42 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4B89EC6FEC6F
	for <git@vger.kernel.org>; Thu, 17 Jan 2008 19:36:32 +0100 (CET)
Received: from [92.195.28.188] (helo=mark-junkers-computer.local)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JFZbK-0005n9-00
	for git@vger.kernel.org; Thu, 17 Jan 2008 19:36:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
In-Reply-To: <alpine.LSU.1.00.0801171817340.5731@racer.site>
X-Sender: mjscod@web.de
X-Provags-ID: V01U2FsdGVkX1//rX0iJRehxmdWs45M/kWzMKkmKR92WLevpRKd
	c3pFssbtenxib+NpY2zE3xxJtrKzzeJUOz5BqQ5GmOPx1PqSSA
	dd1Z6JyeU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70895>

Johannes Schindelin schrieb:

> It's just too arrogant to force your particular preferences down the 
> throat of every git user.

It's not arrogant to make a suggestion. Where is your alternative solution?

However, what about storing an additional information like the file 
system encoding (for every file)? This would result in the same 
behaviour (and speed) as today as long as the file system encoding is 
the same. Conversion will only be done when the targets file system 
encoding is different.

BTW: This reminds me of the code page switching stuff back in the times 
of MS-DOS 4/5. This really wasn't funny.

Regards,
Mark
