From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: the top few commits disappeared after 'git rebase origin'
Date: Sat, 15 Feb 2014 17:40:59 +0000 (GMT)
Message-ID: <1392486059.58043.YahooMailBasic@web172304.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 18:47:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEjKx-00052o-8n
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 18:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbaBORrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 12:47:31 -0500
Received: from nm32.bullet.mail.ir2.yahoo.com ([212.82.96.57]:31745 "EHLO
	nm32.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753415AbaBORra convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 12:47:30 -0500
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Feb 2014 12:47:30 EST
Received: from [212.82.98.54] by nm32.bullet.mail.ir2.yahoo.com with NNFMP; 15 Feb 2014 17:40:59 -0000
Received: from [212.82.98.70] by tm7.bullet.mail.ir2.yahoo.com with NNFMP; 15 Feb 2014 17:40:59 -0000
Received: from [127.0.0.1] by omp1007.mail.ir2.yahoo.com with NNFMP; 15 Feb 2014 17:40:59 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 366326.24711.bm@omp1007.mail.ir2.yahoo.com
Received: (qmail 72290 invoked by uid 60001); 15 Feb 2014 17:40:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1392486059; bh=yxTYCu5vtIcGf5tcm8+ILlQD+3MHAn2H8PqbRxfncn0=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-RocketYMMF:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=3j//LnnRX7RkUftl6SlO4d+pDIXX5aOFFv/teKkZecQL61Y4MbhP+/sWFzKs16ZmO1eB8dFOAjKPOMD3tVooSXi60OhCZt1Iz3LjnRGFZHFWYPpr1iO2oCjj4C7rzUPwC+IdxnHAUAq/qziV3HxJiDzRX3sBMW11lTe/3CtDmDc=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-RocketYMMF:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IfugY3ZcA7wuwMhZ03lnLkfvrVjQbAzOF+h9snYFlbHvlCshDCtVopERVn214TYnV2IdpEJGjY52xBNSNx5kI25DZsgvWVypT6g2uj0/mqUJGXIo7TrYk3FyejIKQ7kh/HMc24gYEYMGRWD4HDvJgYGK8orguBxHljAlnI9mwAE=;
X-YMail-OSG: txMXw68VM1m.xOndOGRyOXGW3GVyek4OBjNSnoKofvkAV9I
 7fa5_WIhjNCId9Sze4V4ZiloO0uSRRzSWlMlhwnF_ysbnA1x_DV8rUtBNaxq
 zEmkKLdln2f3lw6m4_BY_7_lJJsamzBvDbUVclVQ70wyvLaGP_NT.iLTSt0P
 G2rNAb7ZQ2fR8iemQNjTRe_VPdvfYskkRG6wV1jgK1hmgY8gDVleqdQiu7U9
 33xZr_CNfoLHIV9tdLG_UXh7Ho_Lsx2RD2dQCNtzY.2MRnvpnqruxh_LPoF6
 bqHFlQpHoG7aodj_mnXKcgjZ_zAUxPUHBlcasDREYERJ0iWtlFkO5wJpFsDp
 BjmKhEIva0drPP36giJc1_AuEMva0Zwve97VzED0XDooSS0U5Z.FkbhJJw.7
 v_SviXxbw99LtOTsAxe7qaZ7t_ABPjklPYuRm.yJ6n2glAGtGE8l8URbD_HA
 CDZ0ELezGW6WRpiefCzIMYZTWNMdO9E40njhdTQDUKwyTQsYKCvkvQK4Vokc
 xs0eTA0W4kzb6k7gQHicHoHBeo6jRIAZhS.7mHYtBX.yMkV2.L3AYuoVHo2M
 -
Received: from [86.30.137.134] by web172304.mail.ir2.yahoo.com via HTTP; Sat, 15 Feb 2014 17:40:59 GMT
X-Rocket-MIMEInfo: 002.001,KEkgaGF2ZSBhbHJlYWR5IHdvcmtlZCBhcm91bmQgdGhlIGlzc3VlLCBidXQganVzdCB3b3VsZCBsaWtlIHRvIHJlcG9ydA0KaXQgYW5kIHBlcmhhcHMgZGlzY3VzcyAtIHBsZWFzZSBjYydkIGFzIEkgYW0gbm90IHN1YnNjcmliZWQpLg0KDQpJIG5vdGljZWQgb25lIG9yIHR3byBtb3N0IHJlY2VudCBjb21taXRzIEkgbWFkZSBhIGZldyBkYXlzIGFnbyBpcyBub3QgYXJvdW5kLA0Kc28gSSB0aG91Z2h0IEkgaGF2ZSBtaXMtcmVtZW1iZXJlZCBpdCBvciBmb3Jnb3QgdG8gZG8gJ2dpdCBhZGQnIChpdCB3YXMgYWQBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/424 YahooMailWebService/0.8.177.636
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242196>

(I have already worked around the issue, but just would like to report
it and perhaps discuss - please cc'd as I am not subscribed).

I noticed one or two most recent commits I made a few days ago is not around,
so I thought I have mis-remembered it or forgot to do 'git add' (it was adding some reference
notes file from somebody else). But then I saw in my bash command history that
I did all the right things so the new files must be committed somewhere.

Then I google'd, and read about 'git reflog', and indeed I did commit those
new files 3 days ago, but they were not applied after a particular rebase origin. I do a fetch/rebase
every few days, normally straight-forward without collision since I am working in some niche area
of a busy project.

Anyway, I was able to do 'git checkout -b recovery_branch <sha1_head_before_rebase>'
to recover the whole thing. This gets me a bit worried - as it is a busy project,
and I have some 20-30 local commits which are probably staying local
for my convenience for months and years, and I do git rebase all the time.

The only thing different I do this time, as far as I see, was to do 'git branch -m master master_date'
(so that I can do a cleaner master with tidied up and collapsed/refactored commits of local changes)
just before. The repo is on ext4, with a healthy amount of empty space.

The commits which disappeared were the most recent 3. and git fsck --unreachable/--dangling
/--strict don't show those disappearing ones.

I seem to remember I had a similar incident (may or may not be with a 'git branch -m currentbranch' - I don't remember)
but the new HEAD was so wrong - and essentially just a few local commits were applied -
I did a 'git checkout -b recovery_branch <sha1_from_scrollingback_to_the_last_git-log-display>'
and just forgotten about it soon.

Any idea how this might happen, and perhaps make sure it does not happen again, ever?

By the way, this is all essentially on fedora x86_64 linux.
$ git --version
git version 1.8.5.3
