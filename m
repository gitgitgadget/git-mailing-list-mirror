From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Wed, 2 Mar 2011 19:57:28 +0700
Message-ID: <AANLkTimPGxzP+XfX8Ng5U_4UnPWZCFLQ-3rP4oPTE3o+@mail.gmail.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
 <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com>
 <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com>
 <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com>
 <7vsjv6evy4.fsf@alter.siamese.dyndns.org> <4D6D0A51.9030701@drmicha.warpmail.net>
 <AANLkTi=YHNnuBAF_GitrmMYFK1h_p9JP54hRyj9vWTzc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 13:58:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pulcy-0008Do-Qi
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 13:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846Ab1CBM6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 07:58:00 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55017 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab1CBM57 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 07:57:59 -0500
Received: by wwb22 with SMTP id 22so5802468wwb.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 04:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=37eKDUZgvFXYSySO0k2MY06Xt9yO72dCa4XNC5FGsow=;
        b=B+u6YU7yEsgfVYuQjeVEvaBqPTKEFaaGAPUDdJImgpXiBGV0lxV4br4kZ3SNxqHyRQ
         dPUF2A67K7AP7qvd4wxurbAaDYsBWgvtZlSQvXFNbI5ylY38RvdYT5CxfP4BrSJpIJ6Y
         LejO2LguPHx8y51gq8lLNA24Trq1x6gCfHqPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tHdNVtrLW6aVPOdnJ+cY2ec+K6/S4TDmB6tURVis0GRWYZIpW6cGPdJTeGRQkrjd6U
         WVMTaidsFAoM07lLciVHUZ4ucAiwdtxu4XJ9ICMmnKjf9QVAwBzeYwzyfXAfmH1QHnJb
         FPYayn/FL+6PU7Cw0r0063RgdaMeTHuUXzXdI=
Received: by 10.216.50.72 with SMTP id y50mr631351web.28.1299070678114; Wed,
 02 Mar 2011 04:57:58 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Wed, 2 Mar 2011 04:57:28 -0800 (PST)
In-Reply-To: <AANLkTi=YHNnuBAF_GitrmMYFK1h_p9JP54hRyj9vWTzc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168306>

On Wed, Mar 2, 2011 at 7:34 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Tue, Mar 1, 2011 at 16:01, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> I have to say I'm really excited about how transparently this works
>> across all kinds of commands, and how suggestive this is with rev:path
>> in mind.
>
> I like it, especially considering how small the impact on the codebase
> is. The downside is (once again) backwards compatibility though, I
> haven't heard much on how to address that, other than "just quote it"
> (which _I_ think is fine, people with filenames that start with fancy
> characters are probably used to quoting them anyway)

Yeah. And if this is accepted, the "git add -u (without dot)" issue
may cool down. I personally don't mind typing "git add -u :" (or "git
add -u :/").
-- 
Duy
