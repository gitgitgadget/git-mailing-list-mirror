From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/2] git-gui: Add a special diff popup menu for submodules
Date: Sat, 02 Jan 2010 17:57:06 +0100
Message-ID: <4B3F7AE2.10007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 02 17:57:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR7Hu-0002qO-Ui
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 17:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab0ABQ5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 11:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677Ab0ABQ5J
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 11:57:09 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:35478 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0ABQ5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 11:57:09 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5884C14AE5888;
	Sat,  2 Jan 2010 17:57:07 +0100 (CET)
Received: from [80.128.99.24] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NR7Hn-0006gX-00; Sat, 02 Jan 2010 17:57:07 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/8TkLK5YcCTeIrtF5qEnsQfvwHCaCiMYnxLLGM
	24HGzN2rcjHdZD51iCMoH5HRwCIRhxjskpMYO8aoKXtYItGlfD
	YHKMmodbTwX5QIJ+Av9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136031>

The first patch is a resend (first sent on December 7th 2009) and
necessary for the second patch to work properly.

Jens Lehmann (2):
  git-gui: Unstaging a partly staged entry didn't update file_states
    correctly
  git-gui: Add a special diff popup menu for submodules

 git-gui/git-gui.sh |  130 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 113 insertions(+), 17 deletions(-)
