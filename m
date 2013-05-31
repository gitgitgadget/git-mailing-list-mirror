From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 0/6] New git-related helper
Date: Fri, 31 May 2013 02:37:38 -0500
Message-ID: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:39:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJw1-0008Ec-KO
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151Ab3EaHja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:39:30 -0400
Received: from mail-ye0-f172.google.com ([209.85.213.172]:49993 "EHLO
	mail-ye0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3EaHj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:39:28 -0400
Received: by mail-ye0-f172.google.com with SMTP id m15so296986yen.17
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=RmcKZAJHOt4GauDcy5s0jR6KwJtdIthpbP5GGQliBmU=;
        b=nEmldZ6YHknaO6ayR/6p2XisKb241qKFBDDTDl9t1b981YS6wpoiOBriWCdsLInPFN
         9TXzqpO6Xq/YBHag1ZuxCShPP32zaBaC3hWrsOnsa6y2PPZe0GaiolvVLiNMo8g9OKjo
         SQIm2OASuClqZK9rUJgJMI3SOXjTirmdFBWG+gGR5EyPMWBtLcHQX4c/TvzBrxF+oKUs
         kCYszZLEZ51RNNdulySx2s5I9LXJk7sjxKQJT7BRgvL18cQDbjUV4mGpyz+6WjbPZQFr
         x3ub6lVSCKeyzYL92YTdXafSdvpqQLaFvFvstCIBGphIh2uvpurp7ZfADs8858iqGTxX
         B0Rg==
X-Received: by 10.236.179.72 with SMTP id g48mr6266931yhm.23.1369985968108;
        Fri, 31 May 2013 00:39:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id j20sm18431357yhi.1.2013.05.31.00.39.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:39:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226058>

Hi,

Since there hasn't been any comments of importance this is basically the same
as v7, plus a few other patches to make it actually usable (for me).

Unfortunately it turns out Ruby's optparse is not suitable for our needs, so I
implemented a very small parser that is.

Felipe Contreras (6):
  Add new git-related helper to contrib
  contrib: related: add option parsing
  contrib: related: add support for multiple patches
  contrib: related: add option to parse from committish
  contrib: related: parse committish like format-patch
  contrib: related: implement custom option parser

 contrib/related/git-related | 247 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)
 create mode 100755 contrib/related/git-related

-- 
1.8.3.358.g5a91d05
