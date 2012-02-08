From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCH-master] tag: add --points-at list option
Date: Wed,  8 Feb 2012 15:03:42 -0800
Message-ID: <1328742223-24419-1-git-send-email-tmgrennan@gmail.com>
References: <20120208205857.GA22479@sigill.intra.peff.net>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 00:04:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvGYR-0003d8-Jp
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 00:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433Ab2BHXDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 18:03:54 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:35956 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757462Ab2BHXDy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2012 18:03:54 -0500
Received: by obcva7 with SMTP id va7so1428149obc.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 15:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EzAtKQK9yrnmQyYwksSrRk2MDAKUTM8W8Vfij22K6R4=;
        b=echQkuYKtuDD5oZlzLaYiAuQnCW+1Y4s/H1zUp45vJloC1RULF2JWHxMIXMmAm0qA0
         uVLp26z6MPXurddzGLPsidQjVF2B3c2jzIqnmGfsodxYVDwJc9E/fT+AUjscc3a3S8Rk
         ZWqPDDtqiOVFYQVx3ylv/C3WsagDsjckSHf34=
Received: by 10.182.0.106 with SMTP id 10mr27618010obd.72.1328742233471;
        Wed, 08 Feb 2012 15:03:53 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id s6sm886257obq.0.2012.02.08.15.03.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Feb 2012 15:03:52 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <20120208205857.GA22479@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190263>

The following applies the "points-at" feature to master and includes unit tests
from Jeff King <peff@peff.net>

Tom Grennan (1):
  tag: add --points-at list option

 Documentation/git-tag.txt |    6 ++++-
 builtin/tag.c             |   50 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t7004-tag.sh            |   39 +++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 2 deletions(-)

-- 
1.7.8
