From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH v2 0/2] Re: gitk: can't reload commits with new key binding
Date: Tue,  2 Oct 2012 11:04:43 -0400
Message-ID: <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
References: <7vwqzacdb7.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, szeder@ira.uka.de, paulus@samba.org,
	Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 17:05:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ41w-0005j1-2S
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 17:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab2JBPEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 11:04:54 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64255 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2JBPEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 11:04:53 -0400
Received: by ieak13 with SMTP id k13so14848778iea.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=V2+lCEV4za3H8aYNd7rZDJKdKW95LxfpgH5VxEoq7j0=;
        b=grlZyEVS6R8+iSLKsGgQqkouoEAJmr44k8/V632qFGcCdqdC2cN6mVWAV3/TxL7CHq
         gyQOYYOVDTw6pY8RRRQ97CVUdfc0yaA6ZpVHqttKuA2cG5prOL7hgOml1dvONIOv2473
         suA54ziA1x7Eso5JrNta83aEPdq6NiGE1uUngKaw3MLB5l7AvbYL87A5PppTSdk//yVv
         2umsCWqdTMtFaHzPO9cPrac4EmJ2APtlE2NIX+zaZSKDizSEvFv2SJr4U9BwYaJ4VMVl
         4P7CqvipZA/M/wgxTpXYAUfCIQPCixNy/k22XBWUqHJZv5cGFhW5e7/KODTOhOZCzwsn
         X4vQ==
Received: by 10.42.49.9 with SMTP id u9mr7505916icf.12.1349190293250;
        Tue, 02 Oct 2012 08:04:53 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id t4sm8973635igt.1.2012.10.02.08.04.50
        (version=SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 08:04:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6
In-Reply-To: <7vwqzacdb7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206801>

Refactored the code for binding modified function keys as Junio suggested.

Andrew Wong (2):
  gitk: Refactor code for binding modified function keys
  gitk: Use bindshiftfunctionkey to bind Shift-F5

 gitk | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
1.7.12.1.382.gb0576a6
