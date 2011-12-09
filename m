From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/9] t3510 (cherry-pick-sequencer): remove malformed sheet 2
Date: Sat, 10 Dec 2011 02:00:46 +0530
Message-ID: <CALkWK0mEP5nDgdosOiquQ_FWbNRZesi38NeCD_yGPvJ8JQxkGg@mail.gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-7-git-send-email-artagnon@gmail.com> <20111209202449.GI20913@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:31:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ769-0003er-8R
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab1LIUbI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 15:31:08 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51820 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab1LIUbH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 15:31:07 -0500
Received: by qadc12 with SMTP id c12so879165qad.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mYO4M5G/SjIhdgJoQ+rU9eyBEpCpEl/syEAbqWMJiHU=;
        b=ERBtanCIuYXyru0l3f3BbiXsUMzqxe7y4bCMRjAhT2iEqB1e2RTWntv1BQYeyYU8Fl
         i+T3pediYSNRWsB2Ut3xn2+Ls8Ij1KGHBT91AwK3xFTcaqYVV4B6xDm3nx8W6rXyadfD
         GInHSvK0hdXfdVkTcIPUHJU7v35mIIdBO0CBU=
Received: by 10.224.180.131 with SMTP id bu3mr8628586qab.5.1323462666159; Fri,
 09 Dec 2011 12:31:06 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Fri, 9 Dec 2011 12:30:46 -0800 (PST)
In-Reply-To: <20111209202449.GI20913@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186689>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0By removing the "malformed instruction sheet
>> 2" test in advance, it'll be easier to see the changes made by the
>> next patch.
>
> So, this is a regression in test coverage without a redeeming upside
> other than allowing the next patch to be prettier. =C2=A0Naturally, I=
 don't
> like it.

Without this patch, the diffs of _all_ the future commits in this
series touching this file are totally unreadable.  I've noticed that
the diffing algorithm performs especially badly for t/*.sh -- rebasing
tests is generally a huge pain.

-- Ram
