From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/5] New hash table implementation
Date: Thu, 26 Sep 2013 17:26:27 +0700
Message-ID: <CACsJy8BQDwHJiDyaOfcmOSg+=jpj-NyCTtw1vLwppSwYxF5hhA@mail.gmail.com>
References: <522FAAC4.2080601@gmail.com> <52416058.90008@gmail.com> <20130926101648.GD6615@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 12:27:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP8mk-0001gL-6P
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 12:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab3IZK06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 06:26:58 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:63903 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab3IZK05 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 06:26:57 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so1553155obc.8
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yEpZYjGlFF19N5JTCdHkU98QSEIZ22ElzUJgI7cqrSU=;
        b=elt86ULs9evWvKKwq2UqYomzm7SldQnDd5fEG6LrhF75sDayFIomsr79sCePhgVNMY
         xs8W42FQPKRfjSrDsdmaoHxAwUANuc+oLZOJYlxSt+hYHhxW5MoqbDUvUZZx1J+JsEgM
         v4RyE/Ux/P5yy1KkFclU0BgDI+4vCeNirqw4CsofytGhLYAXhU43+uv3AYRc1dtmk38T
         RVPz8+6NIQ3Yt55JeL7ZrXsDPzJjPViZm+RQN2kKbIQfG+9creCtXBmrcb/r+xCEb40f
         PM/yPvsP3+7hFfm7stx+IKailmrgdjJeMiCua2u3S1CYjDrG12Y6x/BYO96oyG9LnTfu
         8Uqg==
X-Received: by 10.60.34.4 with SMTP id v4mr33667oei.101.1380191217466; Thu, 26
 Sep 2013 03:26:57 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Thu, 26 Sep 2013 03:26:27 -0700 (PDT)
In-Reply-To: <20130926101648.GD6615@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235414>

On Thu, Sep 26, 2013 at 5:16 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Tue, Sep 24, 2013 at 11:50:16AM +0200, Karsten Blees wrote:
>> Tests can be reproduced with 'time echo "perfhash[map] <method> 1000" | ./test-hashmap', see test-hashmap.c for definition of method flags.
>
> So I'm still curious about the actual performance improvements for git.
> I runned git describe on the linux kernel with both the old hashmap and
> this new one:
>
> ...
>
> I can't see any improvements at all here. What do I miss? Am I running
> git describe in the wrong way? Does linux.git have too few tags to be
> important?

I wonder if it makes any difference if there are a lot more refs. I
hear gerrit creates a lot but don't know how many. linux-2.6 has ~350
refs. How about increasing the number of refs to 3500 refs?
-- 
Duy
