From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update extra!] git-remote-svn: Week 7
Date: Fri, 18 Jun 2010 20:42:09 +0200
Message-ID: <1276886531-19037-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 18 20:42:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPgWm-0007FU-Sq
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 20:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab0FRSmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 14:42:52 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:33838 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706Ab0FRSmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 14:42:51 -0400
Received: by wwb22 with SMTP id 22so400200wwb.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KgmGaOuBfZpXr37qvwNtmL6ToNpPvmzbapDpI+fy9+8=;
        b=Nb0Gncy55qZoX87JgMwdG3Azurjpe/a5e4vt8lWRxddejj2usXopxsVGUjDVIAGZBF
         orE4eHh8x6tct1u50WuL9pOFQvvNMO8TJKe4aErdhnephJwGn4dHBBM8/3smkIf3BTGB
         5NgItk/jwRDYbPDbgUej3UMnQqNDnybAoTPhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=p/lWeFFxC7KkctZ9emAaAlls6QKp/kw5C64N2oWOy1BT9/fS37CPHw1tYo2iKVxbHX
         b3SBn8rpXXwsS2IRoMqF0LqYDpNQ+L66ufQ7sM3jE0VaEeG2erphy7uVCTjjhLKCFw7R
         aln/sma7GCAEgCsE6ejSp5fuxDWK4An0gySl8=
Received: by 10.227.144.17 with SMTP id x17mr1455709wbu.4.1276886569844;
        Fri, 18 Jun 2010 11:42:49 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id b17sm9845099wbd.7.2010.06.18.11.42.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 11:42:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149357>

Hi,

I thought I'd post a quick update again this week, since there's been
some more progress. Daniel Shahaf has been awesome in helping me get
acquainted with libsvn. I've made some more progress with the client
and have gained some confidence- I should be able to complete the
"dump editor" soon, but there are plenty of ifs and buts with respect
to deltas. Hopefully, many of those doubts will be clear by next week.

-- Ram

Ramkumar Ramachandra (2):
  Add skeleton RA svnclient
  Add stripped dump editor

 Makefile       |    4 +
 debug_editor.c |  413 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 debug_editor.h |    6 +
 dump_editor.c  |  365 +++++++++++++++++++++++++++++++++++++++++++++++++
 dump_editor.h  |   10 ++
 svnclient_ra.c |  138 +++++++++++++++++++
 6 files changed, 936 insertions(+), 0 deletions(-)
 create mode 100644 Makefile
 create mode 100644 debug_editor.c
 create mode 100644 debug_editor.h
 create mode 100644 dump_editor.c
 create mode 100644 dump_editor.h
 create mode 100644 svnclient_ra.c
