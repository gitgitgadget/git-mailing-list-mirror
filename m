From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH] gitweb: move highlight config out of guess_file_syntax()
Date: Mon, 26 Jul 2010 16:56:02 -0400
Message-ID: <4C4DF662.5030201@mit.edu>
References: <1280000767-31895-1-git-send-email-asedeno@mit.edu> <201007260135.35059.jnareb@gmail.com> <4C4CCE60.1080301@mit.edu> <201007262248.35341.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 22:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdUib-0003Gn-U7
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 22:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab0GZU4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 16:56:12 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:54757 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755369Ab0GZU4K (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 16:56:10 -0400
X-AuditID: 1209190f-b7b0aae000000a7d-2d-4c4df66c06b2
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id B3.41.02685.C66FD4C4; Mon, 26 Jul 2010 16:56:12 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o6QKu8Ta011217;
	Mon, 26 Jul 2010 16:56:09 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6QKu7S3011053
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 26 Jul 2010 16:56:08 -0400 (EDT)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id D529A14C013; Mon, 26 Jul 2010 16:56:07 -0400 (EDT)
Received: from [18.238.2.136] (JABUN.MIT.EDU [18.238.2.136])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id C1DBB14C011;
	Mon, 26 Jul 2010 16:56:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <201007262248.35341.jnareb@gmail.com>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAARVG7TA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151895>

On 7/26/2010 4:48 PM, Jakub Narebski wrote:
>> As of 1.7.2, with syntax highlighting merged and refactored (592ea41),
>> > access to the hashes that define syntax highlighting mappings was lost.
>> > Moving the hashes out into the config area lets $GITWEB_CONFIG contain
>> > lines like:
>> > 
>> >   $highlight_ext{'lisp'} = 'lisp';
>> >   $highlight_basename{'GNUmakefile'} = 'mak';
> O.K., I don't think we want to put all possible languages that 'highlight'
> supports in %highlight_ext, so you might want to add support for less
> common languages, or languages introduced in newer versions of tool.
> 
> 
> Note that you can write here
> 
>     $highlight_basename{'GNUmakefile'} = 'make';
> 
> which might be slightly more readable.

Yeah, that was a typo on my part; I was recalling samples from memory.
The actual entry reads 'make' not 'mak', just as you suggest. :)

-Alejandro
