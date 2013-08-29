From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] stage: proper 'stage' command
Date: Thu, 29 Aug 2013 13:09:02 -0500
Message-ID: <1377799744-5201-1-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6jD-0000Kp-Nn
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481Ab3H2SNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:13:48 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:59883 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224Ab3H2SNq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:13:46 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so860064obb.2
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EvFeC7u4dw1+T/vl7vNNAGt9x48o85KCQsMNGy/M6Zg=;
        b=uqwdi87cWGAP/43jqH7py47D68Oa07aJ8+FPQPQTB1iKVZnQRh4Moj4EEh3FcBaWSh
         Vet53uA4YJvfalPn0NHSHR1v3eKh+BRjExqIljTmZ4BEs5RXuznnrvK6zsjGZQaZAKkm
         x27sXh1kEyx0wZDt6Ong7R0KQsooPMvWvt5TlvNdDV3EAdNmknVqRgEw3Br+yRMfurbq
         yZCMSw3n0YY6NzLlHNNl46vsoEtIMFc+SvYsMeA6DqLQk0rBDYhGBiEjP+e2WVjvKn0d
         cPk5zmnFuX/t3l8+m7Ka7CUjvW34P1Q+QlO3FrwVUk4nuwqD4LpqgaVUjJU3BG6rbjjE
         D/xg==
X-Received: by 10.60.124.195 with SMTP id mk3mr2641721oeb.54.1377800026216;
        Thu, 29 Aug 2013 11:13:46 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm33726432oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:13:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <20130829180129.GA4880@nysa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233304>

Hi,

The first patch adds subcommands for the 'git stage' command; add, reset, diff,
rm, apply. By default the add command is used, so 'git stage $file' remains the
same.

The second patch adds the incredibly useful 'git stage edit' command.

Felipe Contreras (2):
  Add proper 'stage' command
  stage: add edit command

 Documentation/git-stage.txt            |  50 +++++++++++--
 Makefile                               |   2 +-
 builtin.h                              |   1 +
 builtin/stage.c                        | 126 +++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  26 ++++++-
 git.c                                  |   2 +-
 6 files changed, 199 insertions(+), 8 deletions(-)
 create mode 100644 builtin/stage.c

-- 
1.8.4-fc
