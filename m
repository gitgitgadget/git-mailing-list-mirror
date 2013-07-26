From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Fri, 26 Jul 2013 17:13:26 -0400
Message-ID: <51F2E676.6080404@xiplink.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com> <51F2AFBA.4020602@gmail.com> <51F2B2CD.1030004@gmail.com> <20130726190602.GC29799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniele Segato <daniele.segato@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 26 23:13:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2pKC-0005hK-CP
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 23:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281Ab3GZVNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 17:13:16 -0400
Received: from smtp98.ord1c.emailsrvr.com ([108.166.43.98]:33607 "EHLO
	smtp98.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933142Ab3GZVNP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jul 2013 17:13:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp5.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id DDF151B013E;
	Fri, 26 Jul 2013 17:13:14 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp5.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 9427F1B00F8;
	Fri, 26 Jul 2013 17:13:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130726190602.GC29799@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231203>

On 13-07-26 03:06 PM, Jeff King wrote:
> On Fri, Jul 26, 2013 at 07:33:01PM +0200, Daniele Segato wrote:
> 
>> stress the difference between the two with suggestion on when the user
>> should use one in place of the other.
>>
>> Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
> 
> The intent of your patch seems reasonable to me. There are a few minor
> language and typographical mistakes, and the patch itself is
> whitespace-damaged.
> 
> I also do not know that it is accurate to say "most git commands ignore
> lightweight tags". It is really only "naming" ones like "git describe".
> 
> Here is a re-send of your patch with the fixups I would recommend.

I'm happy with Peff's version.

Reviewed-by: Marc Branchaud <marcnarc@xiplink.com>

(Daniele, don't feel put off because Jonathan & I are accepting Peff's text.
 If you think it still needs improving please speak up!)

		M.

> -- >8 --
> From: Daniele Segato <daniele.segato@gmail.com>
> Subject: [PATCH] docs/git-tag: explain lightweight versus annotated tags
> 
> Stress the difference between the two with a suggestion on
> when the user should use one in place of the other.
> 
> Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-tag.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 22894cb..c418c44 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -42,6 +42,17 @@ is used to specify custom GnuPG binary.
>  GnuPG key for signing. 	The configuration variable `gpg.program`
>  is used to specify custom GnuPG binary.
>  
> +Tag objects (created with `-a`, `s`, or `-u`) are called "annotated"
> +tags; they contain a creation date, the tagger name and e-mail, a
> +tagging message, and an optional GnuPG signature. Whereas a
> +"lightweight" tag is simply a name for an object (usually a commit
> +object).
> +
> +Annotated tags are meant for release while lightweight tags are meant
> +for private or temporary object labels. For this reason, some git
> +commands for naming objects (like `git describe`) will ignore
> +lightweight tags by default.
> +
>  
>  OPTIONS
>  -------
> 
