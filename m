From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] remote-hg: trivial fixes and cleanups
Date: Fri, 10 May 2013 05:16:59 -0500
Message-ID: <1368181023-10402-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 12:18:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UakPQ-0001UR-2c
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 12:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953Ab3EJKSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 06:18:34 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:45526 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab3EJKSb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 06:18:31 -0400
Received: by mail-ob0-f180.google.com with SMTP id xk17so1812291obc.25
        for <git@vger.kernel.org>; Fri, 10 May 2013 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=gG0qQcaThfro9Co8j8aBUpT1sVRSWnh2zb7A0L1hhqY=;
        b=dnf58jaGeEfJlGn2ZUeF8eAi2XLUQKF5UuQa8mh/IiLyEia+KjsZWN/PmV4dKKBG2m
         SckoVaSNF+bknJVlbypyatQsIfTryrKQk+zIknxXlsqqkInOaCE+poc2kluJ7LJL7sa8
         lr5XjrAzdaCFZGYe3omrGNADUzXLkkEmJNoO9y+TaSN9uVJYVHw+zN8R5K6F6Z9hh/0a
         sI7OT4osKJQFaZlrhZV+3fGb03Pw3vdyYvmy4NH3PS4qvSOtEfIx5cOFn4lMbwp47ZOE
         y8ez4ySXeBNnf2v9rQ67/S7A8miZE2PIn6XewylTzGFaIfgBmCUqFzBq6gIMiTf8aEuv
         22ZQ==
X-Received: by 10.60.149.129 with SMTP id ua1mr6726612oeb.56.1368181110816;
        Fri, 10 May 2013 03:18:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h8sm2123739obk.10.2013.05.10.03.18.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 03:18:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.555.gd13b5a0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223826>

Hi,

Simple no-brainers.

Felipe Contreras (4):
  remote-hg: don't push fake 'master' bookmark
  remote-hg: update bookmarks when pulling
  remote-hg: test: be a little more quiet
  remote-hg: fix new branch creation

 contrib/remote-helpers/git-remote-hg | 7 +++++--
 contrib/remote-helpers/test-hg.sh    | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
1.8.3.rc1.555.gd13b5a0
