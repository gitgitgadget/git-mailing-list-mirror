From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 22:25:51 +0100
Message-ID: <CAMP44s2fSpL13kDAm9W2ti-MERpKukNzNZ_Yt0oOOWMYOQPr2Q@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
	<20121125173607.GB32394@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Nov 25 22:26:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcjiI-0006kc-Uo
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 22:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab2KYVZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 16:25:52 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36749 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab2KYVZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 16:25:51 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so10198086oag.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Bg9ddZhs7thm4RvAvcf9whxGP4BdLvSnI8bLPOwXJyk=;
        b=chbbJWLA0ghTvKotuI2Syoer26MXsqxZhB7LAOScrIOpDep+A4Db47LcLJFdGXVzyd
         Sr/FOUTAXsKW6fwCZRRAudoqU4H9Czj4iua+HUCmpMkRuLtziKe0TSQG90GgVdGZygok
         yfjOK/RMhjMVq10H1NXZfDULM3z+xXF9rrq9emnrnU4dZFOq2md+7uUGuNkJaiRXbEBk
         F6G6gUGZtm/msATa8b63RukvBn9KNUmzpnfNaf8Aqo6arC3xGJs6o3m5uer/0raC8Nom
         GTRSaI3jeFFafV47jOwNhBdQXNNRrMU3+WFX/1e03baCVgm6XxRzxlTpVU66OtequVRd
         zghw==
Received: by 10.60.1.169 with SMTP id 9mr2286565oen.93.1353878751344; Sun, 25
 Nov 2012 13:25:51 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sun, 25 Nov 2012 13:25:51 -0800 (PST)
In-Reply-To: <20121125173607.GB32394@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210382>

On Sun, Nov 25, 2012 at 6:36 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> Of course, but there are experts in C and shell around, not so many
>> python experts. So if somebody sneaks in a python program that makes
>> use of features specific to python 2.7, I doubt anybody would notice.
>
> I would.

And are you going to be around to spot them? It seems my patches for
git-remote-hg slipped by your watch, because it seems they use stuff
specific to python 2.7.

>> And if they did, I doubt that would be reason enough for rejection,
>> supposing that porting to 2.6 would be difficult enough.
>
> In cases like that, backporting is usually pretty easy.  Been there, done that.

Exactly. Why would you reject something you can fix easily?

-- 
Felipe Contreras
