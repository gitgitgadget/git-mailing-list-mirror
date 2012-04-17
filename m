From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 03:06:22 -0500
Message-ID: <20120417080622.GF20017@burratino>
References: <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
 <20120416203320.GF12613@burratino>
 <7v7gxftn78.fsf@alter.siamese.dyndns.org>
 <CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
 <20120416224411.GU12613@burratino>
 <CAMP44s0cdSaiCoMLk7oTHE4dies5-G0C7-RczK5OFEK=pYUW_A@mail.gmail.com>
 <20120416231626.GW12613@burratino>
 <CAMP44s3OSepH_XpCcTWLN=bF0+P9fmHtyPnWdQnEocW25jHTpA@mail.gmail.com>
 <20120417073653.GB20017@burratino>
 <CAMP44s3mnnhKXHUEMSX+d2L2Jyqr9_Q7F=3DvWb4MKxHpTRREg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 10:06:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK3Qv-00017x-85
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 10:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab2DQIGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 04:06:35 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47831 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007Ab2DQIGc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 04:06:32 -0400
Received: by iagz16 with SMTP id z16so8606056iag.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 01:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sFRQiZybX6l2b/0UyouGfLzieWY7kLKj83hEvGtoh5Q=;
        b=Y6+gnaVOeMqrC3os1sM+K4WSQLDhb3rfM8Si1AVBR9tcujDXdIGZQRo9dG+vjGspHU
         0e1kPFUwcLLfKbhCWSm7pnLECd2E9qzdV/NH8V+H6VmuauE4CY2a8ruiI2Wmoc5gpYgZ
         dPvSm4fUp3zS/Y4/qSoGL4bfjg5jpidcxuRMQpkCrQCN13YiGuDZD6XEFvoAfQTFP9cU
         T/GPW0BNaw0MeBMx5N4RGdbn4hPiIDMibx+b1SdeXvK9wSxji5OUF0rYdXHd4rfo8rN4
         LE4KjrS0kqWWND61+X2JiR/z4FOD2sPV1jeId0yzQtUT1tZjQxyPVncI2eU7w8NzYFK/
         Zv4w==
Received: by 10.50.186.129 with SMTP id fk1mr8269554igc.73.1334649991911;
        Tue, 17 Apr 2012 01:06:31 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id kn3sm14455201igc.15.2012.04.17.01.06.30
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 01:06:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s3mnnhKXHUEMSX+d2L2Jyqr9_Q7F=3DvWb4MKxHpTRREg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195742>

Felipe Contreras wrote:

> Sure, it would be nice to follow bash_completion project's convention
> for these kinds of functions, if they had any, and might be useful to
> ask them what they think. But we don't *have* to. And nobody is
> arguing that we should ask them. Right? Or are you?

No, I really am not arguing that we should ask them.  Because we (or
at least I) already know at least what their convention was a few
years ago.  However, I do encourage anyone curious to ask them instead
of making up arguments about why the answer is obvious.

[...]
> But throwing arguments on the air, and they get angry when they get
> counter-argued is not helpful. If we are going to discuss, lets
> discuss, but that doesn't seem to be what you want. You want me to
> blindly use the name you propose without saying a word?

I do not think it is fair to call your position blind.  I really would
be happier if you were able to listen, and, instead of throwing out
protests and debating points, to talk about your real concerns.

I am guessing (but you never said!) that you find the name
__git_complete ugly.  That's fine.  I even agree.  I have mentioned
that there is a namespace that your proposed alternative violates.
Your response is... to refuse to believe that what I said is true or
relevant?

How am I supposed to have a reasonable discussion after that?

This is not a debating floor.  When I give what I think is relevant
information, I am not requesting "please misinterpret me and shoot me
down".

Ciao,
Jonathan
