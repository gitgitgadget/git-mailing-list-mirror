From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 00:27:52 +0000
Message-ID: <E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org> <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:28:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFIcL-0003YW-GZ
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYAQA15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbYAQA15
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:27:57 -0500
Received: from mail.sl.pt ([212.55.140.13]:36008 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751598AbYAQA15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 19:27:57 -0500
Received: (qmail 31597 invoked from network); 17 Jan 2008 00:27:54 -0000
X-Virus-Status: Clean (0.01675 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00008 seconds / 0.08041 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.209]) (melo@[85.240.106.162])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <kevin@sb.org>; 17 Jan 2008 00:27:54 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 85.240.106.162 as permitted sender)
In-Reply-To: <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70784>

Hi,

On Jan 17, 2008, at 12:16 AM, Linus Torvalds wrote:
> On Wed, 16 Jan 2008, Pedro Melo wrote:
>>
>> The difference I see between us is that if I tell my filesystem  
>> that I want to
>> name my file with a particular string encoded in X, users using  
>> encoding Y
>> will be able to read it correctly. I  like my filesystem to make  
>> that work for
>> me.
>
> The difference I see between us is that when I tell you that this is
> exactly the same thing as your file *contents*, you don't seem to  
> get it.

I get that you think its the same thing.

What I don't get is why a user should be forced to know what type of  
encoding he and the other users are using on all the layers going  
down to the filesystem. If two users on different systems or in  
different configurations, choose the same unicode string as the name,  
why do we need to make it harder for things to just work out?

The content of the file is sacred, we both agree on that. We disagree  
on the filename, because for me it's more important that equal  
strings, even if encoded to different byte sequences, should be  
treated as the same file.

> An OS that silently changes the contents of your files is *crap*.
>
> Get it?

I was not talking about content of files, those are sacred. I was  
talking about filenames. Those *for me* are not, but are for you. No  
problem, we just have different values: I want my computer to work  
for me, not me working for the computer. I'm willing to accept a file  
system or other layer that normalizes encoding of filenames if that  
makes the end-user life easier, specially in a tool distributed by  
nature.

> An OS that silently changes the contents of your directories is  
> *crap*.
>
> Get it now?

As I said before, we disagree on file meta-data, not on file  
contents. For you, byte in must be the same byte out. For me string  
in must be the same string out.

And as I said in the previous email, what I learned today is that in  
a distributed project using git, and if you need to use accented  
characters, I need to tell all the users to use the same LANG settings.

It's important information, at least for me.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
