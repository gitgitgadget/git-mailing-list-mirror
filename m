From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git GSoC 2014
Date: Fri, 14 Feb 2014 10:30:28 -0500
Message-ID: <CALkWK0nXbfoe7697m27o7b+vepkOWj+vpJJWRy9EkJeZkTyekw@mail.gmail.com>
References: <20140213091037.GA28927@sigill.intra.peff.net> <CALkWK0mR=9ZD256bHx9d=W9ayqn5bOETWBQLW_kvRSy-GeQK4Q@mail.gmail.com>
 <20140214104139.GA28570@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 14 16:31:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEKjV-0003XB-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 16:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbaBNPbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 10:31:11 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:49763 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbaBNPbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 10:31:09 -0500
Received: by mail-qc0-f178.google.com with SMTP id m20so20056195qcx.37
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 07:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Orw2r8L79vOGOK3RUqZx4PxXu6uleMsQ5y3ef7Lda0U=;
        b=Jdd1SFQ0tja8jLfBspyfUQX+pqjYhoKtO69AEgNuHr337wReXsRpu49ufZZYew4p0e
         4MRGI/rJojHQvj4aZeNC5mlEWMmGHTpFpW6216BpUTXhZQtjwmrhMem4Km3ZWAiHuV78
         kIc25ea/BmL82MLuGMgvoQyPgmrc4l1BbJCe6YJR8SWcNgXHVyF9O4ZjbtR06yytOt/1
         rfBltGRZNw0Jw0f0e62m33jAlqn5A1B/3L1fqSJlnI0KFCd4X+6+wRsovPh8a9cT5jVl
         ia7uZwSAObNODYFRGwruFXaLDkI0U/YlZGau4lLvzyE3OLZwjUmqpcwpi5+Zo7oSpgCW
         9q1Q==
X-Received: by 10.224.115.143 with SMTP id i15mr14192564qaq.57.1392391868454;
 Fri, 14 Feb 2014 07:31:08 -0800 (PST)
Received: by 10.96.126.198 with HTTP; Fri, 14 Feb 2014 07:30:28 -0800 (PST)
In-Reply-To: <20140214104139.GA28570@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242105>

Jeff King wrote:
>> 1. Speed up git-rebase--am.sh
>
> Isn't the merge backend faster? I thought that was the point of it.

I suppose, but I thought git-rebase--am.sh (the default flavor) could
be improved by leveraging relatively new cherry-pick features; I
assumed that the reason it was using format-patch/ am was because it
was written before cherry-pick matured. Alternatively, can you think
of a project that involves working on the sequencer?

>> 3. Rewrite git-branch to use git-for-each-ref
>
> I actually have this about 95% done, waiting for the patches to be
> polished. So I don't think it makes a good GSoC project (it would be
> stupid to start from scratch, and polishing my patches is a lame
> project).

Oh. I look forward to using a nicer git-branch soon.

>> 4. Implement @{publish}
>
> I think this could be a good GSoC-sized topic. I'm going to adjust the
> title to be "better support for triangular workflows". I think they may
> want to examine other issues in the area, rather than drilling down on
> @{publish} in particular (but ultimately, it is up to the student to
> propose what they want to do).

That makes the project a little more open-ended then. I like it.

I was hoping you'd have more comments on "3. Invent new conflict
style". Although I'm not sure the conflict style I proposed would be
terribly useful in the general case, it'll give the student an
opportunity to look at older/ lesser-known portions of the codebase.
