From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Fri, 21 Jan 2011 01:52:03 +0200
Message-ID: <AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Kelly <steveire@gmail.com>, KDE PIM <kde-pim@kde.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 21 00:52:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg4IV-0003ej-5d
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 00:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902Ab1ATXwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jan 2011 18:52:06 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37810 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229Ab1ATXwF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jan 2011 18:52:05 -0500
Received: by bwz15 with SMTP id 15so1073815bwz.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BjDZyopfOr+0PVesyjJYNj7D36Z9zNLgMjZ7KnMS4pc=;
        b=RkeRx80rEUUBLy12Y8lkAfmaghQFYLP0oG/DsCwdXQPkUxRqT/W5Y5pB4TmSaXq95E
         Pzj7VI1o2mEDi/GxtO/Qwm6ktAckxOqh1IK1HjF3jpghnPfz8t3E2q88y/sKtzaUncT7
         R7BBf2leXPNkfRARSddairk6GhQ7p0v8j+zAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AurbnnrUWG5Flvshh/jsIN3umRZFxe/YyFlvnw/LGd+d311R9spv7m395eZUVzxX4G
         p6pmCwqRQTabi5qHSmCFYYte/oUcOudZNkz2t4EIFLqcyhwWTLJflgqO5PtIpY9/KDz/
         kL7UtB6DA/wgl/LUIybFxwxqPrRAb2EB1yEaI=
Received: by 10.204.76.207 with SMTP id d15mr2504969bkk.104.1295567523693;
 Thu, 20 Jan 2011 15:52:03 -0800 (PST)
Received: by 10.204.157.4 with HTTP; Thu, 20 Jan 2011 15:52:03 -0800 (PST)
In-Reply-To: <20110120215456.GB11468@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165346>

Hi,

On Thu, Jan 20, 2011 at 11:54 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 20, 2011 at 01:43:17PM -0800, Junio C Hamano wrote:
>> I personally like this line of thought, especially as a thought expe=
riment
>> to see what corner cases we could find, but I doubt I will be able t=
o say
>> we covered all the corner cases with confidence without thinking lon=
g and
>> very hard. =C2=A0For now, I do not find this issue worth spending th=
at kind of
>> deep thinking, especially when a lot simpler and easier to explain
>> workaround is available, but others may disagree and perfect your id=
ea.
>
> Yeah, after reading your response and considering a bit, I think the
> simple "don't make HEAD" thing (or at least "don't pull or push HEAD"=
)
> is a sane workaround.

I don't fully understand the issue, so excuse me if this is totally
wrong, but wouldn't a rule like 'you can't create a branch for which
there's already a symbolic ref' do the trick?

--=20
=46elipe Contreras
