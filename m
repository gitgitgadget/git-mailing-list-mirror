From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 5 Dec 2014 17:52:15 +0700
Message-ID: <CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
References: <1417732931.20814.16.camel@segulix> <1417759955.10992.2.camel@segulix>
 <548156E5.2080006@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?S=C3=A9rgio_Basto?= <sergio@serjux.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Dec 05 11:52:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwqVG-0000s1-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 11:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbaLEKwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 05:52:46 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:54419 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbaLEKwq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 05:52:46 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so536171iga.8
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 02:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9OlFnYX775dX6fQDBrqIuMhqvaqvbnKox5X32nH4U0k=;
        b=wpt9XuJwho/EYnFl2zAGLv+9LNAIDgcTlwc1GCK1FdNQT8cFGmBFQ+f1ScC/QSwNAz
         NylG0TWEqEla/fZjjulp5wsaPikCLzFSTa1K/CE0iuGvRMW3s4weKfkJljWp7c57YWAL
         r1960FyJB9zuenhIHDJBup0qNMgVw2YTX0EvKxDFXNjwBgWy8ny0h/UR6eFOESgCKXNU
         tAtw9pI0OnGR4a03oa3zWs3KtTkchX0zVhHEWc+uHHi4yNzKABSPuxWR2q6J5tfRLWmN
         2AS7Fry3xt5bO/KbOjVwPwxdQfTxuaHlDtuuUcR3ClDBwuIYmI1zYgGMFLPc5neFQLR6
         Af9g==
X-Received: by 10.42.167.1 with SMTP id q1mr15074353icy.48.1417776765386; Fri,
 05 Dec 2014 02:52:45 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Fri, 5 Dec 2014 02:52:15 -0800 (PST)
In-Reply-To: <548156E5.2080006@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260866>

On Fri, Dec 5, 2014 at 1:55 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Actually, it's a user error. When you set --assume-unchanged, then you give
> a promise to git that you do not change the files, and git does not have to
> check itself whether there is a change.
>
> But since you did not keep your promise, you get what you deserve. ;-)

You are correct about the original idea behind --assume-unchanged. But
over the time I think we bend over a bit and sort of support these use
cases. For example, aecda37 (do not overwrite files marked "assume
unchanged" - 2010-05-01). The change is one-liner, so I don't mind
doing it.
-- 
Duy
