From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 0/3] fast-import: add a new option command
Date: Thu, 13 Aug 2009 09:53:44 -0700
Message-ID: <1250182427-17841-1-git-send-email-srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbdga-0006OQ-Rm
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 19:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbZHMRBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 13:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbZHMRBs
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 13:01:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:30541 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbZHMRBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 13:01:47 -0400
Received: by rv-out-0506.google.com with SMTP id f6so287012rvb.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=I/9kE2QN/5JNs5FltQd98/UTf65pw1dKCMO7quaiNDI=;
        b=JrqKfTHXZAtI8fyu8sjbLofgXjitqPZYMD8LTmO+QN/rpcN7WK5O4XbMNX6JQwYQKM
         l5I/X3N8rm9At7Vwf39HEpOWjW9lz7zCVjBTKm/e6+HtZi3YGsinuBzSzfZRR0ijNM8N
         9dBpySiwzvHi7XQjfRQX3ciDL2QbVbkZp7dic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=heP75iPHnCWhXHkTNoG5vSZ3d/HdTcK5FGeQxebahW/XswpVx2la1NFjj4UYZoLCwp
         HjTguOgoJofMAMgBlU84nO0IP9d/poZ91CYqI4sELdb2Ahq45FiZCTZ2JWlX7Pu/DoAX
         KfenNV/tmm1VfE3dm+kq/qi5pLrfhUCdOJoPQ=
Received: by 10.140.144.20 with SMTP id r20mr574967rvd.274.1250182440462;
        Thu, 13 Aug 2009 09:54:00 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id c20sm2423242rvf.31.2009.08.13.09.53.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 09:53:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125837>

v2 addresses concerns by Shawn and Dscho.

Sverre Rabbelier (3):
      fast-import: put option parsing code in seperate functions
      fast-import: add option command
      fast-import: test the new option command

 Documentation/git-fast-import.txt |   23 +++++
 fast-import.c                     |  167 ++++++++++++++++++++++++++-----------
 t/t9300-fast-import.sh            |   38 +++++++++
 3 files changed, 180 insertions(+), 48 deletions(-)
