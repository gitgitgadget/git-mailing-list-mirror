From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Re: Re: Relative submodule URLs
Date: Wed, 20 Aug 2014 08:18:12 -0500
Message-ID: <CAHd499C2F2s51qmfwS5VxLvP-O2Wjdb6-yfj+T9tMkZz7ohVXQ@mail.gmail.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
	<20140819102421.GA5012@book.hvoigt.net>
	<CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
	<xmqqiolowi1f.fsf@gitster.dls.corp.google.com>
	<CAHd499B9Wa=Y6P+OD8Ea-6dA4yZSkGZZSR9CwZAM45evDL_Qiw@mail.gmail.com>
	<20140819193010.GA64203@book.hvoigt.net>
	<CAHd499BvBBymACfHVZyuSXuNSFbT+M8my4uATOsn30w90Zb0QQ@mail.gmail.com>
	<20140819205747.GB64203@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 15:18:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK5mN-0004HC-5W
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 15:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbaHTNSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 09:18:14 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:42968 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbaHTNSO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 09:18:14 -0400
Received: by mail-vc0-f181.google.com with SMTP id lf12so8926417vcb.26
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0qNDH4ekVXcvxLR+bGuWgaRzFWrhItA0J0aKYnpMDcs=;
        b=atXkHecVdM0YNAYmuLu8lk2czIEctofguwy1gksS/mr75NH7YlkQYhEzRkTybe8zQh
         QFFdx5FM6+AQlTDFjX8haQlKFnMpikdn20AojEPRumLI3QOkb3rdZhmfgUXxM7JVGn81
         qGPMAC3RpRn7e9Dx5tKOSz4/dX2PxLcIk9pCJGkoePX0wXyFv6R4XQBeUyuzL7ddFEZQ
         wSDIwyy8oNbkt/tEsg5CBBO/I6XTzAO83fxHt6aUctQgFY7OwdYAFhDyEXdXLfsGHSC9
         zKx4rrkkq3HQIn+ey2sEturugnWK2JcVeCdfxSU6ki8aAU1NHfx4r0bfa2FrArbzq8L+
         Qf6A==
X-Received: by 10.52.175.130 with SMTP id ca2mr251031vdc.94.1408540693050;
 Wed, 20 Aug 2014 06:18:13 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Wed, 20 Aug 2014 06:18:12 -0700 (PDT)
In-Reply-To: <20140819205747.GB64203@book.hvoigt.net>
X-Google-Sender-Auth: nqpjFiphA9XYEv1YQvteYWdgtmg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255570>

On Tue, Aug 19, 2014 at 3:57 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> I would actually error out when specified in already cloned state.
> Because otherwise the user might expect the remote to be updated.
>
> Since we are currently busy implementing recursive fetch and checkout I have
> added that to our ideas list[1] so we do not forget about it.
>
> In the meantime you can either use the branch.<name>.remote
> configuration to define a remote to use or just use 'origin'.
>
> Cheers Heiko
>
> [1] https://github.com/jlehmann/git-submod-enhancements/wiki#add-with-remote--switch-to-submodule-update

Thanks Heiko.

I would offer to help implement this for you, if you find it to be a
good idea, but I've never done git development before and based on
what I've seen it seems like you need to know at least 2-3 languages
to contribute: bash, perl, C++. I know C++ & Python but I don't know
perl or bash scripting language.

What would it take to help you guys out? It's easy to complain & file
bugs but as a developer I feel like I should offer more, if it suits
you.

Let me know I'm happy to help with anything. Thanks again!!
