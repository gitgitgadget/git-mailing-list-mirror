From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [WIP/RFC 13/13] Documentation: Preliminary docs on 'git notes
 merge'
Date: Sat, 24 Jul 2010 01:21:43 -0700
Message-ID: <4C4AA297.4090605@gmail.com>
References: <1279880104-29796-1-git-send-email-johan@herland.net> <1279880104-29796-14-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jul 24 10:21:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcZzZ-0001BG-5E
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 10:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab0GXIVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 04:21:51 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57313 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab0GXIVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 04:21:49 -0400
Received: by pzk26 with SMTP id 26so403861pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7H8Zq3/y4rGFMC+n/MsjlD4RyDCv+Bn8THyBgR4d99I=;
        b=er808iXkAvs3aLfnOne+hDCi0kY73sAKKRHnQExVZ6XgaI1FzIPrG83xsR2M+0amZD
         e9vwVFhgWLqXCC01r3JiG70OB0GDY9678gNfc0PpWD8xBxXlfmeJId3ZmH+KZDLZHez4
         oEaczj47aO5xD8Rl2dAGS5cEr89o7FivqVNfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dAV6ktb7vGtwVKuKMx3Z4wBnQxwBMZHH00jILOnqmj3Zl7r8y1HNqnlAtQuT3ndOf3
         8TeSjrX9IknlsEfFZBlxsYsP4w4NcoMxyQxodhQ8mtUurMEjZ0vj0mGzVSFZH98uVcTG
         YnLfFQn855oP/SHGAz6QeFt3vN+cyyKY/wzus=
Received: by 10.142.204.17 with SMTP id b17mr5526050wfg.71.1279959709111;
        Sat, 24 Jul 2010 01:21:49 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id r27sm1340712rvq.9.2010.07.24.01.21.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 01:21:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.4) Gecko/20100713 Thunderbird/3.1
In-Reply-To: <1279880104-29796-14-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151605>

  On 07/23/2010 03:15 AM, Johan Herland wrote:
> +-X<strategy>::
> +--resolve=<strategy>::
> +	When merging notes, resolve notes conflicts using the given
> +	strategy. The following strategies are recognized: "manual"
> +	(default), "ours", "theirs" and "union". "ours" automatically
> +	resolves conflicting notes in favor of the local version (i.e.
> +	the current notes ref). "theirs" auto-resolves notes conflicts
> +	in favor of the remote version (i.e. the given notes ref being
> +	merged into the current notes ref). "union" auto-resolves
> +	notes conflicts by concatenating the local and remote versions.
> +

We use both "auto-resolves" and "automatically resolves" in this paragraph. Perhaps it's better to use one term throughout?
