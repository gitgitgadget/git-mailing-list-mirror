From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH/RFC] remove #!interpreter line from shell libraries
Date: Mon, 12 Mar 2012 14:53:12 -0400
Message-ID: <4F5E4618.10102@xiplink.com>
References: <20120308121403.GA16493@burratino> <20120309075820.GA15985@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nie?= =?ISO-8859-1?Q?to?= 
	<cmn@elego.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7AMy-0006OX-H2
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 19:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756391Ab2CLSxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 14:53:16 -0400
Received: from smtp182.dfw.emailsrvr.com ([67.192.241.182]:43613 "EHLO
	smtp182.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627Ab2CLSxP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 14:53:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp8.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 7085E81B1;
	Mon, 12 Mar 2012 14:53:14 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp8.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 038418212;
	Mon, 12 Mar 2012 14:53:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120309075820.GA15985@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192922>

On 12-03-09 02:58 AM, Clemens Buchacher wrote:
> Hi Jonathan,
> 
> On Thu, Mar 08, 2012 at 06:14:04AM -0600, Jonathan Nieder wrote:
>>
>> --- a/git-mergetool--lib.sh
>> +++ b/git-mergetool--lib.sh
>> @@ -1,5 +1,4 @@
>> -#!/bin/sh
>> -# git-mergetool--lib is a library for common merge tool functions
>> +# git-mergetool--lib is a shell library for common merge tool functions
> 
> This breaks vim's filetype detection. It can still guess the file type
> from the .sh extension, but we strip the extension during the build.
> Although one should typically work with the source files, in the past I
> did have a look at the installed files on a few occasions. Maybe because
> I did not know better, or because the source code was not available to
> me. So for me, this outweighs the aesthetic advantages, if any.

(I hesitate to suggest the following, but since nobody else is replying to
this thread...)

How about a modeline?  I think the following would work for both emacs and
vi(m?) (I'm not a vi user, so I might have it wrong):

	# -*-mode:shell-script-*-   vi: filetype=sh

(Now I'll wince and duck as people "calmly" discuss the merits of putting
editor-specific modelines in the source code, and especially which editors
deserve such treatment...)

		M.
