From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Can_I_retrieve_changes_from_deleted_stash=3F?=
Date: Mon, 05 Oct 2009 14:05:59 +0200
Message-ID: <c18a43e.55008170.4ac9e127.2a972@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 14:08:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MumMf-0003eR-DN
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 14:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758700AbZJEMIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 08:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758629AbZJEMIM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 08:08:12 -0400
Received: from tur.go2.pl ([193.17.41.50]:50758 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758580AbZJEMIM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 08:08:12 -0400
Received: from mailout1.go2.pl (mailout1.go2.pl [193.17.41.11])
	by tur.go2.pl (o2.pl Mailer 2.0.1) with ESMTP id EC0B7230F40
	for <git@vger.kernel.org>; Mon,  5 Oct 2009 14:07:34 +0200 (CEST)
Received: from mailout1.go2.pl (unknown [10.0.0.103])
	by mailout1.go2.pl (Postfix) with ESMTP id 516565D514E
	for <git@vger.kernel.org>; Mon,  5 Oct 2009 14:06:00 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.37])
	by mailout1.go2.pl (Postfix) with SMTP
	for <git@vger.kernel.org>; Mon,  5 Oct 2009 14:06:00 +0200 (CEST)
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129556>

I did:

$ git stash
$ git pop

$ git checkout -- <modified files>

Now I don't have changes I stashed. I guess the blobs with stashed
files should be somewhere?  Is there any way I can get back my changes?
I tried to use git-reflog, but I'm not sure how can I find the files
I need.
