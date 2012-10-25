From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 06:19:31 +0200
Message-ID: <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
	<1320535407-4933-2-git-send-email-srabbelier@gmail.com>
	<CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
	<20121024180807.GA3338@elie.Belkin>
	<CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
	<20121024191149.GA3120@elie.Belkin>
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
X-From: git-owner@vger.kernel.org Thu Oct 25 06:19:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TREv2-0006o3-I6
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 06:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab2JYETc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 00:19:32 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35291 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2JYETb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 00:19:31 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1204560oag.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 21:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RhyC/F/51XDOJq0FmCxe6XGgLDuSztIcN6DIjwwsYT4=;
        b=nDl07/wPKoRop3ITlgygHQBTBSxOmRMrQvl3ARXV7WwiPyu4mRPmpDoceXNorPGNAt
         ZJ6kD8Qj5gTP5cmeU5xkTmn8b4OBctK7l/F/hTTZcVMeV2mgo10/KAqN4S/mlgIMiIb7
         3OP93gasinFztAHrDTmJDe7/JH2dFAS4rFv54KAyW5PekvLSvSvZV6YIXYYHbCIIIP8z
         1rnbMZZP/S6yp0b4MkjRN6CUhjN37eimNfS6CV1yjvSbi/r7vnjHLNSKPtPYnulu7vVb
         KmKvIkBg3iWRJjyJ1TY+PyRFUMNwkRIgzoghTvB8NTQAw4+EE1NJdjx74Js55uyNtS2y
         nOjA==
Received: by 10.60.27.201 with SMTP id v9mr6756404oeg.85.1351138771448; Wed,
 24 Oct 2012 21:19:31 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 21:19:31 -0700 (PDT)
In-Reply-To: <20121024191149.GA3120@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208337>

On Wed, Oct 24, 2012 at 9:11 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> Does it mean that? I don't think so, but let's assume that's the case.
>>
>> We don't have all those commits; without the marks we have nothing. Or
>> what exactly do you mean by 'we'?
>
> Not everyone uses marks.

When you don't have marks you have to export *everything* that you are
interested. If you want all the history from the root to master, then
that's what you will get (and you specify 'master'), if you want only
the commit pointed to master and nothing else that's what you will get
(with 'master^..master'), but when you do 'master..master', you get
nothing, because that's what you asked for.

Again, if you don't have marks, I don't see what you expect to be
exported with 'master..master', even with marks, I don't see what you
expect.

-- 
Felipe Contreras
