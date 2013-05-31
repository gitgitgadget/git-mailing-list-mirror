From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [RFC] reflog: show committer date in verbose mode
Date: Fri, 31 May 2013 09:52:15 +0800
Message-ID: <CANYiYbG0Wy1kL7p6GfzBxfTGFJon21Ob5VVno=N5Wf2vqwxchA@mail.gmail.com>
References: <c05d3472f28695a10154cda8ed2c973baf5e20b7.1369964641.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 31 03:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiEVx-00058E-AF
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 03:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab3EaBwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 21:52:18 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:38913 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab3EaBwQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 21:52:16 -0400
Received: by mail-wg0-f45.google.com with SMTP id n12so797049wgh.12
        for <git@vger.kernel.org>; Thu, 30 May 2013 18:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kW5ReG5bnbFcIv7YXR4gpgK96bRPnEuuMZPEfZu6VeY=;
        b=UuQqCnXVZFGdTde2/24KwyhtJdFvHXa3XPR3lXIB68kNMyOP08IxQfUVPWsL7zFyaf
         nl5oji3JgSirck5Bdd1nFkumbgicFiZfBReDQKrzNv0P7/DpJXbsusiaqa2LEf8EvlYc
         0sV72mF3TrA4XW2nFr776nuPCynCNgPmholig+6BNb2Si1COCDcBiT0upZMfDw1jaTXu
         3OB1XElt3vzpbDpV+Rkjd1iwsyuEzCn4KN1RsymiKQgViEhIzn0Zv/k80itYj74fKM52
         UHvEW7ybjUWQO7d/qh45BWNsL0SmTb3TjkthVueXYuJjGIRUDzjZ+ma1GlbRY5XPckTo
         x5Ow==
X-Received: by 10.180.9.80 with SMTP id x16mr1048560wia.63.1369965135348; Thu,
 30 May 2013 18:52:15 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Thu, 30 May 2013 18:52:15 -0700 (PDT)
In-Reply-To: <c05d3472f28695a10154cda8ed2c973baf5e20b7.1369964641.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226044>

2013/5/31 Jiang Xin <worldhello.net@gmail.com>:
> By default, reflog won't show committer date and for some cases won't
> show commit log either. It will be helpful to show them all by passin=
g
> a more complicated pretty formatter to `git reflog` like this:
>
>     $ git reflog show \
>       --pretty=3D"%Cred%h%Creset %gd: %gs%n  >> %Cblue%ci (%cr)%Crese=
t: %s"
>

=46or example:

$ git reflog show master
edca41 master@{0}: merge kernel/master: Fast-forward
5e49f master@{1}: merge kernel/master: Fast-forward
de3a5 master@{2}: merge kernel/master: Fast-forward
0c2b1 master@{3}: merge kernel/master: Fast-forward
b387c master@{4}: merge kernel/master: Fast-forward
9b795 master@{5}: merge kernel/master: Fast-forward
4dcdc master@{6}: merge jx/zh_CN: Fast-forward
a09ab0 master@{7}: merge de-ralfth/master: Fast-forward
674c5

$ git reflog show -v -v master
edca41 master@{0}: merge kernel/master: Fast-forward
    >> Fri, 24 May 2013 11:34:46 -0700 (6 days ago), by Junio C
Hamano: Git 1.8.3
5e49f master@{1}: merge kernel/master: Fast-forward
    >> Tue, 21 May 2013 09:33:24 -0700 (9 days ago), by Felipe
Contreras: remote-hg: fix order of configuration comments
de3a5 master@{2}: merge kernel/master: Fast-forward
    >> Fri, 17 May 2013 12:19:20 -0700 (13 days ago), by Junio C
Hamano: Git 1.8.3-rc3
0c2b1 master@{3}: merge kernel/master: Fast-forward
    >> Wed, 15 May 2013 14:58:56 -0700 (2 weeks ago), by Junio C
Hamano: Merge branch 'fc/remote-hg' (early part)
b387c master@{4}: merge kernel/master: Fast-forward
    >> Thu, 9 May 2013 13:32:54 -0700 (3 weeks ago), by Junio C
Hamano: Sync with v1.8.2.3
9b795 master@{5}: merge kernel/master: Fast-forward
    >> Tue, 7 May 2013 22:50:05 -0700 (3 weeks ago), by Junio C
Hamano: Update draft release notes for 1.8.3
4dcdc master@{6}: merge jx/zh_CN: Fast-forward
    >> Wed, 8 May 2013 08:13:32 +0800 (3 weeks ago), by Jiang Xin:
l10n: zh_CN.po: translate 44 messages (2080t0f0u)
a09ab0 master@{7}: merge de-ralfth/master: Fast-forward
    >> Tue, 7 May 2013 19:28:19 +0200 (3 weeks ago), by Ralf Thielow:
l10n: de.po: translate 44 new messages
674c5 :
    >> Wed, 1 May 2013 19:49:18 +0800 (4 weeks ago), by Jiang Xin:
Merge remote-tracking branch 'vi-vnwildman/master'


--=20
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 18601196889
