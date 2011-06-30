From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation/revisions: Document shorthand
Date: Thu, 30 Jun 2011 09:30:47 +0200
Message-ID: <4E0C2627.9040709@drmicha.warpmail.net>
References: <1309298960-55011-1-git-send-email-j416@1616.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Sageryd <j416@1616.se>
X-From: git-owner@vger.kernel.org Thu Jun 30 09:30:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcBiB-0005IX-6y
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 09:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887Ab1F3Hav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 03:30:51 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54695 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928Ab1F3Hat (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2011 03:30:49 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7352021430;
	Thu, 30 Jun 2011 03:30:49 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 30 Jun 2011 03:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=8pMU1047siQRVQQpiL9/69m5FZc=; b=Z6W6mPPF4CFc4gljyWYTco6xhrjYoE9JBWY/c7WTLPQYxiuQVm3ejingmI3f5s2ZbcHOGYHe2IzhqJDIs85fuZHSi3VwUXsQSRdSGePyPHGiRRu6DZ6g8oymuMixzEmTzxFOTSuWixOXHwo6HFIys5SByZjhsF1zRzyxLk5a7yE=
X-Sasl-enc: SmkrkeAnD5p2e6kndMBZU4ORkwhgniJJp7iwr4N2a3lN 1309419049
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EE2F2442186;
	Thu, 30 Jun 2011 03:30:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <1309298960-55011-1-git-send-email-j416@1616.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176479>

Johan Sageryd venit, vidit, dixit 29.06.2011 00:09:
> Signed-off-by: Johan Sageryd <j416@1616.se>
> ---
>  Documentation/revisions.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index b290b61..180ef5a 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -105,7 +105,7 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
>    commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
>    equivalent to '<rev>{caret}{caret}{caret}' which is equivalent to
>    '<rev>{caret}1{caret}1{caret}1'.  See below for an illustration of
> -  the usage of this form.
> +  the usage of this form. '<rev>{tilde}' is a shorthand for '<rev>{tilde}1'.
> 
>  '<rev>{caret}\{<type>\}', e.g. 'v0.99.8{caret}\{commit\}'::
>    A suffix '{caret}' followed by an object type name enclosed in
> --
> 1.7.6
> 
> 
> Sorry; please use this instead. Same patch with correct from-address.

If rev~ is meant to be documented usage (I thought rev^ to be preferred
but may be wrong) then we should make the descriptions of rev~<n> and
rev^<n> more uniform.

Michael
