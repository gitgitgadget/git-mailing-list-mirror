From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git.txt: update description of the configuration mechanism
Date: Thu, 14 Feb 2013 17:15:04 +0100
Message-ID: <511D0D88.6010302@drmicha.warpmail.net>
References: <1360856214-934-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U61TA-0001AA-2D
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758151Ab3BNQPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:15:05 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52346 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757979Ab3BNQPE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 11:15:04 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4183B209B0;
	Thu, 14 Feb 2013 11:15:03 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 14 Feb 2013 11:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=FY4bs/NrIaWLncvzNWOfes
	/CKFA=; b=oR45oQAo5kbB+rjx7qSxS/GVi38W7zPeJnY3DYyY100HDieuYKp+c9
	8Gegs9ga2hik3VFvWQnvN1wSvRejZBVRcpAyplRrRs1eHuiZSrAIhHDkEi/ETtZD
	UJFq49qtEWl25k4q5tBQvis34zP5CynES5sBmA6g1Dm1kzALpZlnc=
X-Sasl-enc: zzpoeIlLX+W86+QD3ZMpbFTp33jSde9E4kbijJ0dTJOB 1360858502
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7645B4824CD;
	Thu, 14 Feb 2013 11:15:02 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <1360856214-934-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216317>

Matthieu Moy venit, vidit, dixit 14.02.2013 16:36:
> The old Git version where it appeared is not useful only to historians,
> not to normal users. Also, the text was mentioning only the per-repo

I do not think you meant to not remove so many nots ;)

Besides, if history is uninteresting, then so is sociology: "familiar to
some people" can go, too.

> config file, so add a mention of ~/.gitconfig. Describing in details the
> system-wide, XDG and all would be counter-productive here, so reword the

Hmpf, I think this gives a way too prominent role to "~/.gitconfig". The
config files most people will have to deal with are:

- the repo config file
- the one set by "config --global"

And really, it would often be best if the latter was the XDG thing.

So, I'm all for improving git.txt, but somewhat differently ;)

> description of the link to git-config to make it clear that it is not
> only a list of configuration options.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/git.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 0b681d9..e332947 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -535,10 +535,11 @@ include::cmds-purehelpers.txt[]
>  Configuration Mechanism
>  -----------------------
>  
> -Starting from 0.99.9 (actually mid 0.99.8.GIT), `.git/config` file
> -is used to hold per-repository configuration options.  It is a
> -simple text file modeled after `.ini` format familiar to some
> -people.  Here is an example:
> +Git uses a simple text file format modeled after `.ini` format
> +familiar to some people to store its configuration. The `.git/config`
> +file is used to hold per-repository configuration options, and
> +per-user configuration can be stored in a `~/.gitconfig` file.
> +Here is an example:
>  
>  ------------
>  #
> @@ -559,7 +560,7 @@ people.  Here is an example:
>  
>  Various commands read from the configuration file and adjust
>  their operation accordingly.  See linkgit:git-config[1] for a
> -list.
> +list and more details about the configuration mechanism.
>  
>  
>  Identifier Terminology
> 
