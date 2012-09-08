From: David Aguilar <davvid@gmail.com>
Subject: Re: Encrypted repositories
Date: Fri, 7 Sep 2012 21:10:08 -0700
Message-ID: <CAJDDKr7kheuOoeiCyvh8eZTGTR3u8JZxaveKX8TyBrmLMA4msw@mail.gmail.com>
References: <7vmx132aph.fsf@alter.siamese.dyndns.org>
	<0666bd29-b156-4c3d-b859-ab140d2f849e@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Sat Sep 08 06:11:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TACNt-0007IU-3B
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 06:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab2IHEKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 00:10:10 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52089 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab2IHEKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 00:10:09 -0400
Received: by qcro28 with SMTP id o28so162187qcr.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 21:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=juevXMZOM0DkTn0qOyfxF7kkOQXOkrAKBjMYKQruqpA=;
        b=AXlCMIag97N7SpnH05FIf1qva1NtQbfVRgml0w/KuWrtaSXtfwK09IwqvFtju1Sdjj
         PFxGnJ/3oR+gQ6Wc9NJXBpiLNsaeXLif7nCYAE922PEZ8PhdXuNm1L9fqwA98T1mfwrl
         wXWeVzMgqnSa41U8jvfgZ9hmAsMJr+EYrN49bhGDrZTMEyVjIb9SvwFIUCKl7u4kSHsv
         0XELYTptCe5et5p1JKqB35sE7e6/3BeeSDe+ADjDrlQSxVEMxOL5QbRGvVw9fhiboD4n
         x7CsFNnu3/X6gOaEH6VgOndHtJjay8V21uRcBESxyAdHbiE6A4jaXdGYanYX/Ub/WKEH
         cHMw==
Received: by 10.224.109.66 with SMTP id i2mr10071231qap.3.1347077408441; Fri,
 07 Sep 2012 21:10:08 -0700 (PDT)
Received: by 10.49.14.36 with HTTP; Fri, 7 Sep 2012 21:10:08 -0700 (PDT)
In-Reply-To: <0666bd29-b156-4c3d-b859-ab140d2f849e@zcs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205007>

On Fri, Sep 7, 2012 at 8:34 PM, Enrico Weigelt <enrico.weigelt@vnc.biz> wrote:
>
>> > Well, everybody can access the objects, but they're encrypted,
>> > so you need the repo key (which, of course isn't contained in
>> > the repo itself ;-p) to decrypt them.
>>
>> So, in short, blobs are not encrypted with the hash of their
>> contents as encryption keys at all.
>
> No, the blobs are encrypted with their content hash as key, and the
> encrypted blob will be stored with it's content hash as object id.
>
>> > For the usecases I have in mind (backups, filesharing, etc) this
>> > wouldn't hurt so much, if the objects are compressed before
>> > encryption.
>>
>> For that kind of usage pattern, you are better off looking at
>> encrypted tarballs or zip archives.
>
> No, that doesn't give us anything like history, incremental
> synchronization, etc, etc.
>
> What I finnaly wanna has is a usual git, just with encryption,
> but I can live with loosing differential compression.

Something like this?

https://gist.github.com/873637

I've never tried it myself, who knows if it works, but google found it
when I searched for "git clean smudge filter encryption".

I hope that helps,
-- 
David
