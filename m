From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: [PATCH] Make boundary characters for --color-words configurable
Date: Sat, 03 May 2008 15:22:15 +0200
Message-ID: <481C6707.5060308@dirk.my1.cc>
References: <20080502143650.GB3079@mithlond.arda.local> <1209774178-26552-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tlikonen@iki.fi, gitster@pobox.com, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 15:23:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsHhr-0003xo-6S
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 15:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYECNWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 09:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbYECNWX
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 09:22:23 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:47731 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbYECNWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 09:22:23 -0400
Received: from [84.176.81.131] (helo=[192.168.2.100])
	by smtprelay08.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JsHgt-0000L4-6A; Sat, 03 May 2008 15:22:15 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <1209774178-26552-1-git-send-email-pkufranky@gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81077>

Hi Ping,

I highly appreciate your effort into "diff --color-words"
and hope it makes it into the the next release. I wanted
to change the behaviour as well, but when I saw that
git-diff is a builtin, I had to give up. I hoped it was
a perl script and could insert some "\b" regexes somewhere,
but I was wrong. I'm using Git for Windows, you know.

However, I'd like to ask you whether you've done any research
in how to use "--color-words" in gitk? gitk seems to color
the lines only by means of a '+' or '-' sign in the first
column. Hardcoded. I managed to add a checkbox to gitk that
adds the '--color-words' switch to git diff, but when checked
the output is just muddled up. All of those ^] characters
whithin the code. :-(

Dirk

Ping Yin schrieb:
> Signed-off-by: Ping Yin <pkufranky@gmail.com>
> ---
>   
>> I think config variables should be in alphabetical order in config.txt.
>> Hence your diff.nonwordchars is not in the right place
>>     
>
> THX, this is fixing patch
>
>  Documentation/config.txt |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index eb05592..812ec2c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -537,6 +537,10 @@ diff.external::
>  	program only on a subset of your files, you might want to
>  	use linkgit:gitattributes[5] instead.
>  
> +diff.nonwordchars::
> +	Specify additional boundary characters other than spaces for
> +	--color-words.
> +
>  diff.renameLimit::
>  	The number of files to consider when performing the copy/rename
>  	detection; equivalent to the git diff option '-l'.
> @@ -546,10 +550,6 @@ diff.renames::
>  	will enable basic rename detection.  If set to "copies" or
>  	"copy", it will detect copies, as well.
>  
> -diff.nonwordchars::
> -    Specify additional boundary characters other than spaces for
> -    --color-words.
> -
>  fetch.unpackLimit::
>  	If the number of objects fetched over the git native
>  	transfer is below this
>   
