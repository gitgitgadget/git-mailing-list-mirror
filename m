From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v8 0/11] Create ref-filter from for-each-ref
Date: Sun, 14 Jun 2015 01:04:22 +0530
Message-ID: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 21:36:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rE8-0001FN-Lt
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 21:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbbFMTeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 15:34:44 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36013 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbFMTen (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 15:34:43 -0400
Received: by oial131 with SMTP id l131so5161759oia.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=H591UVNAgbyIEmVZrpNQbFOFJA6h2h8KNcKcBp04vqg=;
        b=X6sFCNWKJkPo8NWdS1CimnS7LoJOGR3QPJ4zUV4BEofOTuJUacthA0wwOoYOJ1XA/e
         GbBayjSortPKEs8qIKNl8juwAxQqSTmJ84aUVIWre+JCJwNa1m9KCN93SrWg4aPMt9zZ
         1b2MykQgoBode7nKLeeLaXE/RrXP80Yid8LnVe9TU5zg8EM4LeoS3O7vyIsTtdTFl+Ak
         Um7oxD8DPFx3or8tyicgZG+NR7ovb7jByjPZ64MZv6bdbn4uTIPVH4A1DQUzIJ5664o+
         xC+UyYjdOAP3/Po05hah0b0ewXTMOgGEEhvA6CjkqB7yQfz3nsxoojjUZVO+DNg0Mwq+
         5Rmg==
X-Received: by 10.60.58.136 with SMTP id r8mr17511890oeq.30.1434224082490;
 Sat, 13 Jun 2015 12:34:42 -0700 (PDT)
Received: by 10.182.28.5 with HTTP; Sat, 13 Jun 2015 12:34:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271563>

The previous version of the patch can be found at :
http://thread.gmane.org/gmane.comp.version-control.git/271423

Changes :
* Removed an unnecessary commit (v7 3/12)
* Change a comment in 01/11 (v8)

Total changes :

 Makefile               |    1 +
 builtin/for-each-ref.c | 1108
+++-------------------------------------------------------------------------------------------------------------------
 ref-filter.c           | 1101
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ref-filter.h           |   74 ++++++++
 4 files changed, 1195 insertions(+), 1089 deletions(-)

-- 
Regards,
Karthik Nayak
