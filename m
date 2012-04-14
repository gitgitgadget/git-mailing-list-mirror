From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/5] completion: trivial cleanups and fixes
Date: Sun, 15 Apr 2012 00:42:59 +0300
Message-ID: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 23:43:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJAkz-0001wi-Lu
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 23:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab2DNVng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 17:43:36 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61618 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab2DNVng (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 17:43:36 -0400
Received: by lbbgm6 with SMTP id gm6so3219309lbb.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 14:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Uc4gmshr6Sy9o7neQQ8fNwoyQICQG85ngYzisY3smCM=;
        b=zQDRnJZA2Q/lzJShc07TKLbrQ9TxvsFHlq/HlOoIdIE9ziCpaoEc1K3gb2xUF6FVKx
         6lFvWthFVhZaF/rxJWYxH1FN3S49h46QUiq9BbtMB2Fc/CVmvAXqNvLgXsIxVRWpRnyB
         IKIlBZOqA+5e8FRJgiFOILQMW9qXwc6HELD2Gjw3i3L8jRtSqHbpuNy45xoelNCU5hDq
         rFbwMLJxLqXd6v6Cf+70h+fz3zrIFSHd8EPaOzFWAvg8IFhD37Rq9rylp1tE/Lp3dPIy
         jfkZZ/2GGQiGmwyf9ISd3KRgTaUWWmKzlARwgpPOXAauQACW7OpAe1jIuo4BjMg4Hh48
         bLng==
Received: by 10.152.105.19 with SMTP id gi19mr5688961lab.11.1334439814665;
        Sat, 14 Apr 2012 14:43:34 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id sv9sm13936298lab.10.2012.04.14.14.43.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 14:43:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195518>

Hi,

Just a few simpliciations, improvements, and add some missing options.

This series depends on the bash completion tests patch.

Since v2:

 * Add 'git --option <TAB>' fix
 * Improve --exec-path patch

=46elipe Contreras (3):
  completion: simplify __gitcomp_1
  completion: trivial simplification
  completion: add missing general options

Jonathan Nieder (1):
  completion: avoid trailing space for --exec-path

SZEDER G=C3=A1bor (1):
  completion: fix completion after 'git --option <TAB>'

 contrib/completion/git-completion.bash |   18 +++++++++------
 t/t9902-completion.sh                  |   38 ++++++++++++++++++++++++=
++++++++
 2 files changed, 49 insertions(+), 7 deletions(-)

--=20
1.7.10.1.g1f19b8.dirty
