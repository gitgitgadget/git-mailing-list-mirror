From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 18:43:14 +0200
Message-ID: <CAMP44s0+=t_yVXkGEa=Zm_ugBOxaMnG+ApyriSGn3DqTV-5nEA@mail.gmail.com>
References: <20121024180807.GA3338@elie.Belkin>
	<CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
	<20121024191149.GA3120@elie.Belkin>
	<CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
	<20121025042731.GA11243@elie.Belkin>
	<CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
	<20121025052823.GB11243@elie.Belkin>
	<CAMP44s3Xwt5+J_yGte_HC3hG+MhMkWnJQ7mtuB_Y+sOLB1b1+A@mail.gmail.com>
	<20121025055343.GA13729@elie.Belkin>
	<CAMP44s2bNZLiyinu3wgmw4gaRM9XUvA857-8fOGebhKYFmDesw@mail.gmail.com>
	<20121025071815.GA15790@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 18:43:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRQWm-00022R-SG
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 18:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759749Ab2JYQnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 12:43:16 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38728 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448Ab2JYQnP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 12:43:15 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1782775oag.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UWBf+yelpLWDHft++40AmMIiyzRdxDHwmfQZWjLotME=;
        b=bTt3v6dPRlgwAOMfrpz0xNNcyOALzr4sOtIujHLvNb1rBILpEgONlvtOSlRC0Rxyuc
         zakI7MssE4VFIQ6D+L9K63lIkqxRdI/9DF4k/P0HOTjKMJRgM9YqNTcvwA/WPPxGnqci
         jMeUMgVHEVF9ASFGlYIdg//VI+tf9NfBc80gdI+ADSxz8vecUslha4QsZBgHgxTl4PXM
         Iz5YC4ZWCNebPyTfbuEQNUxp/MPKM0TWXtmKx22+TdAwyQoaF2r3fFeXr4xwa88bzjmY
         vElkCLKr8fFN13AI0C+1e6NV4JUi7SJ4J3cDxH3+BzulZP1SkQ/6LwXhsCOBm3twque0
         Vbrw==
Received: by 10.60.31.241 with SMTP id d17mr17179494oei.107.1351183394935;
 Thu, 25 Oct 2012 09:43:14 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Thu, 25 Oct 2012 09:43:14 -0700 (PDT)
In-Reply-To: <20121025071815.GA15790@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208409>

On Thu, Oct 25, 2012 at 9:18 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> Show me a single remote helper that manually stores SHA-1's and I
>> might believe you, but I doubt that, marks are too convenient.
>
> Oh dear lord.  Why are you arguing?  Explain how coming to a consensus
> on this will help accomplish something useful, and then I can explain
> my point of view.  In the meantime, this seems like a waste of time.

We don't need to come to a consensus because there is no problem.
Nobody has requested this feature, and nobody has faced any problem
with this. If you have no evidence of the contrary, that's what I'll
believe.

I agree it's a waste of time, so let's not talk about the :0 -> SHA-1
feature, or the master..master feature in this thread; they are
orthogonal.

Cheers.

-- 
Felipe Contreras
