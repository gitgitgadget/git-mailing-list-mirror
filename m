From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 0/7] New sequencer workflow!
Date: Tue, 15 Nov 2011 10:46:18 -0500
Message-ID: <CABURp0qt+r09Uy_nfLd60pXiMMXgTOUB__XL-N=S7HaJa-oWoA@mail.gmail.com>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 16:46:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQLDi-0003mM-0p
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 16:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756382Ab1KOPql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 10:46:41 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44966 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336Ab1KOPqk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 10:46:40 -0500
Received: by wwe5 with SMTP id 5so6303141wwe.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eDCb48doZzqaqpOlpMklrePAI182S1wIJKCPt7xfQL4=;
        b=F2SEJwqRauEX9nYKpeW5jp6XnLDt60Ct+RE3EZQKlJKUFKIpUqlExEnYJ2KaPEc76d
         vXlForXL9w7u8dfKrfmWXQz+lRjjhKrbwhTvERWE/71MI00rIW/3dfYqeeohV+9mKYun
         mqUroErYwK9npZ648SJNez9iJQOxblpyjyzLE=
Received: by 10.216.229.84 with SMTP id g62mr329900weq.90.1321371999330; Tue,
 15 Nov 2011 07:46:39 -0800 (PST)
Received: by 10.216.61.142 with HTTP; Tue, 15 Nov 2011 07:46:18 -0800 (PST)
In-Reply-To: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185462>

On Sun, Nov 13, 2011 at 5:46 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> =A0$ git revert moo..baz
> =A0... conflict ...
> =A0$ echo "resolved" >problematicfile
> =A0$ git add problematicfile
> =A0$ git sequencer --continue
>
> In other words, it just doesn't matter how you started what sequencin=
g
> operation: you can always continue a it with "git sequencer
> --continue" and reset it with "git sequencer --reset".


I see that --reset was added to cherry-pick, revert and sequencer
around the same time back in August.  Shouldn't it be spelled
"--abort" instead?

This would align better with other commands that do the same thing
(am, merge, notes-merge, rebase) since they all appear to spell it
"--abort".  Also, it will make it easier in git 2.x when we begin
using "git continue" and "git abort" rather than "git reset".

Phil
