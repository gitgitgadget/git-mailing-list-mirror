From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH] The SVN RA client, finally
Date: Wed,  2 Jun 2010 15:08:35 +0200
Message-ID: <1275484116-32520-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 15:07:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJnfL-0001Mv-Pl
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 15:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890Ab0FBNHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 09:07:19 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:49775 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab0FBNHS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 09:07:18 -0400
Received: by ewy23 with SMTP id 23so623455ewy.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YsJ+pA2Ssd9G+MmYnUw74BqzVxun4BdM56p6VvxBw6Y=;
        b=deWXKbYeHc4N+/I8ZZvxRQhQRl5dNOSjzRHDpidXtpmneKQD1sm4bBwQBc0CqFMJdY
         hiJEVxfTvcloncJno2ajD1zokblyrnYkpSOH/ayAjXRA+rNq7ORzTii+eIYEzUzvbG9e
         4jFTtVsWWPyTdzJ07sNbP8NLN1Gi3eeg0NRyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=i+cnJeieAtdix9G+t3PVCYH3YTOd+5LeNfmnLrDPZV5TO4jAzPpL9vyrbrxW0XpREK
         +a+LJqM3z6GbulIso6azFOkwTLBOFCUxDQ0r1RB+n+wAZL/hF2BbU2EbfXP3QFaoFokp
         V7p5ZlXHGU38R2WTg5PkpqRsgsptMQeyieHdM=
Received: by 10.213.105.138 with SMTP id t10mr2037160ebo.21.1275484036813;
        Wed, 02 Jun 2010 06:07:16 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id 13sm4398619ewy.9.2010.06.02.06.07.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 06:07:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148251>

The skeleton SVN RA client currently looks like a stripped-down
version of svnsync. It was admittedly very time-consuming and
frustrating to get this far: Hopefully, the actual dumping won't take
too much longer. I've also provided a small Makefile to build and test
this.

Note that I'm developing this on my fork of svn_dump_fast_export, not
on my fork of git.git.

-- Ram

Ramkumar Ramachandra (1):
  Add a skeleton RA SVN client

 Makefile       |    2 +
 svnclient_ra.c |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 Makefile
 create mode 100644 svnclient_ra.c
