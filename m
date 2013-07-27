From: Daniele Segato <daniele.segato@gmail.com>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Sat, 27 Jul 2013 12:39:20 +0200
Message-ID: <51F3A358.5000807@gmail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com> <51F2AFBA.4020602@gmail.com> <51F2B2CD.1030004@gmail.com> <20130726190602.GC29799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 27 12:39:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V31uN-0007DY-IA
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 12:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab3G0Kj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 06:39:27 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:63115 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab3G0Kj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 06:39:26 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so3602515wgh.20
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MAqvXHIiPRF1JL+rex8gAnQP4k07dmAx4JIeMRo0V74=;
        b=LuZsA40m8foDXZ7WwIDy+pHXMGVt1R89BF5guFyS6hwAespMRw81PoJ136EHJDaRf4
         xZ9AAnTpEne7+l9XlL3qkn23Mk6Hq1RRPU+wScBBvOumUkUHgKohFvtD2Mo5kUVx8Td8
         KkxG1r8mLEMlUKexjI7mSQUww249GZInkH+8peoBgDMZosGkbapN87AtGse/2NFVYFYn
         IThPjzRu5Z1UWXTEXR7dF5K9XE4iknPt8NcXT8WTe92ojczIg3KJ627Pl43JNEDKCjBZ
         /gNfgXeXnBVmYupAsLolVT5DqqwNnehGMWpkt4SK0r/0ibLFAvkq2rGKfZxRBXiIGyfj
         ikVA==
X-Received: by 10.180.105.129 with SMTP id gm1mr1707167wib.20.1374921564943;
        Sat, 27 Jul 2013 03:39:24 -0700 (PDT)
Received: from [192.168.1.16] (host22-75-dynamic.4-87-r.retail.telecomitalia.it. [87.4.75.22])
        by mx.google.com with ESMTPSA id s19sm9874642wik.11.2013.07.27.03.39.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Jul 2013 03:39:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130726190602.GC29799@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231233>

On 07/26/2013 09:06 PM, Jeff King wrote:
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

Hi Jeff,

thanks for the feedback, very appreciated.

But I don't understand what's wrong with the whitespaces.

Can you explain to me what's wrong and how I can avoid the issue?

I use thunderbird in text mode to send emails, should I use something 
else? what?

>
> I also do not know that it is accurate to say "most git commands ignore
> lightweight tags". It is really only "naming" ones like "git describe".
>
> Here is a re-send of your patch with the fixups I would recommend.
>

Thanks, it's obviously better.

I'll send this new version as soon as you or someone else explain me how 
to fix the whitespace damage.

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
>   Documentation/git-tag.txt | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 22894cb..c418c44 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -42,6 +42,17 @@ is used to specify custom GnuPG binary.
>   GnuPG key for signing. 	The configuration variable `gpg.program`
>   is used to specify custom GnuPG binary.
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
>   OPTIONS
>   -------
>
