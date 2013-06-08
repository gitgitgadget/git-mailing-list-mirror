From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 18:25:22 +0530
Message-ID: <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
 <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com> <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 14:56:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlIgj-0001iE-T0
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 14:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513Ab3FHM4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 08:56:05 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:60051 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab3FHM4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 08:56:04 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so4513077ieb.10
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BFsi60kPp83lS0gCXFivQnRw6WgEj6p4LDdApq66n8g=;
        b=gw5FI+fEGSZWYxk/FbTVF3gTXUoj1lbMvQxbJ+Pp3ZImP/h6cSGiaDEBWuDTUwLA8B
         wTs6My+Y++dRHF4qc4MaxzDSgmH3Yy7LjNqLJG6RQS6UEevLky4cPsggARQuxMgk05rn
         x4qshwwGVSAl2/6SDmN1XYJGpZlwjGccd/pmRZnWrP96EXGJSNwdz9E2jfX720vhF4ce
         +DB0Fui+5DanPzgN9JXJl6Il1rUBq+SaQ4/dA4VJIYuJEq99emS6SmpHh3snMp1XcFsY
         gaa8YCHnDHbDqlwSH/CUhWeS+wdy9V/d7a8iBCVmi+E5rE5rjHi+OzQ2NkMc+pxFZbPL
         Iqjg==
X-Received: by 10.50.98.104 with SMTP id eh8mr815101igb.111.1370696162953;
 Sat, 08 Jun 2013 05:56:02 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 8 Jun 2013 05:55:22 -0700 (PDT)
In-Reply-To: <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226813>

Duy Nguyen wrote:
>> until libgit.a == libgit2. Done.
>
> Read up about the introduction of libgit2, why it was created in the
> first place instead of moving a few files around renaming libgit.a to
> libgit2.a. Unless you have a different definition of "==" than I do.

As far as I know, there was never an extensive on-list discussion
about why git.git cannot be lib'ified.  The first appearance of
libgit2 is here [1].  I briefly read through the initial history of
libgit2.git too, but I cannot find a single discussion detailing why
lib'ifying git.git is fundamentally unworkable (there's some vague
mention of "global state baggage" and "presence of die()", but that's
about it).  Unless you can point to some detailed discussions, or
write out a really good reason yourself, I don't think there's any
harm in letting fc try.  Ofcourse, he still indicated any sort of plan
yet, and I'm also waiting for that.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/99608
