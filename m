From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC] Add [] as an alias for a reference to the empty tree
Date: Mon, 10 May 2010 13:00:17 +0200
Message-ID: <AANLkTikrRJZu2I5BYU-UqtjYh0x6WMJ8Frh8DKPUM-yK@mail.gmail.com>
References: <1273250247-20762-1-git-send-email-pkj@axis.com> 
	<20100508045319.GD14998@coredump.intra.peff.net> <7vhbmjc6dy.fsf@alter.siamese.dyndns.org> 
	<A612847CFE53224C91B23E3A5B48BAC74482E511E7@xmail3.se.axis.com> 
	<20100510092054.GA2602@coredump.intra.peff.net> <AANLkTinsofcjlVmnMtW7mONO8zGQd2eT9rMEynVNchsR@mail.gmail.com> 
	<20100510100050.GB2098@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 10 13:00:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBQj7-0007Fy-Ll
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 13:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712Ab0EJLAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 07:00:40 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:44389 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756707Ab0EJLAj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 07:00:39 -0400
Received: by wwa36 with SMTP id 36so1438034wwa.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Yj5KiDXtamWtYzY1dvD1uNW7Yr3LpXeAz2/lotgAiOw=;
        b=soGEdE8GJUGdtwWMBtsP6FcwtBIbpLkdJ1ATbmnuLMbRIxDiR9dEvL9krvbeVu+uC7
         WkGafAZSd31agY/ipJEylcBHaLvbeo3rg+q3OYagYbiIg581MRFhatjKzQjUYsBdawbD
         EVitD2SMVIK5eBqQ6/toZRgGp6nurf32s/HKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nFm1WmdVv+CJuc+Tp71Tpp7K5qtUCh5+Na/31xFKkBixdUxXF3OhoI/Kx2C9wuDgj6
         WpBY0KEENFqN60suzIiZI3B6zl2Yldm3yYt3GAHoFV+DZt0MhcqVJ22FWO5nloZVCr3u
         +UqlKt2eP4S1T6V0GccjpC50hk1rELWiLaaJg=
Received: by 10.227.154.15 with SMTP id m15mr3580745wbw.96.1273489237488; Mon, 
	10 May 2010 04:00:37 -0700 (PDT)
Received: by 10.216.60.147 with HTTP; Mon, 10 May 2010 04:00:17 -0700 (PDT)
In-Reply-To: <20100510100050.GB2098@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146795>

Heya,

On Mon, May 10, 2010 at 12:00, Jeff King <peff@peff.net> wrote:
> On Mon, May 10, 2010 at 11:51:05AM +0200, Sverre Rabbelier wrote:
>> Must it be ALL CAPS? In Mercurial the fairly elegant 'nil' is used for
>> the empty commit, why can't we do the same?
>
> [Please watch your quoting, which is a bit misleading there].

Apologies, I accidentally removed Junio's attribution line. I fully
intended to reply to both your and Junio's post at the same time :).

> I think the intent was that because they clash in the normal refs
> namespace, we would set them apart with caps (and we have already
> sort-of claimed the all-caps namespace with things like HEAD,
> FETCH_HEAD, etc).

While I understand the rationale, (of already having two all-caps
refs), I don't think adding more of them is a good idea. Aesthetically
I think 'nil' does make sense, but I agree that 'worktree' and 'index'
as lower-case names do not.

> The point was to make a more obvious and verbose alternative for people
> who find "git diff" a little confusing. E.g.:

I don't think that all caps names make for a good solution to that
problem though.

-- 
Cheers,

Sverre Rabbelier
