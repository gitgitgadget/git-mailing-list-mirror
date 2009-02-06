From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH 1/2] fix typo in Documentation
Date: Fri, 6 Feb 2009 14:43:58 +0100
Message-ID: <237967ef0902060543q2cc13d99l852c8427fb66402b@mail.gmail.com>
References: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Guanqun Lu <guanqun.lu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 14:45:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVR1P-000531-3h
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 14:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbZBFNoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 08:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbZBFNoB
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 08:44:01 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:54896 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbZBFNoA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 08:44:00 -0500
Received: by ewy14 with SMTP id 14so1309276ewy.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 05:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YuI9a/Ip3+RRyMxr1GZic6lc8Ay2D3sRbG6ZKtPte84=;
        b=FEx31h0sfbwOBEEhXfrDTzQDiO7/7FjmYOuvrk9aNX07sCxTihWfoqqkcPkTJ+chae
         UAw4nFg4axn9wLwBZDBBHu+sEcVg6ngeNMdnLQixeh5J/qjtgj5eJ3iP6E3JO89nmJ8C
         QsEFnlwAi9wqbqRwA5QW4ZYlbnwT05nWu729w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SrePC/rCxwtoO+tV//Gr4ld5+VIq6HGblg3xBqzzcxjx2i6BVACxQw9q7vfFbGZFv4
         Ne6Kjz52p080a1ahFVIvIn/Z0Wz58rFYyP92T0ePSdQwts2IHXIMJOCJwmbqGKZR/cct
         4QvTA9NdD3UIZxna0ZfU0vU4U8KN98w5cEXDo=
Received: by 10.210.120.17 with SMTP id s17mr1339242ebc.54.1233927838684; Fri, 
	06 Feb 2009 05:43:58 -0800 (PST)
In-Reply-To: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108706>

2009/2/4 Guanqun Lu <guanqun.lu@gmail.com>:
> Signed-off-by: Guanqun Lu <guanqun.lu@gmail.com>
> ---
>  Documentation/technical/api-strbuf.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> index 9a4e3ea..ac56d1c 100644
> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -21,7 +21,7 @@ allocated memory or not), use `strbuf_detach()` to unwrap a memory
>  buffer from its strbuf shell in a safe way. That is the sole supported
>  way. This will give you a malloced buffer that you can later `free()`.
>  +
> -However, it it totally safe to modify anything in the string pointed by
> +However, it is totally safe to modify anything in the string pointed by
>  the `buf` member, between the indices `0` and `len-1` (inclusive).
>
>  . The `buf` member is a byte array that has at least `len + 1` bytes

Shouldn't that be "the string pointed >>at<< by" too?

-- 
Mikael Magnusson
