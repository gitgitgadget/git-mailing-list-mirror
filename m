From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Wed, 8 Jul 2015 12:29:34 +0200
Message-ID: <CAP8UFD1=KxcYyFfFZ++5Vty-KMv-ci8dtdo4bfX7oj_wgLOE7g@mail.gmail.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
	<CAP8UFD3pD_6_SrrtCWywA8x5XY_SD3bed=QhZBBrTq0zQvqFPw@mail.gmail.com>
	<CAPig+cTpy32c13Sv=m49hzqOBisZ0v07AT0X5BYNB07acrcW8w@mail.gmail.com>
	<CAEcj5uXiGVvLm==s_SB7GnvBfuKi7j4yH+fgNq4JZtkvK7pZwg@mail.gmail.com>
	<CAPig+cRv6g_nAEdGtrESFiE+5+OxEHwjhEPX0Q0WL+eHzkCAGA@mail.gmail.com>
	<559CCFBE.9000702@drmicha.warpmail.net>
	<xmqqegkjyu0b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Eric Raible <raible@nextest.com>,
	Emma Jane Hogbin Westby <emma@emmajane.net>,
	Max Kirillov <max@max630.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	karthik nayak <karthik.188@gmail.com>,
	Paul Tan <pyokagan@
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 12:29:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCmbl-0001JX-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 12:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933108AbbGHK3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 06:29:37 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37186 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761AbbGHK3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 06:29:35 -0400
Received: by wiclp1 with SMTP id lp1so75921706wic.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GAW0hpo3tUikx+CJ6U3n0YLKg3DLcTmlHQPAtpTEDYE=;
        b=JSA3RLEU/QZscKCz3BdAnNdche+cKlKI3CHKmxcnZmTKoedyx3n//AFz4CfKcr5/VY
         KlK5aROCdPiEPcQ3n+fTmRsZkj5nNA/di7sUa8ST3EFDe7l2u2LLuzMnm3cS9VSr9EUG
         9hNuJwC9iyVxevFZ8cTCg0I/TvaFqWTzI3Hv3DUW36LDj7uWF6+kPGWlQUoEGQphy+FS
         vRXifzOlIFdpkq7GOd5RptCdve43tQ+tEsE2aFqb/ZyLM3m60trc6ytkQp1Ifi/fGiA6
         KAhpNhgi1YJOLgKy/XfpoMKO2dvsY+o1apltb0CcezD0TYJ/eaHGzMcgekmoN92Jo9Sl
         leNQ==
X-Received: by 10.194.23.225 with SMTP id p1mr19119916wjf.155.1436351374798;
 Wed, 08 Jul 2015 03:29:34 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Wed, 8 Jul 2015 03:29:34 -0700 (PDT)
In-Reply-To: <xmqqegkjyu0b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273657>

On Wed, Jul 8, 2015 at 9:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Maybe a matter of taste, but I think in general we could do with a bit
>> less of "narrating" and more of "summarizing".
>
> True.

I think sometimes the details might be interesting for different reasons.

>> Just as an example, in the section on "visualizing merge diffs after the
>> fact", few people will be interested in the detail that I pointed out
>> the "--merges" option of rev-list to Dscho. While that recollection is
>> true and everything on the git-ml is public, I consider "Git Rev News"
>> to be "more public", targetted to a wider audience than the regulars.
>> They don't all know how much Git owes to Dscho. If things like this end
>> up in the news it makes me ponder for each on-list reply whether I'd
>> rather reply in private. Maybe I'm being overly sensitive (though not
>> affected in this case), but I just feel there are different degrees of
>> "public".
>
> I do not see "Michael pointed out that there was a slightly better
> way to do that" as saying anything bad about his contribution.

On the contrary I think that the way Dscho used sed shows some cli
proficiency and might be interesting to some people.

> I however do agree with you that we want to see the newsletter aim
> to summarize things better.  Instead of saying "Dscho suggested X,
> Michael then refined it to Y", with full details of what X and Y
> looked like, it would be more appropriate for the target audience to
> say "Dscho and Michael worked together to come up with a solution
> Y".

With the details, I think readers are more likely to remember the
--merges option.
