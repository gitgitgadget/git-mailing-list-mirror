From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: git:// protocol over SSL/TLS
Date: Sun, 29 Dec 2013 02:52:48 +0600
Message-ID: <CAErtv24VXqq3HenbygvUG8qhsMTxKfC8-U0Udrgobia0u4vGsw@mail.gmail.com>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
	<87mwjm4c3s.fsf@igel.home>
	<vpqwqiqpe80.fsf@anie.imag.fr>
	<CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
	<20131227162606.GA6973@client.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Sat Dec 28 21:52:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vx0sQ-0001F4-5t
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 21:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896Ab3L1Uwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 15:52:50 -0500
Received: from mail-ve0-f169.google.com ([209.85.128.169]:48493 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3L1Uwt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 15:52:49 -0500
Received: by mail-ve0-f169.google.com with SMTP id c14so5484178vea.14
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 12:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YSSbyCKw6ZvhjeirNjJaWQpT0sK51S2mmT2GabJfNv0=;
        b=JM0sBLNxzaymcDlBfu6e1MOEnXiyV+hs3MqyQetjTYPK/C4R+Aclt1yOLFHyfZrP4a
         C237qYgMsU2VaBZW9ejWLwP1Cxjk/aAd/pjo4LdsR/43VwY9is5a5Jun0w4CSpLDkbxb
         sbWfrlXVgO1cX06ihB/QaxasD5tuIqcXErOn5v0ZD5GJGb5vthz88r/P54OG52uGfnHN
         dnKIKbi65yKBQRK3vdyM8qa466i/oba8yWnt279n3i5XoeswQzDuPNcvcCqn/sdkwUuL
         Xh5rBaPDpYJ3ublyPt7nhXSZhWHMwn1N7HB0WN4LQWWlveTJl/LxT2m2HcyJ90OECME2
         eWDw==
X-Received: by 10.58.100.244 with SMTP id fb20mr31177621veb.6.1388263968479;
 Sat, 28 Dec 2013 12:52:48 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Sat, 28 Dec 2013 12:52:48 -0800 (PST)
In-Reply-To: <20131227162606.GA6973@client.brlink.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239789>

Yeah, i understand this. We can not protect self from every single
possible attack..

On Fri, Dec 27, 2013 at 10:26 PM, Bernhard R. Link
<brl+git@mail.brlink.eu> wrote:
> * Sergey Sharybin <sergey.vfx@gmail.com> [131227 15:25]:
>> Security in this case is about being sure everyone gets exactly the
>> same repository as stored on the server, without any modifications to
>> the sources cased by MITM.
>
> Note that ssl (and thus https) only helps here against a resource-less
> man-in-the-middle. Getting catch-all CA-signed certificates is said to
> no longer available to everyone as easily as it was some years ago, but
> unless you allow only one private CA (and even there clients often fail)
> you still should assume everyone resourceful enough to still be able to
> do MITM.
>
>         Bernhard R. Link



-- 
With best regards, Sergey Sharybin
