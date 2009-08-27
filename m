From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH jh/cvs-helper 0/2] Fix building when python is not available
Date: Thu, 27 Aug 2009 11:24:22 -0500
Message-ID: <Rxz2NOwzg1UZ0TgAtOhrA7e8wE02XwcSzNC9cc1EL_W_oN1BjtZn8ClmG5zKB_DKmTgVP0PlMYI@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 18:25:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mghmf-0008JR-7b
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbZH0QY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 12:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbZH0QY5
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:24:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53565 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbZH0QY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 12:24:56 -0400
Received: by mail.nrlssc.navy.mil id n7RGOWhI011019; Thu, 27 Aug 2009 11:24:32 -0500
X-OriginalArrivalTime: 27 Aug 2009 16:24:31.0954 (UTC) FILETIME=[DB989B20:01CA2732]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127173>

These two are built on top of pu.  I'm pretty sure jh/cvs-helper is
the relevant branch.

Brandon Casey (2):
  Makefile: write NO_PYTHON setting to GIT-BUILD-OPTIONS file
  t/test-lib.sh: don't perform python preparations when NO_PYTHON is
    set

 Makefile      |    1 +
 t/test-lib.sh |   18 +++++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)
