From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] revert: Simplify passing command-line arguments
 around
Date: Sun, 9 Oct 2011 04:24:32 -0500
Message-ID: <20111009092432.GB29150@elie.hsd1.il.comcast.net>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
 <1318095407-26429-7-git-send-email-artagnon@gmail.com>
 <CALUzUxo=xN735+=Yz9eS_VSW3fpiTeng9s-66qM0Jno40-DPXQ@mail.gmail.com>
 <CALkWK0kA=zhpsmYhjMwv11xyHNhA0Ps=BjUDao0+HFLMKnADUg@mail.gmail.com>
 <20111009085306.GA9209@elie.hsd1.il.comcast.net>
 <CALkWK0niwg1Ogs+xBr8NHEce-MUUzPc_Upn0ZKRi3iCZ6fA4BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 11:24:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCpcl-0008QX-QK
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 11:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088Ab1JIJYn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Oct 2011 05:24:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38339 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1JIJYm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Oct 2011 05:24:42 -0400
Received: by iakk32 with SMTP id k32so6170542iak.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qHhfg0Us6B6NgZekwDl17wTmIzHx6Wr2TAQunTBJj6M=;
        b=x6JC+Lh0cnXrYTb+IRSkUkywDfJwyMabAftnAO8XkTSi0akNyhooJ9HmMao/6uNW3T
         i2z5cL+uwooK/veqiLArw474DsKTRbspDfWqCQ2f8beRqXnwzbnht5XDJ7vAzuxPaVKt
         hWR5JCokWvwYinjW1fPDp7Vs3agUrnh+AvVCY=
Received: by 10.231.6.79 with SMTP id 15mr6136491iby.52.1318152282215;
        Sun, 09 Oct 2011 02:24:42 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id jm11sm12644817ibb.1.2011.10.09.02.24.41
        (version=SSLv3 cipher=OTHER);
        Sun, 09 Oct 2011 02:24:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0niwg1Ogs+xBr8NHEce-MUUzPc_Upn0ZKRi3iCZ6fA4BQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183193>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> Sorry I haven't had a chance to look over the patch yet. =C2=A0Is it
>> supposed to introduce a behavior change, does it prepare for some
>> future change, or is it just a cleanup?
>
> Prepare for some future change.  See $gmane/179282 for original discu=
ssion.

Thanks, but I shouldn't have had to ask.  Care to fix the commit
message? :)
