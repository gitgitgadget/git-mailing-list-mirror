From: Martin Langhoff <martin@laptop.org>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Mon, 13 May 2013 15:19:09 -0400
Message-ID: <CAAhxitGFhVa6+8x_rgNz5dgyr6m4S11fVU2eJNnMuWimGiM8aQ@mail.gmail.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org>
	<1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
	<CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
	<20130511055647.GA3262@iris.ozlabs.ibm.com>
	<20130511061322.GB3394@elie>
	<20130511094119.GA6196@iris.ozlabs.ibm.com>
	<CACPiFCKkzSCaSfqExZggFHBAmcPBTYYhyauOa2h1dXiYqKZMxA@mail.gmail.com>
	<20130513185551.GB3657@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	=?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 21:19:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbyHD-00081S-JQ
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 21:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab3EMTTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 15:19:11 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:55155 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab3EMTTK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 15:19:10 -0400
Received: by mail-ia0-f178.google.com with SMTP id i9so3980486iad.37
        for <git@vger.kernel.org>; Mon, 13 May 2013 12:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=sl2KSc9O3zGYiX3Tw2afYCqZ1Ju4dTFiqhNMVbnS8Ow=;
        b=oMlMrZEFvq10rVPhAJIgO2MkcQ9KDrGdHSP4fEPHdH+Vf/aSwO8z1FJAA2neLd5yYr
         q4Sj9NCGfd9Sr2zyckphmXixMy5HVuL8BQPmTPijLbiey/JgEWarrFRJNy5D3TfT3tth
         yJjN4uLvKvQaEWQ1mhoQwb+4ABO4MFaacIusUjSrMd5uiEoN2oATqqgnMY//Cw8edlCi
         Fq19Me4uXFRh/oRtv3VM8vUrXRUxlEcZYyezC+mvH74mOwwX3h90CHbcoVyBcaXPpf0M
         38z/tW3v/ZWNtvv26+mwTBhpCQYjnD8ElDF+sf8UeMmpej5oFm4eCXm8aOedQQcPMMIm
         0xtQ==
X-Received: by 10.50.101.100 with SMTP id ff4mr5376890igb.6.1368472749821;
 Mon, 13 May 2013 12:19:09 -0700 (PDT)
Received: by 10.64.46.202 with HTTP; Mon, 13 May 2013 12:19:09 -0700 (PDT)
In-Reply-To: <20130513185551.GB3657@google.com>
X-Google-Sender-Auth: LXzxIPyyw2S7mxaiBK2JXy3nY-A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224194>

On Mon, May 13, 2013 at 2:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> My experience is the opposite.  I wonder "What did the author of this
> nonsense comment mean?" or "What is the purpose of this strange
> condition in this if () statement?".  Then "git log -S" finds the
> culprit

Only if that if () statement looks that way from a single commit.
That's my point. If the line code bit you are looking at is the result
of several changes, your log -S will grind a while and find you
nothing.

cheers,



m
--
 martin@laptop.org
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
