From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] transport-helper: general fixes
Date: Wed, 10 Apr 2013 19:07:10 -0500
Message-ID: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 02:08:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ53w-0000sA-Ms
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 02:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937730Ab3DKAIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 20:08:18 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:53585 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937299Ab3DKAIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 20:08:16 -0400
Received: by mail-qa0-f47.google.com with SMTP id hu16so3934qab.6
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 17:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=2dz0e6F6eKE0Od4XBDdBe4F9J5XSSi2KGoRghbOvmBE=;
        b=f1+wWcL6VtFvBs4hbKDAFwtBjIrUAW8CwqBvf+q89JztglPuf3yYrQKfoGn5XjijNw
         giHZtRN2buwaK55D2loGUT3jzIm2HxeK9N2pPeX4jYe6X19Ex8lCUyjsnfa0+UfKSSa1
         g/2AB5Ybu1sfxCn9TkxIJmhWIgQu+ucbIOp/PudSv/2U/xI4memjgMLkURzH8f2yw2t7
         gjkRh/CXfUyh4rY4AcYn4H41f98741c3HO/4QGzr2YtuRznvCShmkcFOEfyZqkXxWwo0
         nC9TKM3AZjg9mpzEVqi308hDQ5wJBHaoB95AAdnVY/vz0A3bouok3ecGQZfJE/2qHUu8
         5pxA==
X-Received: by 10.49.64.72 with SMTP id m8mr5368481qes.51.1365638895247;
        Wed, 10 Apr 2013 17:08:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id hm4sm4051278qab.2.2013.04.10.17.08.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 17:08:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220796>

Hi,

Here are a couple of patches that fix a few problems with remote-helpers.

Felipe Contreras (2):
  transport-helper: improve push messages
  transport-helper: update remote helper namespace

 t/t5801-remote-helpers.sh | 26 ++++++++++++++++++++++++++
 transport-helper.c        | 24 ++++++++++++++++++++----
 2 files changed, 46 insertions(+), 4 deletions(-)

-- 
1.8.2.1
