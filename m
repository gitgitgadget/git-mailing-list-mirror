From: Russell Steicke <russellsteicke@gmail.com>
Subject: Re: A question about changing remote repo name
Date: Wed, 6 Jan 2010 08:07:48 +0800
Message-ID: <c1b8b6671001051607j6b6398d8gf08f7615a38de64e@mail.gmail.com>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com> 
	<c1b8b6671001041852w4740b7d6g4b8db1221c5dc744@mail.gmail.com> 
	<60ce8d251001042030l75c5443gf173f127ad206df3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dongas <dongas86@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 01:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSJRe-00036X-Ux
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 01:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab0AFAIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 19:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154Ab0AFAIK
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 19:08:10 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:52205 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0AFAIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 19:08:09 -0500
Received: by iwn32 with SMTP id 32so1214931iwn.33
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 16:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=XUs9a4S3zYdFgYYLRIrmknNixPfJiIuK/cYLawnV6PA=;
        b=cRGVa9ugLt+e4tPbNBpoAwcFJABwYLdKBJO4+lN+M7vw0LDOdK8FFLNyqLXZaTN8A2
         coBRBdeFKCeDmQh3GIdw51oJDjtDoVIeoNa+Aqd9mUs4/B6HhFqJsUYbcAflOQhvr5yI
         GfQTTDmwhqraAFy5fgfG8ofsGyTyZ5Se0laak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=wpJrpbym2xKXkXBE8S+eRVocKRRKmoDIKhqmJGjAW0pVJ6e9eKkXopABTvxvw09PW1
         beQ2CNp6yxuq4D0f9QZDUBIXi0qVx5oekk2itFzwZGaQ6WfxXQ8N/K2xhv37iV7zQvuY
         Pnk3UPadmYDb4OAgWuFUyE68PvTz7SxnXBfOo=
Received: by 10.231.161.138 with SMTP id r10mr1449686ibx.34.1262736488153; 
	Tue, 05 Jan 2010 16:08:08 -0800 (PST)
In-Reply-To: <60ce8d251001042030l75c5443gf173f127ad206df3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136222>

On Tue, Jan 5, 2010 at 12:30 PM, Dongas <dongas86@gmail.com> wrote:
> I did a few more steps:
> root@ubuntu:/work/git-repo/free_monkey# grep -wrin 'origin' .
> ./.git/packed-refs:2:abfae429bb4081043e84681e5ee94102085f87e0
> refs/remotes/origin/master
> ./.git/refs/remotes/karmic/HEAD:1:ref: refs/remotes/origin/master
>
> Change 'origin' to 'karmic' in above files.

Ah yes, I forgot about those files.  I _think_ (but I'm not certain
without digging into the code) that it's always safe to rm
packed-refs, as that file is a cache for quicker access to the refs.
At least it's never caused me any problems.

In any case, your approach of grepping the whole of .git for
interesting strings is a good way to learn about the implementation.


-- 
Virus found in this message.
