From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Tue, 1 Nov 2011 21:35:47 +0100
Message-ID: <CABPQNSaiFpmHa_GLF8PaejvXTkqCMoWG+Cd4MbNrqXF-SXR1yw@mail.gmail.com>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
 <7vd3dcq4s5.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1110311908240.1930@bonsai2>
 <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com> <7vy5vzn65u.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	Karsten Blees <blees@dcon.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 21:36:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLL4h-00028l-8G
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 21:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553Ab1KAUg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 16:36:29 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63293 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab1KAUg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 16:36:29 -0400
Received: by vcge1 with SMTP id e1so6096398vcg.19
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=b9QQhvpiWISCE1rSmrF1f9/zglsltky67gE1aeJS6+g=;
        b=GRYWTs0Dk57/dksxxSV7U63o2OwxIzy/Z5MynPXo3YqbsvqfswPHrwNLIT/6Qn5byU
         F7u91XFN3sOXer/aKGBcY+bw0JTeR3qYJHI09zx7d/rSKbTAaa25BCQQ7txQgB9Qp6oF
         GJonNK3IJ230SLhAM+ZMG7ToSm3bWZcuJsyaA=
Received: by 10.68.209.103 with SMTP id ml7mr1936720pbc.17.1320179788048; Tue,
 01 Nov 2011 13:36:28 -0700 (PDT)
Received: by 10.68.71.135 with HTTP; Tue, 1 Nov 2011 13:35:47 -0700 (PDT)
In-Reply-To: <7vy5vzn65u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184588>

On Tue, Nov 1, 2011 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> This is a slip-up in my patch 0f77dea, but I don't quite understand
>> why this didn't cause any troubles until now... I guess the MSVC parts
>> of Makefile are somehow more dependent on LIB_H or something...
>>
>> Junio, is it too late to squash in a fix-up? If it is, I can send a
>> fixup-patch instead...
>
> I can queue this for v1.7.8-rc1 if you want, as it is a fix whether or not
> we define MSVC or not while building.

Yes, please do. This looks good to me, thanks for picking it up :)

>> So there's some more work left to be done. Unfortunately, I don't have
>> time to polish these changes for at least a week, so unless someone
>> volunteers it'll take some time...
>
> It seems, from your description, that msvc update series has some way to
> go and it probably is better to be cooked by Windows-savvy folks for
> another cycle.

I don't think you need to hold these three patches; with them I was
able to build your 'master'. I believe the problems I bumped into only
exist in msysgit's 'devel' (or in your 'next', which msysgit/devel is
based upon).

> Which would mean that your upload-archive series is still
> good to go as long as it works for non-MSVC/mingw people, right?
>

Yes. Apart from the slip-up with LIB_H, my upload-archive series
should be unrelated to the issues I found here.
