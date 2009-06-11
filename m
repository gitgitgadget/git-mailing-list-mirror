From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] doc tweak for git-send-email
Date: Wed, 10 Jun 2009 17:57:50 -0700
Message-ID: <4A30568E.7060503@gmail.com>
References: <1244656571-15560-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 02:58:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEYcE-0007wa-7G
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 02:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296AbZFKA5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 20:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbZFKA5w
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 20:57:52 -0400
Received: from mail-pz0-f172.google.com ([209.85.222.172]:65245 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZFKA5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 20:57:51 -0400
Received: by pzk2 with SMTP id 2so63185pzk.33
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 17:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=al6De3becFZJvybN0qPbxyWXmg752KsBwCcE3mji6DI=;
        b=oWmaX4tlcBV+ggmUevXJIMreJymoXUsGhRK9RmMOF1lJGz6UCCFXq05rQfz3TlOUfB
         7u16wLcX0YdvXkCZnQaczmdRhGKBgk3FiTJXTUVmKUHN7T6HMP/89Trtg/02GOiJmTbN
         mn05zWZn1teGSRHDzwWl/TW2Z//zoUNMRqVVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=XNBIC3HtPIL8Ona+FvqLjPPPG53z7NqYkG7YmD91rUnmvEOon2rZ66NnnWcu4yHO0A
         MMvKghdbSQ9R9Myn7DAZqcHwM0Qym1CnPbgW14VZscOFzX4y3ovliZIEZDV27RWrO9NT
         UqVIk1mOY4nTUVxRi5+d2DfrHQ7lZpuDqwQHs=
Received: by 10.114.53.18 with SMTP id b18mr2964777waa.204.1244681873666;
        Wed, 10 Jun 2009 17:57:53 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id n9sm505746wag.61.2009.06.10.17.57.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 17:57:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <1244656571-15560-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121323>

Paolo Bonzini wrote:
> The git-send-email docs do not mention except in the usage lines
> the combined patch formatting/sending ability of git-send-email.
> This fills the hole.
>
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
>  Documentation/git-send-email.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index eb851b3..02bb0d3 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -33,6 +33,9 @@ script
>  This format expects the first line of the file to contain the "Cc:" value
>  and the "Subject:" of the message as the second line.
>  
> +In addition, git send-email can be asked to generate patches with git
> +format-patch and send them.
> +

You are right that the docs don't mention this feature very clearly, but
this patch doesn't fill the hole for me.

How do I tell send-email to generate patches with format-patch? I know
from looking at the code that send-email actually calls format-patch
with the rev-list passed on the command line.

Maybe it would be more clear to say that rev-list can be specified in
the same way as format-patch? Also, could you update the first sentence
in the description section? Obviously send-email takes more than just
patches on the command line.
