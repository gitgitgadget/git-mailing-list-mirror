From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Trouble with 'make prefix=/usr info'
Date: Tue, 22 Dec 2009 16:58:25 +0100
Message-ID: <4B30ECA1.2040508@drmicha.warpmail.net>
References: <loom.20091222T164442-704@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Craig Moore <craigtmoore@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 17:00:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN79f-0004uE-AO
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 17:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbZLVP75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 10:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbZLVP75
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 10:59:57 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48271 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753678AbZLVP74 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 10:59:56 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8558BC82F0;
	Tue, 22 Dec 2009 10:59:55 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 22 Dec 2009 10:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Dg5QEIDfWZYAHcH5gyBtlLwK6Gw=; b=jLZsxJK5UM/AVgYKVFjNNofn4Ain+y3mDhjeAcR79fvEtcRQFzLz1cnxVKbLiGQ4OuJyOTsObA2CWBi7fix6wiu7yWrbuNPuTXI+h51naE8aw9dk0bmo1eZJNzjcPZ4WYUEYONS4zsgpOwXTW7K0pzhkAhptGxpL2Hui9QI2J78=
X-Sasl-enc: 82gFfnzjV16z96593FXIKCxSUegrVK3DHh61+Vg7YhRL 1261497595
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EFEBD11EE4;
	Tue, 22 Dec 2009 10:59:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <loom.20091222T164442-704@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135582>

Craig Moore venit, vidit, dixit 22.12.2009 16:50:
> Hi,
> 
> I'm getting the following error when I make the info target:
> 
> $ make prefix=/usr info
> make -C Documentation info
> make[1]: Entering directory `/local/software/git-1.6.5.7/Documentation'
> make[2]: Entering directory `/local/software/git-1.6.5.7'
> make[2]: `GIT-VERSION-FILE' is up to date.
> make[2]: Leaving directory `/local/software/git-1.6.5.7'
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
>   -w|--warning <warning_type>|list: Control warnings or display the allowed
> warning types
>   -e|--errors <error_type>|list: Control errors or display the allowed error types
>   -h|--help:                     Print this help message and exit
>   -V <variable[=value]>:         Set a variable
>   -v|--version:                  Print the version and exit
> make[1]: *** [user-manual.texi] Error 1
> make[1]: Leaving directory `/local/software/git-1.6.5.7/Documentation'
> make: *** [info] Error 2
> 
> I can see that the error is likely related to the fact that it enters the
> Documentation directing, then exits the Documentation directory, and then tries
> to build the user-manual.texi file in the root directory (however, that file is
> in the Documentation directory, which it just left). I've tried to track down
> and change where it exits the Documentation directory, but I've had no success.
> 
> I would appreciate any recommendations you might have. I've already been able to
> install git, but I couldn't install the 'info' target because of this error.

Does it work without prefix?
Also, you may want to cd into Documentation and try to make there.

Michael
