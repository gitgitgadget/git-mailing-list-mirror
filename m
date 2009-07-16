From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/2] Two miscellaneous patches found while debugging 'next'
Date: Thu, 16 Jul 2009 16:25:17 -0500
Message-ID: <W0GiRm9n1NEfjVB8xBotanSRY89hxjLPu3Wksn_EsZusMJjkHNIRf8JuQmUh43ny21xTKBn1Li8@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 16 23:26:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRYTR-0001ME-2w
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 23:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933424AbZGPVZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 17:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933420AbZGPVZq
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 17:25:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53023 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933391AbZGPVZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 17:25:44 -0400
Received: by mail.nrlssc.navy.mil id n6GLPepJ017280; Thu, 16 Jul 2009 16:25:40 -0500
X-OriginalArrivalTime: 16 Jul 2009 21:25:39.0879 (UTC) FILETIME=[F791AB70:01CA065B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123427>

From: Brandon Casey <drafnel@gmail.com>

Noticed these two issues while debugging a segfault on next.
Patch for 'next' to follow.

-brandon


Brandon Casey (2):
  refs.c: release file descriptor on error return
  sha1_name.c: avoid unnecessary strbuf_release

 refs.c      |    4 +++-
 sha1_name.c |    2 --
 2 files changed, 3 insertions(+), 3 deletions(-)
