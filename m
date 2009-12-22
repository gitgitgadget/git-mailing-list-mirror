From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Trouble with 'make prefix=/usr info'
Date: Tue, 22 Dec 2009 18:22:28 +0100
Message-ID: <4B310054.4060900@drmicha.warpmail.net>
References: <loom.20091222T164442-704@post.gmane.org>	 <4B30ECA1.2040508@drmicha.warpmail.net> <d4133e470912220814h465175bfr8fd10942898096a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Craig Moore <craigtmoore@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 18:24:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN8Sw-0002ru-16
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 18:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbZLVRYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 12:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754286AbZLVRYB
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 12:24:01 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45873 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753761AbZLVRYA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 12:24:00 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D1B9AC7F95;
	Tue, 22 Dec 2009 12:23:58 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 22 Dec 2009 12:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Ed4XglkeAT55hBDPBzEgeFYTls0=; b=XSO9wqh3L0berXqdaaPzSZNhI3hQaSAoNMPUQbChA4gDGBnESvDAjUsbBCdKvd5shqmEGfbxF7v+8oLtpYzn1n0tsVEtSyEgFU1dwXeuKpEC5zWEoCKc8GM4ygJpGS4ujG6HVQQhhRXNNIZi1ZAhTBsonBrB6TxH/tuRSwsUPII=
X-Sasl-enc: sy0EXbXQA0ze8R2voau3M11X23/aXfnmB8aqjC3kfO5U 1261502638
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 063674B95C9;
	Tue, 22 Dec 2009 12:23:57 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <d4133e470912220814h465175bfr8fd10942898096a1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135585>

Craig Moore venit, vidit, dixit 22.12.2009 17:14:
> 2009/12/22 Michael J Gruber <git@drmicha.warpmail.net>:
>> Craig Moore venit, vidit, dixit 22.12.2009 16:50:
>>> Hi,
>>>
>>> I'm getting the following error when I make the info target:
>>>
>>> $ make prefix=/usr info
>>> make -C Documentation info
>>> make[1]: Entering directory `/local/software/git-1.6.5.7/Documentation'
>>> make[2]: Entering directory `/local/software/git-1.6.5.7'
>>> make[2]: `GIT-VERSION-FILE' is up to date.
>>> make[2]: Leaving directory `/local/software/git-1.6.5.7'
>>>     DB2TEXI user-manual.texi
>>> Usage: jw [<options>] <sgml_file>
>>> where <options> are:
>>>   -f|--frontend <frontend>:      Specify the frontend (source format)
>>>                                  (default is docbook)
>>>   -b|--backend <backend>:        Specify the backend (destination format)
>>>                                  (default is html)
>>>   -c|--cat <file>:               Specify an extra SGML open catalog
>>>   -n|--nostd:                    Do not use the standard SGML open catalogs
>>>   -d|--dsl <file>|default|none:  Specify an alternate style sheet
>>>                                  (default is to use the default stylesheet)
>>>   -l|--dcl <file>:               Specify an alternate SGML declaration
>>>                                  (usual ones like xml.dcl get detected
>>> automatically)
>>>   -s|--sgmlbase <path>:          Change base directory for SGML distribution
>>>                                  (usually /usr/share/sgml)
>>>   -p|--parser <program>:         Specify the parser if several are installed
>>>                                   (jade or openjade)
>>>   -o|--output <directory>:       Set output directory
>>>   -u|--nochunks:                 Output only one big file
>>>                                  (overrides the stylesheet settings)
>>>   -i|--include <section>:        Specify a SGML marked section to include
>>>                                  (should be marked as "ignore" in the SGML text)
>>>   -w|--warning <warning_type>|list: Control warnings or display the allowed
>>> warning types
>>>   -e|--errors <error_type>|list: Control errors or display the allowed error types
>>>   -h|--help:                     Print this help message and exit
>>>   -V <variable[=value]>:         Set a variable
>>>   -v|--version:                  Print the version and exit
>>> make[1]: *** [user-manual.texi] Error 1
>>> make[1]: Leaving directory `/local/software/git-1.6.5.7/Documentation'
>>> make: *** [info] Error 2
>>>
>>> I can see that the error is likely related to the fact that it enters the
>>> Documentation directing, then exits the Documentation directory, and then tries
>>> to build the user-manual.texi file in the root directory (however, that file is
>>> in the Documentation directory, which it just left). I've tried to track down
>>> and change where it exits the Documentation directory, but I've had no success.
>>>
>>> I would appreciate any recommendations you might have. I've already been able to
>>> install git, but I couldn't install the 'info' target because of this error.
>>
>> Does it work without prefix?
>> Also, you may want to cd into Documentation and try to make there.
>>
>> Michael
>>
>>
> 
> Hey Michael,
> 
> Here is what happens when I run it inside the Documentation directory
> (without the prefix):
> 
> user@server: /local/software/git-1.6.5.7/Documentation
> $ make info
>     SUBDIR ../
> make[1]: `GIT-VERSION-FILE' is up to date.
>     DB2TEXI user-manual.texi
> Usage: jw [<options>] <sgml_file>
> where <options> are:
>   -f|--frontend <frontend>:      Specify the frontend (source format)
>                                  (default is docbook)
>   -b|--backend <backend>:        Specify the backend (destination format)
>                                  (default is html)
>   -c|--cat <file>:               Specify an extra SGML open catalog
>   -n|--nostd:                    Do not use the standard SGML open catalogs
>   -d|--dsl <file>|default|none:  Specify an alternate style sheet
>                                  (default is to use the default stylesheet)
>   -l|--dcl <file>:               Specify an alternate SGML declaration
>                                  (usual ones like xml.dcl get detected
> automatically)
>   -s|--sgmlbase <path>:          Change base directory for SGML distribution
>                                  (usually /usr/share/sgml)
>   -p|--parser <program>:         Specify the parser if several are installed
>                                   (jade or openjade)
>   -o|--output <directory>:       Set output directory
>   -u|--nochunks:                 Output only one big file
>                                  (overrides the stylesheet settings)
>   -i|--include <section>:        Specify a SGML marked section to include
>                                  (should be marked as "ignore" in the SGML text)
>   -w|--warning <warning_type>|list: Control warnings or display the
> allowed warning types
>   -e|--errors <error_type>|list: Control errors or display the allowed
> error types
>   -h|--help:                     Print this help message and exit
>   -V <variable[=value]>:         Set a variable
>   -v|--version:                  Print the version and exit
> make: *** [user-manual.texi] Error 1
> 
> The first thing it does is go to the directory above, weird.
> 
> Craig

I think it only looks like that. SUBDIR processing is finished at that
point, and the DB2TEXI line is where user-manual.texi is actually being
processed, and that's what's causing the error. Did you set the texinfo
processor in the Makefile or using variables?

V=1 make info

will show you the exact commands being executed.

Michael
