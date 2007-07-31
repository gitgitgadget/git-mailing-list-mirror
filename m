From: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Re: Git error on Cygwin
Date: Tue, 31 Jul 2007 14:29:47 +0200
Message-ID: <46AF2B3B.2060802@gmail.com>
References: <46AE1D77.8040609@gmail.com> <81b0412b0707310051n4e62257bt279f65d159757876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 14:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFqrV-0001di-88
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 14:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbXGaM3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 08:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbXGaM3u
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 08:29:50 -0400
Received: from ms01.sssup.it ([193.205.80.99]:42707 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751367AbXGaM3t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 08:29:49 -0400
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
  by sssup.it (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 32431465; Tue, 31 Jul 2007 14:20:34 +0200
Received: from [10.30.3.110] ([10.30.3.110])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id l6VBQrqi012401;
	Tue, 31 Jul 2007 13:26:53 +0200
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <81b0412b0707310051n4e62257bt279f65d159757876@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54342>

Alex Riesen wrote:
> On 7/30/07, Claudio Scordino <cloud.of.andor@gmail.com> wrote:
>> Hi all,
>>
>>    I just installed cygwin on Windows XP and I have the following error when
>> using git-clone.
>>
>> (Consider that the same command on the same repository works on Linux).
> 
> Definitely.
> 
>> $ git-clone <username>@<host>:/<path>/<project>
>> Initialized empty Git repository in /home/Claudio/<project>/.git/
>> <username>@<host>'s password:
>> remote: Generating pack...
>> remote: Done counting 30387 objects.
>> remote: Deltifying 30387 objects...
>> remote:  100% (30387/30387) done
>> Indexing 30387 objects...
>> remote: Total 30387 (delta 4446), reused 30188 (delta 4351)
>>   100% (30387/30387) done
>> Resolving 4446 deltas...
>>   100% (4446/4446) done
>>        3 [main] git-read-tree 2160 C:\cygwin\bin\git-read-tree.exe: *** fatal
>> error - could not load shell32, Win32 error 487
>> /usr/bin/git-clone: line 404:  2160 Hangup                  git-read-tree -m -u
>> $v HEAD HEAD
> 
> Report this to cygwin team. 

Done. :)

> Try rerunning the command, usually
> it helps (typical workaround for cygwin).

Unfortunately it does not.

Hopefully someone from the cygwin team will help me.

Many thanks,

           Claudio
