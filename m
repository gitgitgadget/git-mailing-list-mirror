From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 0/4] core.ignorecase
Date: Sun, 11 May 2008 18:21:25 +0200
Message-ID: <1DDA0924-E726-4D3A-B936-D08678E9827A@zib.de>
References: <1210522602-4724-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 18:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEJ5-0001cM-5O
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbYEKQVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754716AbYEKQVD
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:21:03 -0400
Received: from mailer.zib.de ([130.73.108.11]:62894 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754603AbYEKQVA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 May 2008 12:21:00 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m4BGKrMt005010;
	Sun, 11 May 2008 18:20:53 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db97dd2.pool.einsundeins.de [77.185.125.210])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m4BGKgNA020759
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 May 2008 18:20:52 +0200 (MEST)
In-Reply-To: <1210522602-4724-1-git-send-email-prohaska@zib.de>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81786>

[ I forgot the "--compose" switch to "git send-email", so the intro
   follows as a reply to PATCH 1/4. ]


This patch series improves initialization of a repository and adds  
some tests
for core.ignorecase.  It should be applied on top of lt/case- 
insensitive.

  [PATCH 1/4] git-init: autodetect core.ignorecase

     1/4 was proposed some time ago as
     http://mid.gmane.org/<20080325104931.GJ25381@dpotapov.dyndns.org>
     but did not make it into Junio's next.

  [PATCH 2/4] t0050: Test autodetect core.ignorecase
  [PATCH 3/4] t0050: Set core.ignorecase case to activate case  
insensitivity
  [PATCH 4/4] t0050: Add test for case insensitive add

     2-4/4 add some tests.

         Steffen
