From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: Problem: fatal oops during git fetch
Date: Wed, 13 Jan 2010 23:03:43 +0100
Message-ID: <op.u6hrkho1a8ed4e@dellschleppa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 23:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVBJf-00055E-N3
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 23:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531Ab0AMWDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 17:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756414Ab0AMWDq
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 17:03:46 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:35127 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527Ab0AMWDp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 17:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1263420223; l=1319;
	s=domk; d=tilo-schwarz.de;
	h=From:Content-Transfer-Encoding:MIME-Version:Subject:Date:To:
	Content-Type:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=iJsr0+ceUEWxrgCSI8WWry5SGCM=;
	b=dGUnxkwcxtQX5C2vUU/0rK33dhC+PEyZclfhaCyax0QNYT+aP4bDO3+7usVopJ0QCq8
	jYk0tWfAOlxnJb1sctSMDrNGGJWcBPAFE2/5ptaTvguN45J2LPKLW2fsqYrOQAjR2jWrK
	hCCXRo0ngJskYWHErl9SqTOBu7bU5+RkA2I=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlsd51ctAgw==
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CDB44.dip.t-dialin.net [84.156.219.68])
	by post.strato.de (mrclete mo60) (RZmta 22.6)
	with ESMTP id x05d9am0DKOW4R for <git@vger.kernel.org>;
	Wed, 13 Jan 2010 23:03:43 +0100 (MET)
User-Agent: Opera Mail/10.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136887>

Dear List,

git really rocks!

Nevertheless, yesterday I stumbled into a problem, I don't understand. I  
use git for a software projekt, where up to five different computers are  
involved. On each computer the same git repository is used, main  
development happens on one machine, but bug fixes happens also on the  
other machines. Transfer medium is a USB stick, which I use with 'git  
fetch', 'git merge' and 'git push'. More than one year nothing strange  
happened.

Yesterday I tried to fetch bug fixes from one remote machine to the main  
development machine being on branch 'test' using

git fetch remote/test

I got something like

fatal: oops 'SHA1'
Fetch failed

Any ideas what happened here?

I tried various things to fix this without success. I ended up doing 'git  
cherry-pick' manually on the 5 commits I needed from remote/test, then  
discarded remote/test and pushed my local 'test' to remote. I remember,  
that maybe a branch was involved, which was already merged on a remote  
machine, but not on the main machine. But up to now git always resolved  
these things automagically.

As a side remark: I wished, the error message would have been a litte bit  
more detailed. My attempts to make any google sense out of something like  
'git fetch fatal oops' failed.

Regards,

     Tilo
