From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: Re: [PATCH 0/6] Add core.autocrlf=true on cygwin by default during
 tests
Date: Tue, 12 May 2009 14:16:28 -0400
Message-ID: <4A09BCFC.4080307@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com> <alpine.DEB.1.00.0905112253580.27348@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Tue May 12 20:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3wX7-0004zy-1O
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 20:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbZELSQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 14:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbZELSQo
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 14:16:44 -0400
Received: from mail51.messagelabs.com ([216.82.241.99]:49402 "HELO
	mail51.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752342AbZELSQn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 14:16:43 -0400
X-VirusChecked: Checked
X-Env-Sender: Don.Slutz@SierraAtlantic.com
X-Msg-Ref: server-15.tower-51.messagelabs.com!1242152203!12107311!1
X-StarScan-Version: 6.0.0; banners=sierraatlantic.com,-,-
X-Originating-IP: [206.86.29.5]
Received: (qmail 4520 invoked from network); 12 May 2009 18:16:44 -0000
Received: from seng.sierraatl.com (HELO USFREEX1.us.corp.sa) (206.86.29.5)
  by server-15.tower-51.messagelabs.com with SMTP; 12 May 2009 18:16:44 -0000
Received: from usbosex1.us.corp.sa ([192.168.17.34]) by USFREEX1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 May 2009 11:16:42 -0700
Received: from [127.0.0.1] ([208.37.241.146]) by usbosex1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 May 2009 14:16:41 -0400
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.DEB.1.00.0905112253580.27348@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 12 May 2009 18:16:41.0619 (UTC) FILETIME=[CC96BE30:01C9D32D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118939>

Based on:

On 5/11/2009 4:54 PM, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 11 May 2009, Don Slutz wrote:
>
>   
>> This is a patch set to do the work from mail message:
>>
>> http://kerneltrap.org/mailarchive/git/2007/8/7/254415
>>
>> It is split into 6 parts.  This is because the tests do not work on
>> Linux if autocrlf=true.
>>
>> 1) The change to autocrlf=true by default for cygwin
>>     
>
> From the fallout of our unilateral decision in msysGit to set 
> autoCRLF=true all the time, I would advise against this change.
>
> Ciao,
> Dscho
>   

On 5/11/2009 4:04 PM, Eric Blake wrote:
> Don Slutz <Don.Slutz <at> SierraAtlantic.com> writes:
>
>   
>> This is a patch set to do the work from mail message:
>>
>> http://kerneltrap.org/mailarchive/git/2007/8/7/254415
>>
>> It is split into 6 parts.  This is because the tests do not work on
>> Linux if autocrlf=true.
>>
>> 1) The change to autocrlf=true by default for cygwin
>>     
>
> I help maintain the cygwin packaging of git, and I don't particularly like 
> patch 1/6.  Cygwin very much recommends that users stick with binary mounts, 
> where cr's are not inserted/stripped by default, and enabling autocrlf in that 
> situation is asking for problems (namely, the same set of problems as you would 
> have on Linux with autocrlf=true).  While adding an environment variable is 
> useful for the case of a user building git on cygwin with the intent of using a 
> text-mode mount, it goes against the grain of cygwin's recommendation of not 
> using text-mode mounts in the first place.  I would rather see the default 
> remain false, even on cygwin, unless the person building git takes steps to 
> activate it themselves.
>
>   
I will change 1/6 into adding the environment variable without the 
default change. v2 sometime soon.
   -Don


__________________________________________________________________________________________________________________
DISCLAIMER:"The information contained in this message and the attachments (if any) may be privileged and confidential and protected from disclosure. You are hereby notified that any unauthorized use, dissemination, distribution or copying of this communication, review, retransmission, or taking of any action based upon this information, by persons or entities other than the intended recipient, is strictly prohibited. If you are not the intended recipient or an employee or agent responsible for delivering this message, and have received this communication in error, please notify us immediately by replying to the message and kindly delete the original message, attachments, if any, and all its copies from your computer system. Thank you for your cooperation." 
________________________________________________________________________________________________________________
