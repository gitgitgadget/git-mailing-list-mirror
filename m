From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Mon, 11 Oct 2010 16:21:51 +0000
Message-ID: <AANLkTimAj_sCquCixmTOEV5ZaQVbbv-yvm=Yw82har1t@mail.gmail.com>
References: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net>
	<AANLkTikb2vDMXLa48QsDfK6grczmqC1uk1jYi0ZFq9QC@mail.gmail.com>
	<4CB2FEB8.3050705@drmicha.warpmail.net>
	<201010111718.39996.jnareb@gmail.com>
	<4CB32D15.4080204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:22:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5L8Q-0003mw-Nz
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007Ab0JKQVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 12:21:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46055 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393Ab0JKQVw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 12:21:52 -0400
Received: by iwn36 with SMTP id 36so7164iwn.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=hd/77jFjaIN+qv3+gLZxK7vKkB0fGo+Jn3npLjfQb04=;
        b=I6rnrN4GumI+C18w/w3oU4j/ASMOEVLnNb9X1maKtiIrLIEc5GJzipy/rVAN9VRu0C
         y9YiggmP6TpB5CUkVMXqkRQ71tmgd8WTdS5JuEYYkeN5PJBoRxwc48CbOE9kE1Adg3hw
         y4m9TcwY6G3wb7Xd0jIP773dt2pyanzG3TPqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Vs7KpU2HAKYF78QRs9HA0YYRtzBkeDAtCTawfFCRLK6VtVUg2GfvUR39JWxH3RdU1C
         vFU6u7fzr20T9cpr/DcRwrvG4h3ZNqmx2Zq2vasNh1VDmNPhH60FPC9gT3Owt5hNNb2q
         lqPlRS+uWkOWx0JUfL9SQ7w3iqGTuIwt1wxn0=
Received: by 10.231.35.202 with SMTP id q10mr4799708ibd.138.1286814111560;
 Mon, 11 Oct 2010 09:21:51 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 11 Oct 2010 09:21:51 -0700 (PDT)
In-Reply-To: <4CB32D15.4080204@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158776>

On Mon, Oct 11, 2010 at 15:28, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jakub Narebski venit, vidit, dixit 11.10.2010 17:18:
>> Because ./configure script enhances Makefile rather than generate it,
>> using configure script can only improve situation (at the cost of extra
>> cycles spent detecting)... well, with exception of rare cases bugs in
>> configure.ac making it misdetect.
>
> My observations on the list don't quite confirm that "configure" can
> only improve the make situation, but I don't use it myself. So, I'll let
> those give configure advice who use it.

If it doesn't improve it that's a bug that we need to fix. I haven't
seen/found any of the threads/issues in question. Would you mind
pointing some of them out, maybe the problems you cite are easy to
fix.
