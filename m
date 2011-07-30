From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] rebase -i: interrupt rebase when "commit --amend" failed
Date: Sat, 30 Jul 2011 13:52:17 +0200
Message-ID: <CAGdFq_in9huck5kGo5N00jF53B2USsHy_CXb914jZrMZ4HpTUg@mail.gmail.com>
References: <1311565113-5022-1-git-send-email-andrew.kw.w@gmail.com> <1311565113-5022-3-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 13:53:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn86T-0006vZ-B4
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 13:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab1G3Lw7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 07:52:59 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41401 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab1G3Lw5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2011 07:52:57 -0400
Received: by pzk37 with SMTP id 37so7965613pzk.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 04:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wZMi4MDevVIUKid5sYF/swfZxg3Rloh57ri4+BlzmNA=;
        b=Fg2rB6SdFhhB1FvaWBNt1qAVA1TT56+m+z2g71AsfkZ7F0G3/Ply8qHqXEw4W8zYLo
         gMy84pv8D1uhnCEqAnjUguIsJDKlb9tyJuplNFNGjLZdwzCvPCgApcssPtFlIu2S/xfZ
         55XzoN+wQ+Nb8BRIAawVl8dphW2a/ZMr1xYiI=
Received: by 10.68.28.106 with SMTP id a10mr4485434pbh.176.1312026777067; Sat,
 30 Jul 2011 04:52:57 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Sat, 30 Jul 2011 04:52:17 -0700 (PDT)
In-Reply-To: <1311565113-5022-3-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178189>

Heya,

On Mon, Jul 25, 2011 at 05:38, Andrew Wong <andrew.kw.w@gmail.com> wrot=
e:
> "commit --amend" could fail if the user empties the commit message.
> Although this is not a real error, it seems to make more sense to
> interrupt the rebasing, rather than ignoring the error and continue o=
n
> rebasing. =C2=A0This gives users a way to gracefully interrupt a "rew=
ord" if
> they decided they actually want to do an "edit", or even "rebase
> --abort".

Yesplease. I've had this where I marked an entire patch series for
reword only to discover on the first patch that I made a mistake, so I
ended up having to type ":wq" some twenty times. It would have been
much nicer if I could just have done ":cq" once and then 'git rebase
--abort'.

--=20
Cheers,

Sverre Rabbelier
