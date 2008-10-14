From: Kristian Amlie <kristian.amlie@trolltech.com>
Subject: Rerunning merge on a single file
Date: Tue, 14 Oct 2008 14:13:15 +0200
Message-ID: <48F48CDB.1010309@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII";
	format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 14:17:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpinJ-0008WL-Gj
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 14:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbYJNMNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 08:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbYJNMNU
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 08:13:20 -0400
Received: from hoat.troll.no ([62.70.27.150]:36512 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754802AbYJNMNU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 08:13:20 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 6864520B20
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 14:13:16 +0200 (CEST)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 5F9AE20A95
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 14:13:16 +0200 (CEST)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id m9ECDFZc004770
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 14:13:16 +0200
Received: from [172.24.106.14] ( [172.24.106.14])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Tue, 14 Oct 2008 14:13:15 +0200 (CEST)
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080519)
X-Enigmail-Version: 0.95.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98183>

Hey, I have question about advanced merging.

Suppose I have a huge merge with conflicts all over the place. There is 
no way to avoid them, so I start working from the top. At some point, 
however, I make a mistake and lose the merge information for one file 
(for example by checking out the file from HEAD).

In that case I would like to get the conflict markers back, and do that 
file over again, but I don't want to throw away the rest of the index 
state. Currently the only way I can see to do this is by checking out 
several file versions under different names and then using git 
merge-file on them.

Is there a better way to achieve this?

Kristian
