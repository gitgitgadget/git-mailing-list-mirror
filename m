From: "Jonas Fonseca" <fonseca@diku.dk>
Subject: Re: A typesetting problem with git man pages
Date: Wed, 29 Oct 2008 20:35:03 +0100
Message-ID: <2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com>
References: <87skqfus7v.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:36:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvGq8-0003O0-4n
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 20:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbYJ2TfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 15:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbYJ2TfH
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 15:35:07 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:60486 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbYJ2TfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 15:35:06 -0400
Received: by mu-out-0910.google.com with SMTP id g7so133153muf.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=RZT9P9PpCDxPoJI4cJ4le6FhStK3jYzb5++xWdqCb7w=;
        b=LhhS6pwo3b+IPAeuAzHGzOURD9sMdVFS+Imiy77YTwD9NePzyTMxnae0vjSf0I+vHc
         dmwcRyxIKNG/7OfM9iykF1jehIm0y264NeGbVzXfdidPlnhiV6trWdZMJ48xJn0vTNLW
         55pmPOlHtPyNg8zQwHzNygsVAk1GRLuCONk1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=SAZ0BM1OdmfBiOHTMXDnouAV6mVzeiZAIOwdnjaVwHN3giXdaR9rG1nwHuz/+d6UvJ
         EQe6pRbt3/cRKzyMnE+skGokSU16BDh8ZIdcNY50SM8ilXTr7Sus8guAkc/REp+7WkWn
         o6xEkeVoAZydFyxTPB971//FucYTeePPkqrXs=
Received: by 10.181.199.11 with SMTP id b11mr2493975bkq.127.1225308903404;
        Wed, 29 Oct 2008 12:35:03 -0700 (PDT)
Received: by 10.181.228.16 with HTTP; Wed, 29 Oct 2008 12:35:03 -0700 (PDT)
In-Reply-To: <87skqfus7v.fsf@iki.fi>
Content-Disposition: inline
X-Google-Sender-Auth: 146dc1301fc45bea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99393>

On Wed, Oct 29, 2008 at 20:16, Teemu Likonen <tlikonen@iki.fi> wrote:
> Does anybody know why "man" prints those ".ft" commands? The
> corresponding code in git-log.1 file is this:
>
>    \&.ft C
>    [i18n]
>            commitencoding = ISO\-8859\-1
>    \&.ft
>
> Recently I upgraded my system from Debian 4.0 (Etch) to 5.0 (Lenny) and
> it is possible that some tools which are related to compiling the man
> pages are now newer versions.

I had a similar problem after upgrading on Ubuntu and came up with a
patch to optionally disable some of asciidoc.conf (commit
7f55cf451c9e7). Try putting DOCBOOK_XSL_172=Yes in your config.mak.

-- 
Jonas Fonseca
