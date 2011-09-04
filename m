From: "Tor Arntsen" <tor@spacetec.no>
Subject: Re: [PATCH] Documentation: "on for all" configuration of notes.rewriteRef
Date: Sun, 04 Sep 2011 22:43:43 +0200
Message-ID: <4E63E2FF.2070603@spacetec.no>
References: <CABNEGjy8M-pFTOs504Q1+G_DtocJwvzDyOAsJp9cn4BOSkv1TQ@mail.gmail.com> <f415402994735a60664e1f9f85be490a68b25ed3.1315167848.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "" <urbanjost@comcast.net>,
	knittl <knittl89@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Sep 04 22:51:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0JfV-0000el-Vy
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 22:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab1IDUvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 16:51:49 -0400
Received: from puck.spacetec.no ([192.51.5.29]:54986 "HELO puck.spacetec.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753165Ab1IDUvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 16:51:48 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Sep 2011 16:51:47 EDT
Received: (qmail 7940 invoked from network); 4 Sep 2011 20:44:24 -0000
Received: from citadel.spacetec.no (10.10.2.22)
  by puck.spacetec.no with SMTP; 4 Sep 2011 20:44:24 -0000
Received: from [10.10.1.233] (ringworld4.spacetec.no [10.10.1.233])
	by citadel.spacetec.no; Sun, 04 Sep 2011 22:43:46 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110820 Iceowl/1.0b2 Icedove/3.1.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180703>


On 04/09/2011 22:28, Thomas Rast wrote:
> 
> Users had problems finding a working setting for notes.rewriteRef.
> Document how to enable rewriting for all notes.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
> [Sorry for the spam; the first one lacks my reply blurb and the
> in-reply-to. :-( ]
> 
> Tor Arntsen wrote:
>> Thanks. Got it working. So it's not by default, as was suggested by
>> knittl, it has to be enabled. BTW, it's not at all obvious from the
>> manpage what it should be set to, there's no actual example. Found it
>> by trial&error plus finding a diff for a test.
> 
> Let's document it then.  This still won't help you find out about the
> option/feature in the first place, though.  Maybe we should flip the
> default to enabled?
> 
>  Documentation/config.txt |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0ecef9d..302b2d0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1464,7 +1464,8 @@ notes.rewriteRef::
>  	You may also specify this configuration several times.
>  +
>  Does not have a default value; you must configure this variable to
> -enable note rewriting.
> +enable note rewriting.  Set it to `refs/notes/*` to enable rewriting
> +for all notes.
>  +
>  This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
>  environment variable, which must be a colon separated list of refs or

Looks good to me, it would have been sufficient for me to find it 
right away. But, as you say, it requires you to know or be told about 
the feature in the first place.. 
As far as I'm concerned it would be perfect if it was set to refs/notes/*
by default, but people are using notes for all kinds of things. Maybe there
are issues with using that default that I don't know about.

-Tor
