From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 22:51:34 +0100
Message-ID: <CALas-iiH0GCwy9WMWxBSGbUykwAKikaLUhfdDUbETv91QuM-7g@mail.gmail.com>
References: <CALas-iizoBjTu2KSXsZExNeLz5hxbzoNNGgYLMP9SmDH+kt9Vw@mail.gmail.com>
 <CALas-ihLbODY6idQizsvH-U6OFRnC6e5=WRB6gkJ7SpBJ3VskQ@mail.gmail.com> <20140107213739.GA29954@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0eZ5-0000Eq-Va
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbaAGVv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:51:56 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:48851 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbaAGVvz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:51:55 -0500
Received: by mail-oa0-f49.google.com with SMTP id n16so839751oag.8
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 13:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jsUAY0UM2Z5lTc67SZjGUPcTLoIfaCJe/PweoTEM+ZA=;
        b=piRUOpUdo8iCyhDWx5iDXKA97eWEJ4vfEmDIT/yj9PxSSeYTkVJyhmItH3/DIDDAkc
         c7s6q/MXwoIt0ZDVOmSkuawgJG5SSVxAd58USluqufit+RB5yqfudBftvtUrggwmSNis
         1YCxYgUSkzr70yUaynt++pbFrgajBzc6ymFZIFUC9ertxf/+6jrDftf7wnJxXKRsfyI9
         cF8RoM/JnQEQf6twn2hTbGtRGUV4T0aOs/VvDJYBtGVEJr/bDqh0Y5MY1CLKR6GC4nww
         k3yCE5Y1S/O+p6F2Zb7L+7EbPVCfD7lGU1lvUKGfXyJncEY2hcF3DYaUTd2SC17JILkI
         1hHw==
X-Received: by 10.60.58.134 with SMTP id r6mr76562966oeq.17.1389131514762;
 Tue, 07 Jan 2014 13:51:54 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 7 Jan 2014 13:51:34 -0800 (PST)
In-Reply-To: <20140107213739.GA29954@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240166>

2014/1/7 W. Trevor King <wking@tremily.us>:
>
> I'd be happy to hear ideas about superproject-branch-specific local
> overrides to a hypothetical submodule.<name>.local-branch, in the
> event that a developer doesn't like a default set in .gitmodules.  If
> I could think of a way to do that, we could avoid this heuristic
> approach, and make the local submodule.<name>.local-branch
> vs. remote-tracking submodule.<name>.branch distinction more obvious.
>

Uh, I think you got it wrong in the other thread: I didn't proposed
such feature. I just wanted the attached submodule use case to be
supported and of course "--branch means attached" is even easier to
get this.
