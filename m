From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCHv2 0/3] GIT_ASKPASS and core.askpass
Date: Mon, 30 Aug 2010 15:36:18 +0200
Organization: science + computing ag
Message-ID: <201008301536.20414.k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 15:36:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq4XP-0005Ps-PZ
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 15:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab0H3NgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 09:36:24 -0400
Received: from smtp1.belwue.de ([129.143.2.12]:37768 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab0H3NgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 09:36:23 -0400
Received: from mx4.science-computing.de (mx4.science-computing.de [193.197.16.30])
	by smtp1.belwue.de with ESMTP id o7UDaM6Z015569
	for <git@vger.kernel.org>; Mon, 30 Aug 2010 15:36:22 +0200 (MEST)
	env-from (prvs=851ee50e4=k.franke@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id C68D4414004;
	Mon, 30 Aug 2010 15:36:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mvt0w8j7B9PS; Mon, 30 Aug 2010 15:36:21 +0200 (CEST)
Received: from sirmione.science-computing.de (sirmione.science-computing.de [10.10.24.2])
	by scmail.science-computing.de (Postfix) with ESMTP id 344AA414002;
	Mon, 30 Aug 2010 15:36:21 +0200 (CEST)
Received: from sirmione.localnet (localhost [127.0.0.1])
	by sirmione.science-computing.de (Postfix) with ESMTP id 154FEAE3C9;
	Mon, 30 Aug 2010 15:36:21 +0200 (CEST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.29-0.1-pae; KDE/4.1.3; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154797>

Hi,

and thanks for the feedback so far. Here comes an updated version:


Anselm Kruis (1):
      Add a new option 'core.askpass'.

Knut Franke (2):
      Allow core.askpass to override SSH_ASKPASS.
      Extend documentation of core.askpass and GIT_ASKPASS.


 Documentation/config.txt |    9 +++++++++
 Documentation/git.txt    |    7 +++++++
 cache.h                  |    1 +
 config.c                 |    3 +++
 connect.c                |    7 +++++--
 environment.c            |    1 +
 git.c                    |    3 ---
 7 files changed, 26 insertions(+), 5 deletions(-)

--
1.7.2.1
-- 
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196 
