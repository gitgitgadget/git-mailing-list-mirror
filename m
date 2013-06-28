From: =?ISO-8859-15?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: git clone -b
Date: Fri, 28 Jun 2013 13:59:51 +0200
Message-ID: <51CD7AB7.3040409@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 28 13:59:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsXLK-00027x-HH
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 13:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab3F1L7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 07:59:54 -0400
Received: from mail96.atlas.de ([194.156.172.86]:12466 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813Ab3F1L7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 07:59:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id CF44310150
	for <git@vger.kernel.org>; Fri, 28 Jun 2013 13:59:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ywZBU0aMFAVb for <git@vger.kernel.org>;
	Fri, 28 Jun 2013 13:59:52 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Fri, 28 Jun 2013 13:59:52 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 323082716A
	for <git@vger.kernel.org>; Fri, 28 Jun 2013 13:59:52 +0200 (CEST)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.1; Fri, 28 Jun
 2013 13:59:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229190>

Hi there!

Is there any reason why 'git clone -b' only takes a branch (from refs/heads/)
or a tag (from refs/tags/) ?

Background: At $dayjob we're using some kind of 'hidden' refs (in refs/releases/)
to communicate between the 'branch integrator' (who creates the ref in refs/releases/)
and the 'build master' who wants to build that ref. 

It would be a little easier if the build master could simply say

  git clone -b refs/releases/the-release-for-today URL

instead of: git clone... ; cd ... ; git fetch... ; git checkout....

Any answer or even a better idea to solve that is appreciated.

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Second star to the right & straight on till morning...
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
