From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [GSoC 11] submodule improvements
Date: Sun, 8 May 2011 14:05:38 +0200
Message-ID: <20110508120538.GA19074@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 13:52:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2Xc-0000pa-QM
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 13:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab1EHLwr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 07:52:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50137 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1EHLwq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 07:52:46 -0400
Received: by bwz15 with SMTP id 15so3395200bwz.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:subject:message-id
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=jZGfvKcjJo4Gg0+AmLnWVczKgXm9l8XYAvalOfws+O4=;
        b=pNQAMoX+FRRhc6mtVN9O9Ges47Ec8B8rW8RKRDhAHYh5jUhccK8+oMMiIeBNLcHcNh
         7MHSt3kuzWUYe7w9fcbmPNrJKVUy/Hw4UnvFSrOndySprnIjLDLUhGs0oXmeuR5/3TNw
         rsXNBl1BY0hrm8kwxuic3ZmSh82lQ9ODQdHbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=rfDwpUK8N+jMrJW0Z182i9k4dO004Nonhu6cfwwGWBFMkuVfxE7mk9qIyFIxgG9fOw
         788DHCaUeoeLxkXSF568fR2nhrdHqvIHMdmmTMT20ZJCMy6GWjPvi2l/5QX4dJbD/Nyv
         jvLI4l2Nbzz/SatPRavkV5u/FXKjyEx6xvg5U=
Received: by 10.204.14.204 with SMTP id h12mr4885885bka.78.1304855565109;
        Sun, 08 May 2011 04:52:45 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id 16sm3045905bkm.18.2011.05.08.04.52.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 04:52:43 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1QJ2jy-000568-IR
	for git@vger.kernel.org; Sun, 08 May 2011 14:05:38 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173095>

Hi,
I've been chosen to improve git submodules during the summer. My main
focus will be to move the .git-directory away from the submodules so
that submodules can be deleted and created in the working tree [1].

I will post updates on this list labeled [GSoC 11 submodule] for those
interested in following my work. I've also put up a fork of Junios repo
on github, where you can find my [2] branches.

My name is Fredrik Gustafsson, I study electronics with a software path
in Lund, Sweden.

My schedule is a bit strange because of the Swedish semesters, so my
work will begin tomorrow (Monday).

I'm looking forward to work with my mentors (whose already been very
supportive) and the rest of the git community.

[1] My proposal:
http://www.google-melange.com/gsoc/proposal/review/google/gsoc2011/iveq=
y/1

[2] Github-page
https://github.com/iveqy/git
--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
