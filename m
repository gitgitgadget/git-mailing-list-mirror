From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 11:59:03 -0700
Message-ID: <20121031185903.GA1480@elie.Belkin>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
 <20121029215631.GF20513@sigill.intra.peff.net>
 <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
 <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
 <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
 <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
 <5090EFCA.7070606@drmicha.warpmail.net>
 <20121031102712.GB30879@sigill.intra.peff.net>
 <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
 <CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 19:59:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTdVf-0005iJ-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 19:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458Ab2JaS7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 14:59:14 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59742 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab2JaS7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 14:59:12 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1168475pad.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lwrdcEqs7qQzgYOVKr2KJN7sBdXgTDM3q/x10XddrRQ=;
        b=ysGpIwt8Oqfj6xmVP3wCiw33hVhoM5vBmRD9+9IyI8RSQ4NDXXPCqOY5RdFlHICajb
         M6y84EB8G1oZ+7RZ0tHh/jDfWvsL2EbOomAwxtRCf/JjbFah8ICw4pcNTzNkZ/u60rYM
         iQgYNSpxaUDgwZisOAV3A684L083A+56yBzTo1zeq1Gwq6y0gi861AKuur8hE3jss8xU
         4Dv4y9ECuJVH8XaFiQFFoKymWApIP2JKZIKPaLXyotWpwnspCX8d1WD//aO22s/pZXO9
         QkpC7y9L92YBABxzHz9SsDc1p1HoxcSMyEtQkZQZH4bNhFvaVXVTIpt4D/u7ltwVMWvq
         79zQ==
Received: by 10.68.225.34 with SMTP id rh2mr115594835pbc.78.1351709952570;
        Wed, 31 Oct 2012 11:59:12 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id wo9sm2680199pbc.53.2012.10.31.11.59.10
        (version=SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 11:59:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208849>

Felipe Contreras wrote:
> On Wed, Oct 31, 2012 at 7:20 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:

>> I just tested this with junio/next and it seems this issue is still
>> unfixed: instead of
>>
>>         reset refs/heads/blub
>>         from e7510461b7db54b181d07acced0ed3b1ada072c8
>>
>> I get
>>
>>         reset refs/heads/blub
>>         from :0
>>
>> when running "git fast-export ^master blub".
>
> That is not a problem. It has been discussed extensively, and the
> consensus seems to be that such command should throw nothing:
>
> http://article.gmane.org/gmane.comp.version-control.git/208729

Um.  Are you claiming I have said that "git fast-export ^master blub"
should silently emit nothing?  Or has this been discussed extensively
with someone else?

Jonathan
