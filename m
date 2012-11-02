From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Fri, 2 Nov 2012 23:18:15 +0000
Message-ID: <CA+39Oz7vbAwQSfL0PMjjYgQ=njQpu5i_3BSTCzznQJozKOKeXQ@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
 <20121029215631.GF20513@sigill.intra.peff.net> <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
 <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
 <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
 <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
 <5090EFCA.7070606@drmicha.warpmail.net> <CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
 <509149D9.3070606@drmicha.warpmail.net> <CAMP44s2PDZwTW55NDho9DyB2XZmsG0-KH4e78grJ2OFRVZkfjg@mail.gmail.com>
 <20121102144618.GA11170@sigill.intra.peff.net> <CAMP44s0N3k4b9SoKpkR=2-zSBb41tKW37tYhuxFfbooiLu59Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 00:18:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUQVh-00072L-U5
	for gcvg-git-2@plane.gmane.org; Sat, 03 Nov 2012 00:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab2KBXSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 19:18:31 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44969 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab2KBXSa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 19:18:30 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so4144641oag.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=qpmVUlClXMSJuGk1b8hs7v7y1GI746R7Ukb1rsftUKU=;
        b=S3ThTHImOiWwX6lJzioLs5T/APkadFWw92qBGWEqLbCTmAKbn5tiBzR75TYred7JKP
         P1+OJm/tzlF5lgHHF9KzbGsjm8AmezZvREyAyKMxSwFGdtuSpcqg6U7Jl2eoCS4Dk+TE
         u9t4oQlUSHAju6+Jx5S/awziz2uHY13uPd8KQUNs/em18ncw0KHXspZLiYJe1uzlyhnK
         pwwZHD+6blzD4xJ9IVS47AkgsJ5VVySkRbBLDxOla5cx8054PGYxfP9L6+gIgbvGygFE
         ErNHSHPEsZIjEM94cYfjFuE0FMm6uKGYunj3+toTA6nwWEEUosv+eEaNNeg98exm0K7n
         +uOQ==
Received: by 10.182.240.50 with SMTP id vx18mr2646112obc.31.1351898310250;
 Fri, 02 Nov 2012 16:18:30 -0700 (PDT)
Received: by 10.182.109.35 with HTTP; Fri, 2 Nov 2012 16:18:15 -0700 (PDT)
In-Reply-To: <CAMP44s0N3k4b9SoKpkR=2-zSBb41tKW37tYhuxFfbooiLu59Kw@mail.gmail.com>
X-Google-Sender-Auth: BopeR4ZdEcO3VFptnpF3aF594bM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208975>

On 2 November 2012 18:39, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> I disagree. The open source process works not by making favors to each
> other, but by everyone sharing and improving the code, by
> *collaborating*. "I review your code if you review mine", or "if you
> by me a bear in the next conference" is not the spirit of open source,
> although it might happen often.

So shunning any attempt at explanation, and peddling your own thoughts
over and over again, irrespective of whether you contribute code or
not -- doesn't mean to say you're right, Felipe.  And that's the
fundamental issue here -- your code speaks for itself, sure, no one
denies that, but the code is not even *half* of what makes up the
discussion.  And so far, the surrounding context and attitude from you
doesn't help or enhance the process under which your code is reviewed.
 And no, you cannot philosophise this, or wriggle out of it through
idealism or some other "charter" or "code of conduct" -- as reviewers
of your code, we have to interact with you to be able to better it.
But you seem very reluctant to do that.

The fact that we're even having the conversation is evident of that.

-- Thomas Adam
