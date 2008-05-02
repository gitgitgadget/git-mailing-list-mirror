From: "Eric Raible" <raible@nextest.com>
Subject: Re: gitk: synchronize highlighting in file view for 'f'&'b' commands
Date: Fri, 02 May 2008 11:45:37 -0700
Message-ID: <481B6151.7040707@nextest.com>
References: <279b37b20803171300v748b5d23rcc5c0e534429d1be@mail.gmail.com> <18459.3557.603906.871664@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1";
	format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri May 02 21:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js0Ts-0006hP-AU
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 20:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760760AbYEBS6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 14:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759714AbYEBS6w
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 14:58:52 -0400
Received: from mail.nextest.com ([12.96.234.116]:36498 "EHLO mail.nextest.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758209AbYEBS6v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 14:58:51 -0400
X-Greylist: delayed 791 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 May 2008 14:58:51 EDT
X-PMWin-Version: 2.6.1, Antivirus-Engine: 2.72.0
Thread-Index: AcishLeDIFhbIrI1Qv+3N4WwGcyvCA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1914
Content-Class: urn:content-classes:message
Importance: normal
Received: from [192.168.1.217] ([192.168.1.217]) by mail.nextest.com over TLS secured channel with Microsoft SMTPSVC(5.0.2195.6713); Fri, 2 May 2008 11:45:39 -0700
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <18459.3557.603906.871664@cargo.ozlabs.ibm.com>
X-OriginalArrivalTime: 02 May 2008 18:45:39.0443 (UTC) FILETIME=[B7816430:01C8AC84]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81020>

Paul Mackerras wrote:
> Eric Raible writes:
> 
>> Previously, 'b', backspace, and delete all did the same thing.
>> This changes 'b' to perform the inverse of 'f'.  And both of
>> them now highlight the filename of the currently diff.
> 
> OK, but...
> 
>> +    set file [regsub -- "-* (.*?) -*" [$ctext get $loc "$loc lineend"] "\\1"]
>> +    set cline [$cflist search -regexp [subst {^$file$}] 0.0]
> 
> This seems to be working out the index of the line we want to
> highlight in the file list, but both the callers of highlightfile can
> supply that info much more easily by incrementing a count as they go
> through $difffilestart, as far as I can tell.
> 
> Paul.
> 

That very well might be, but I:

1) wanted to make the smallest possible change
2) didn't peruse the code closely enough to see how to do that

I unfortunately don't have the time to pursue this just now.
Any chance you could take the idea and fly with it?

Thanks - Eric
