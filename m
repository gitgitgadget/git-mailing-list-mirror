From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/5] Trivial patches
Date: Tue, 28 May 2013 07:54:26 -0500
Message-ID: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 14:56:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJRr-0000xH-7p
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 14:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933927Ab3E1M4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 08:56:15 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:54104 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933904Ab3E1M4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 08:56:14 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so9872126oag.2
        for <git@vger.kernel.org>; Tue, 28 May 2013 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JVv4JthxZQZBOZWlmBUIT9RzDax3RrOsm3wf58MaXoY=;
        b=uZGWuPhcRfze7vS9noaL3VnCNIorIjioZL8Wg7EuJrJATJ9R5th2UcGbSMuvDor71A
         GkJA7YjqNm4bw+aHlQeIxUHcmsbsJBOQMQtgTBUJybooaCT1NuzROq/jeZ+Udj7OwXK6
         n+vHLYbXU6WY3FAY2J+1owXToKlbrAv9sIMgyGnETQ8iDvjYpW+bAFHerCDe2TOREdHK
         Y4AVCWyrAnlcpyZ8P2aVV5paj9l3vUsYaRN0L6BZbpMQUA4D9lOwf7Sjkim962wbszwR
         uPspSggRIZAFYSHxjXuhaJeH2mGsVP1qonyUCbwBiYIoNZaaHx5lFPyyv9OQMKJZy2u2
         pKdA==
X-Received: by 10.60.115.103 with SMTP id jn7mr20216616oeb.136.1369745773819;
        Tue, 28 May 2013 05:56:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wz1sm21040531obc.3.2013.05.28.05.56.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 05:56:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225633>

Hi,

Here's a bunch of trivial patches.

Felipe Contreras (5):
  remote: trivial style cleanup
  sequencer: trivial fix
  test: trivial cleanups
  test: improve rebase -q test
  test: rebase: fix --interactive test

 remote.c                      |  3 +--
 sequencer.c                   |  7 +++++--
 t/t3400-rebase.sh             |  1 +
 t/t3403-rebase-skip.sh        |  7 ++++---
 t/t3404-rebase-interactive.sh |  2 +-
 t/t3505-cherry-pick-empty.sh  | 18 +++++-------------
 6 files changed, 17 insertions(+), 21 deletions(-)

-- 
1.8.3.rc3.312.g47657de
