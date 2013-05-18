From: Peter Lauri <peterlauri@gmail.com>
Subject: Re: .gitignore behavior on Mac
Date: Sun, 19 May 2013 00:37:02 +0200
Message-ID: <CAEe6bfC6F3sN_OXZYo1=bdwo01_7qFUEmbSWVFNaFZQrZUGdWA@mail.gmail.com>
References: <CAEe6bfD_1GjMBByaEFQ4RMTMaz8XZvd00mxyfaAHtXVpbUjj6A@mail.gmail.com>
	<20130518184136.GH27005@serenity.lan>
	<CAEe6bfB30aD0LcgR4fzLy=xJGwzASJpgfvvtoTmFmJ1_2HZ4Jg@mail.gmail.com>
	<20130518185507.GI27005@serenity.lan>
	<5197EC19.8080806@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun May 19 00:37:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdpkX-0000sK-OT
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 00:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab3ERWhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 18:37:07 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:42918 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab3ERWhG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 18:37:06 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so5500194lbc.16
        for <git@vger.kernel.org>; Sat, 18 May 2013 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=GD5U9bzdGKb54vTaYeqWYXshL5UBWE2T+y5XAq4KbA8=;
        b=NnBF7tc7Keb+Kbiep0ckKmw/Mg4eR5JWMXRJOe0t/eeGvsaHz09sDTDYxOVSy6u9el
         9ZMyslZHne6leyvV9/xA6WI+asupf15wjdF6uDSI2Y4Fczo0nyDO/fVLqhZrRj4oF//N
         80CKt2txUZgW/M24A34mS2P0ALrZAEJx53LFhzUCpYN28h82XQpQrAzagOPdornyLPNQ
         DuYvJZSmK/AQVqvZGUwyV8O7J4egg4+SvcY/FXA2GlcxQWZjiJmRDsaDF2fullyWX2xp
         NWwGhQiYQXHO43u9sRvsBh4QJqeUCp66AMCffK+MxYHaTsem1yEgXzOtR0OfqSoEAU92
         58iQ==
X-Received: by 10.112.126.165 with SMTP id mz5mr8575141lbb.62.1368916622475;
 Sat, 18 May 2013 15:37:02 -0700 (PDT)
Received: by 10.112.20.197 with HTTP; Sat, 18 May 2013 15:37:02 -0700 (PDT)
In-Reply-To: <5197EC19.8080806@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224813>

Great, I have gotten the concept now :)

My workaround for my problem is to rename the file to ....default and
then all will work out well :) Copy the file then and locally modify
it, but it will be in .gitignore so not tracked :)

On Sat, May 18, 2013 at 11:01 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 18.05.2013 20:55, schrieb John Keeping:
>> On Sat, May 18, 2013 at 08:43:57PM +0200, Peter Lauri wrote:
>>> But I just don't want to see that darn file. It is a config file that
>>> I have changed, and I don't want to need to stash it for each "git
>>> svn" action I want to perform... Any solution for that?
>>
>> Read about --assume-unchanged in git-update-index(1).
>
> Beware!! --assume-unchanged is a promise not to modify a file, but that
> is not true in this case, because it *was* modified. It might hide the
> file from the git-status output, but then git might do something
> unexpected sometimes, because a promise was not kept.
>
> See last paragraph of
> http://article.gmane.org/gmane.comp.version-control.git/146353
>
> -- Hannes
>
