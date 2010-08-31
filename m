From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Q. about usage of notes
Date: Tue, 31 Aug 2010 10:09:19 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4C7CB8AF.5080008@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 31 10:36:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqMKK-0002NG-CS
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 10:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab0HaIgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 04:36:00 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:55730 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab0HaIf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 04:35:59 -0400
X-Greylist: delayed 1614 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Aug 2010 04:35:59 EDT
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id 0302B138A0
	for <git@vger.kernel.org>; Tue, 31 Aug 2010 10:09:02 +0200 (CEST)
X-AuditID: 0ac86512-0000179c000005d0-e5-4c7cb89e2ba6
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 31 Aug 2010 10:09:02 +0200
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 0B6912717A
	for <git@vger.kernel.org>; Tue, 31 Aug 2010 10:09:02 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id EFD082716A
	for <git@vger.kernel.org>; Tue, 31 Aug 2010 10:09:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154887>

Hi,

I was playing around with 'git notes' these days (after reading S.Chacons
post to this list and hist blog post at progit.org).

Some things came to my mind when doing some 'git notes add' and
'git notes remove':

How do I really get rid of git notes ? 'git notes remove' doesn't really
remove the notes but creates a new commit (like 'git rm file ; git commit..' does).

And why does 'git remove' do that repetetively (is that even a word...?), i.e. 
'git add -m"Note" ; git remove; git remove; git remove; git remove' creates 5
commit objects under 'refs/notes/commits' Is that the intended behaviour ?

I'm a little bit puzzled....

Regards,

Stefan
-- 
----------------------------------------------------------------
/dev/random says: It's not the principle of the thing, it's the money
