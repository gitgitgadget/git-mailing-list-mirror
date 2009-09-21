From: Dominic Rose <dominic@bioinf.uni-leipzig.de>
Subject: error: insufficient permission
Date: Mon, 21 Sep 2009 10:32:07 +0200
Message-ID: <4AB73A07.3020703@bioinf.uni-leipzig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 10:40:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpeRM-0000Jg-Ep
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 10:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbZIUIjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2009 04:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755238AbZIUIjq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 04:39:46 -0400
Received: from v4.rz.uni-leipzig.de ([139.18.1.30]:46188 "EHLO
	v4.rz.uni-leipzig.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087AbZIUIjq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 04:39:46 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2009 04:39:46 EDT
Received: from localhost (localhost [127.0.0.1])
	by v4.rz.uni-leipzig.de (Postfix) with ESMTP id C9A42272
	for <git@vger.kernel.org>; Mon, 21 Sep 2009 10:32:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at v4-ul
Received: from v4.rz.uni-leipzig.de ([127.0.0.1])
	by localhost (v4.rz.uni-leipzig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id safaGFE30x2o for <git@vger.kernel.org>;
	Mon, 21 Sep 2009 10:32:29 +0200 (CEST)
Received: from m1.rz.uni-leipzig.de (m1.rz.uni-leipzig.de [139.18.1.9])
	by v4.rz.uni-leipzig.de (Postfix) with ESMTP id 9CCF026C
	for <git@vger.kernel.org>; Mon, 21 Sep 2009 10:32:29 +0200 (CEST)
Received: from bierdepot.bioinf.uni-leipzig.de (bierdepot.bioinf.uni-leipzig.de [139.18.75.68])
	by m1.rz.uni-leipzig.de (Postfix) with ESMTP id 9E9283B
	for <git@vger.kernel.org>; Mon, 21 Sep 2009 10:32:08 +0200 (CEST)
Received: from rioja.bioinf.uni-leipzig.de (rioja.bioinf.uni-leipzig.de [139.18.75.86])
	by bierdepot.bioinf.uni-leipzig.de (8.14.2/8.12.10) with ESMTP id n8L8W7iF031746
	for <git@vger.kernel.org>; Mon, 21 Sep 2009 10:32:07 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128869>

Hi,

may please somebody help me with the following issue. I try to checkin=20
changes to a repository I created. Seems like I have some permission=20
problems, but I can't figure out whats going wrong:

$ git commit -m 'test'
Created commit 07b3a4a: test
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git push
Counting objects: 8, done.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 1.56 KiB, done.
Total 6 (delta 4), reused 0 (delta 0)
error: insufficient permission for adding an object to repository=20
database ./objects

fatal: failed to write object
error: unpack failed: unpacker exited with error code
To /homes/[...]
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to '/homes/[...]'


Thanks,
Dominic

--=20
Dominic Rose
Professur f=FCr Bioinformatik
Institut f=FCr Informatik
Universit=E4t Leipzig
H=E4rtelstr. 16-18
D-04107 Leipzig
WWW    http://www.bioinf.uni-leipzig.de
Phone: +49 341 97-16698
=46ax:   +49 341 97-16679
