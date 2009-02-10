From: Andreas Ericsson <ae@op5.se>
Subject: Re: RFH: spawning pager takes long time when when unconnected from
 	network
Date: Tue, 10 Feb 2009 12:09:12 +0100
Message-ID: <49916058.3070800@op5.se>
References: <loom.20090210T015515-886@post.gmane.org>	 <4991337B.2010102@viscovery.net>	 <loom.20090210T085859-630@post.gmane.org>	 <alpine.DEB.1.00.0902101124160.10279@pacific.mpi-cbg.de> <279b37b20902100253v3cfd8e45kefa6da7de2ea4a4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible+git@gmail.com>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqVo-0001pH-3B
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbZBJLJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbZBJLJQ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:09:16 -0500
Received: from mail.op5.se ([193.201.96.20]:52561 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237AbZBJLJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:09:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EC0511B81363;
	Tue, 10 Feb 2009 12:10:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qIL5ix5YO+l7; Tue, 10 Feb 2009 12:10:25 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 76CBB1B80090;
	Tue, 10 Feb 2009 12:10:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <279b37b20902100253v3cfd8e45kefa6da7de2ea4a4b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109206>

Eric Raible wrote:
> On Tue, Feb 10, 2009 at 2:24 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Tue, 10 Feb 2009, Eric Raible wrote:
>>
>>> Johannes Sixt <j.sixt <at> viscovery.net> writes:
>>>
>>>> Do you have a directory in your PATH that points to a disconnected network
>>>> drive? Do you use the default pager settings, or did you customize the pager?
>>> All components in my path are local.
>> Could you run it with GIT_TRACE=<file>?
>>
>> Ciao,
>> Dscho
>>
> 
> The first thing I tried was to set GIT_TRACE=1, and it doesn't give much:
> trace: built-in: git 'diff' 'ss' '--name-only'
> trace: run_command: 'sh' '-c' 'less'
> 
> The long pause in question begins after the above output is produced
> but before the list of files is shown.  The output is identical when setting
> GIT_TRACE to a file.
> 

Might be a stupid question, but do you have anything network mounted
anywhere in your $PATH?

Do you get the same delay with an absolute path to less in core.pager?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
