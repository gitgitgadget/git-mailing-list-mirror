From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 0/5] Updates for git-http-backend
Date: Sun, 25 Oct 2009 14:05:30 -0400
Message-ID: <1256493935-8680-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 19:04:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N27ST-0006tm-G3
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 19:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbZJYSEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 14:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbZJYSEU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 14:04:20 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:28831 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbZJYSET (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 14:04:19 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1667665qwb.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bZI4ecFx1VhmaFdvHkboTxGfQk5jaV7Hhhl+zV8RLbE=;
        b=fHuE7CBkaTbYe9IK4Hs30SPRLYzwAS638iFTYH8TkYGbKos4iN5jBk7sRmjmknMehE
         TdJqacPPF19n8lqReImqMKpvu208GUXoRdE57NqoRUnr9V+J7uiPWm/GlNJG0DuIgLAe
         62rZssYlMKhmvawOF3Fbqkd7rHhAjqs9TKeC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=C7l35wkynRQvlzUN+zGp4TspFWcwmQtD0v438o0/dPLP3T6rYaAOBEkFqdFeaVCfuR
         SzaJnkVVmBhPMoXk7vgWmeWy7gMLFdToHIpBrBO27VuRPq2yB7uWfzUc3TbOleDnqYTV
         kD8lPZ9jTLeNVNkxCIUbazhV6fQan/SBhcjE8=
Received: by 10.224.12.195 with SMTP id y3mr6761012qay.34.1256493864168;
        Sun, 25 Oct 2009 11:04:24 -0700 (PDT)
Received: from localhost.localdomain (c-68-33-182-150.hsd1.dc.comcast.net [68.33.182.150])
        by mx.google.com with ESMTPS id 7sm13930120qwf.46.2009.10.25.11.04.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131228>

This patch series applies to pu.  It adds a GIT_PROJECT_ROOT environment
variable, which makes git-http-backend much easier to configure, and it
updates the documentation to add more useful examples and to clarify some
things.

I originally posted this same series as a single patch in one of the replies
to Return of Smart HTTP.  Here, I'm posting it as a set of proper series of
patch, each of which is a unit and has a proper signed-off-by line.

Mark Lodato (5):
  http-backend: add GIT_PROJECT_ROOT environment var
  http-backend: reword some documentation
  http-backend: use mod_alias instead of mod_rewrite
  http-backend: add example for gitweb on same URL
  http-backend: more explict LocationMatch

 Documentation/git-http-backend.txt |   94 +++++++++++++++++++++++-------------
 http-backend.c                     |   25 ++++++++-
 2 files changed, 83 insertions(+), 36 deletions(-)
