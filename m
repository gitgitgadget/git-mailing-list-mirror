From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: Building Git with HTTPS support: avoiding libcurl?
Date: Thu, 24 Dec 2015 20:36:48 -0200
Message-ID: <CACnwZYdLS7F-crNu0RjdYw__82nbaTujnjDc+q2jAXZ2Qoja+Q@mail.gmail.com>
References: <1450798780.11255.22.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: paul@mad-scientist.net
X-From: git-owner@vger.kernel.org Thu Dec 24 23:36:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCEVB-0001YD-Si
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 23:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbbLXWgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 17:36:50 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35503 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbbLXWgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 17:36:49 -0500
Received: by mail-io0-f195.google.com with SMTP id o67so22788632iof.2
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 14:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Fnq5awqNi1XkRpCfn2IMC6VC2UAkiXMOqcztjBG7DkE=;
        b=V3Wb8oEig4c74KfaXLIP3LMimuf7BBcxvKM0hwPSQhHtDFDydb6GY+e1gjX2MEaSps
         pQNxhYJrdM2Ww22XxurYMeGbgxhyBqr6NhPURZAZIYQZRK5cAWnI1DoER9EMc3OYrWMX
         Xx2WgBhLTbT9hW5BqAi8jb/x6Dq6jv7jl3ylGJ0RwacINGSxHyYm2ueKj6zFIRujjlFd
         T9q1lKk3mZTQHQzpG8x3DVDZgnWnP/TMXRTTsaOR+sWOLwS4AvlquZFTiWomSdu/E0Tc
         zj4okBCnYGxS/6YmqbZTtdKGciWj1o0mRbDsuaM8MYg4+pzJR/rU0npE1NFGuMI2Evj2
         JLgA==
X-Received: by 10.107.15.17 with SMTP id x17mr34896624ioi.35.1450996608710;
 Thu, 24 Dec 2015 14:36:48 -0800 (PST)
Received: by 10.79.115.134 with HTTP; Thu, 24 Dec 2015 14:36:48 -0800 (PST)
In-Reply-To: <1450798780.11255.22.camel@mad-scientist.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282986>

On Tue, Dec 22, 2015 at 1:39 PM, Paul Smith <paul@mad-scientist.net> wrote:
> I'm trying to build Git (2.6.4) on GNU/Linux, but without any
> requirements (other than basic libc etc.) on the local system.  This
> works fine except for one thing: git-remote-https.
>
> In order to build this I need to have libcurl, but libcurl is a MONSTER
> library with an enormous number of prerequisites (see below).
>
I think Git would have to be changed to use raw sockets and implement
everything it needs on top of that, like libgit2 already does. Certainly this
won't be a trivial task.

-- 
Thiago Farina
