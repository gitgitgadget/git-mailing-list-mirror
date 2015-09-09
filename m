From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCHv1 0/2] git-p4: work on a detached head
Date: Wed, 9 Sep 2015 14:03:41 +0200
Message-ID: <6B07CAFE-6A10-481A-9D15-0DBFF6AB0B11@gmail.com>
References: <1441461738-25066-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 14:03:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZe6Q-0005ab-2R
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 14:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbbIIMDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 08:03:47 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37470 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbbIIMDq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 08:03:46 -0400
Received: by wicfx3 with SMTP id fx3so18996477wic.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 05:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jlPBNeKSfk8sFpYY8ugNlkDl7c+3KgAHWtvsyEAPfbc=;
        b=CwqMVgbdGBegyPsWrL5pIO3lgYNl0f4prG/wslkhsXpNGyTnvt57Zehm2jHoWin/bp
         xpOz3MA/Lt/YQIPIYtv4QPgHMMRHj5rjRRZVjCyv3WFRCwmc17pXP1OeH1d+NjVRp0yv
         D3Y6fQFAbza5A3clGlLtdMZtxbrbpLkavWKMHy9/6kOnxne9TMfxVJr1BeGFJ5+uId3n
         cx3GbGoVfBzIF+Lp6jtaNGEcdnPnFNC/dRhQbQQUwMS0cpscEK9XK+W72gZWsgdSfFtT
         HJ3U2JiRpVDHReGAsScJCrwooNsfph1+4FlO+jEF+pr/fuU0cSjV2zST5AO6Cot2U+Kk
         BnZQ==
X-Received: by 10.180.108.35 with SMTP id hh3mr52676671wib.48.1441800225013;
        Wed, 09 Sep 2015 05:03:45 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id wo2sm9931864wjb.2.2015.09.09.05.03.43
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Sep 2015 05:03:44 -0700 (PDT)
In-Reply-To: <1441461738-25066-1-git-send-email-luke@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277553>

I wanted to play with the patch and apply it to my source but the proce=
ss is really complicated for me. I wonder if you can give me a few reco=
mmendations how to work efficiently with email patches. I don=92t want =
to start a flame-war about what email client is =93right", I am just cu=
rious how you work and what clients, scripts, or tricks you use :-)

Usually I use Apple Mail. I experimented with mutt but it was not drama=
tically more convenient.

Thanks,
Lars

On 05 Sep 2015, at 16:02, Luke Diamand <luke@diamand.org> wrote:

> git-p4 won't submit from a detached head. If you do, it gives a
> cryptic error message, and instead you have to create an endless
> series of throw-away branches, which can get very trying.
>=20
> The first patch in this series demonstrates the problem, and the
> second patch fixes it. I've been using it for the last few days.
>=20
> Luke Diamand (2):
>  git-p4: add failing test for submit from detached head
>  git-p4: work with a detached head
>=20
> git-p4.py               | 18 ++++++++++++------
> t/t9800-git-p4-basic.sh | 16 ++++++++++++++++
> 2 files changed, 28 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.6.0.rc0.133.ga438a11.dirty
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
