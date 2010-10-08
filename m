From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 8 Oct 2010 18:34:32 +0200
Message-ID: <AANLkTi=zS+oj1iHMh-gKVD=2dG5tLwA+bia9E6U3o=zW@mail.gmail.com>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
 <20101008081509.GA2845@kytes> <4CAED762.7040708@gmail.com> <74AF320B-5D82-4622-A7BF-61C847D4059A@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gabriel Filion <lelutin@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 18:35:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4FuU-000745-QJ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 18:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292Ab0JHQe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 12:34:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38163 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273Ab0JHQez (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 12:34:55 -0400
Received: by gxk9 with SMTP id 9so381992gxk.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=z0a48lTHjjtiiRmC1VhTe0vbkziFJJsDEvCPN0IpCks=;
        b=T4bRSXzjwxD9h3bPt/KPJDzkb1D45uF0XU1iY3V83lrk+5eJGvH3+rRpjswl50tLdE
         lFOxjF7TzYSHcoJzsTiEt8kcjoOL2iPnc9ZF1pkQCl1JgGtqGrPmTyjK6b8BZdAW7geX
         cYm8ZkUGRowBIRVs838phRL2LRKDcDyMsLmbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mda8ZINcjkei71DO7GL5HjBTDthZa9/mfKC9wD6Pog0CwJEBGYBpOfOn3ZNMSNFS/g
         YDlSZB5rLbl1t/D4/V0VlADXPahhx/sNjriZUoMzatVoZZnqO6aeOo3k5lNBDM8WI1zo
         ckkJ0oW/U98tsAIBKAk8lb2iCuajVs/A9DBns=
Received: by 10.151.1.41 with SMTP id d41mr3208809ybi.215.1286555694287; Fri,
 08 Oct 2010 09:34:54 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Fri, 8 Oct 2010 09:34:32 -0700 (PDT)
In-Reply-To: <74AF320B-5D82-4622-A7BF-61C847D4059A@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158502>

Heya,

On Fri, Oct 8, 2010 at 10:58, David Michael Barr
<david.barr@cordelta.com> wrote:
> The way I perceive it, the patch simply removes the special treatment of
> the root, allowing it to be modified just as any other path.
> The only property that distinguishes the root from other paths is that the
> endpoint must be a tree.

So, are other trees allowed too? Can I set the contents of directory
"foo/bar/baz/" to an existing tree?

-- 
Cheers,

Sverre Rabbelier
