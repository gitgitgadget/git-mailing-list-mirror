From: "St. Blind" <st.s.blind@gmail.com>
Subject: Question on for-each-ref and --contains
Date: Tue, 23 Dec 2014 09:50:50 +0200
Message-ID: <CA++b5FaiKC2+U-Q_q7tBBjX2s+rLY6725H2ScUW26eOf-nmRjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 08:50:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3KF7-0003Ze-My
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 08:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbaLWHux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 02:50:53 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56991 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbaLWHuw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 02:50:52 -0500
Received: by mail-lb0-f180.google.com with SMTP id l4so5010508lbv.11
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 23:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=UGAKeFJYfyv9k/V6xNotaecjIM4UItUF4+Nx32snG9g=;
        b=czudJuGYe8oAehr2pJXy2mIqca75I4UCr3sz+SXWRUI2G3xRZuNM6GLuTgIOkj45zB
         DAMtQ0d2h00Rmv8rK5k94CVjg1hYQwBYSUfVXMEH72f0UKP4ld48fCNPDjntts8zf7JG
         6Lw1YEII2E0YNC0Oae/iVJr4xG1LuuQxHuOJonoYziYroc8X4x6NsizCRIpwbPY1oo/n
         89GFgMZ/uh5pptoz7eOgs4/wav21Q4vTitOUwpvhxfqDs2lhwJJEQNqUBK88VFl4ot0C
         m1MJLBw4lTQCe4GZxEWAllajj6LZvd9KLMF+WtlRVwtDSkDY5UKoveQKdAI4o2jexDro
         0Hkg==
X-Received: by 10.152.3.195 with SMTP id e3mr26087267lae.8.1419321050786; Mon,
 22 Dec 2014 23:50:50 -0800 (PST)
X-Google-Sender-Delegation: stoycho.sleptsov@gmail.com
Received: by 10.112.133.194 with HTTP; Mon, 22 Dec 2014 23:50:50 -0800 (PST)
X-Google-Sender-Auth: DzrfBn-S8oCwcUB-7AmzXpyOJic
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261715>

Hi.

In order to make some analyses here I had to build certain report
lists of our remote refs, based on various "containing" and "merged"
rules. We have more than hundred such refs at a time usually. So my
poor script which tries to make decisions with the help of rev-list
for each ref on each arbitrary commit is not really fast. The
git-branch --contains and --merged are not very handy too, because the
output is not really flexible, and the --merged works on HEAD only.

Do you think is a good idea to have the option "--contains" in
for-each-ref too (and/or in rev-list directly)?
If yes, then probably also the --(no-)merged options, but hopefully
with the arbitrary commit this time?

Thank you in advance,
Blind.
