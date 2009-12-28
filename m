From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Allow git to use any HTTP authentication method.
Date: Tue, 29 Dec 2009 01:15:48 +0800
Message-ID: <be6fef0d0912280915k1320110o6a361a0950aa60f6@mail.gmail.com>
References: <200912281154.09442.lenaic@lhuard.fr.eu.org>
	 <alpine.DEB.2.00.0912281406210.5582@cone.home.martin.st>
	 <be6fef0d0912280412w58401f10n972f9198144cd580@mail.gmail.com>
	 <20091228153701.GA2252@spearce.org>
	 <alpine.DEB.2.00.0912281745540.5582@cone.home.martin.st>
	 <20091228155346.GB2252@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Martin Storsj?" <martin@martin.st>,
	=?ISO-8859-1?B?TOluYe9jIEh1YXJk?= <lenaic@lhuard.fr.eu.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 18:16:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPJCJ-0007X9-Pl
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 18:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbZL1RPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 12:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbZL1RPu
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 12:15:50 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:39913 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbZL1RPu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 12:15:50 -0500
Received: by iwn1 with SMTP id 1so7381372iwn.33
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 09:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=YphTBFtGTscp40STnXo6k+sL9RZ/mAZ3dA03st90SY0=;
        b=ezO5gD3DF2IPuyh7l82G/OeYPh0Ssmzz9kFU3a+AtRXKsQKOVCmqMWbM009NaQOe+B
         C8hipdHbXwQbWQl/JOd9xVyEwCoYyB5qYGZfaHbwKMYnbfX2wfqLwDthbL+82fneLq6g
         2qNtHn2OAeJyOqeU27M/l8jQJMLiqLz3ftaGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hywZtX7EmyceM+KBQsyWCitjVla/ejK53Al4tNZl2fGIRlP5HI628pcHD1l2yIBLQI
         jHpNvtO8L114fp7RpH4YCOS74B7YP4XjBTKhLSOqvQUxIxPt6MCyhHp98yu7+wCmcpOQ
         +JIpe7/jeLADRjNoERGZ1rcRMPpolR6NSpI78=
Received: by 10.231.170.136 with SMTP id d8mr711521ibz.17.1262020548092; Mon, 
	28 Dec 2009 09:15:48 -0800 (PST)
In-Reply-To: <20091228155346.GB2252@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135749>

Hi,

On Mon, Dec 28, 2009 at 11:53 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Martin Storsj? <martin@martin.st> wrote:
>> Should I send in a new patch that removes the http.authAny option and
>> always enables this, or send a rewritten version of the patch that already
>> is in 'next'?
>
> I'm not Junio, but I would suggest sending in a new patch series,
> and asking Junio politely to revert the one that is currently in
> next before merging in the new series.
>
> If we really are killing http.authAny before it hits master, there
> is no reason for it to appear in the final project history.

hmm, a few days back Junio (added to Cc list) sent out an email
regarding branch shuffling and dropping topics from 'next'. Junio,
could we piggyback on this?

-- 
Cheers,
Ray Chuan
