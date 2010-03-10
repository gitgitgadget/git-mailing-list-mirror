From: hudarsono <hudarsono@yahoo.com>
Subject: [Pls Help] Connection refused on port 22 when tried to push go git
 server
Date: Tue, 9 Mar 2010 20:42:31 -0800 (PST)
Message-ID: <1268196151780-4707012.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 10 05:42:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpDkj-0005Xg-8p
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 05:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286Ab0CJEmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 23:42:33 -0500
Received: from kuber.nabble.com ([216.139.236.158]:33425 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756271Ab0CJEmc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 23:42:32 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <hudarsono@yahoo.com>)
	id 1NpDkd-0007WN-PN
	for git@vger.kernel.org; Tue, 09 Mar 2010 20:42:31 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi, I am new to git, and trying to install n use on my own server, but
couldn't make it to works till now.

I have installed git and gitosis successfully on server and can clone
the gitosis-admin.git. Then I tried to change the gitosis.conf to be
something like :

[group gitosis-admin]
writable = gitosis-admin mobapp
members = hudars...@Hudarsono-MacBook.local
hudars...@mail.funplanet.com.au

[group personal]
writable = mobapp
members = hudars...@Hudarsono-Macbook.local

and create new repo on server with name mobapp.git.

But when I want to push my local copy to server after run the git
remote add ssh://...@my-domain.com:mobapp.git

I got permision denied:

Hudarsono-MacBook:mobapp hudarsono$ git push
ssh: connect to host  port 22: Connection refused
fatal: The remote end hung up unexpectedly

I don't understand, because I use the same machine as when I clone the
gitosis-admin.

Any help will be very appreciated. 
-- 
View this message in context: http://n2.nabble.com/Pls-Help-Connection-refused-on-port-22-when-tried-to-push-go-git-server-tp4707012p4707012.html
Sent from the git mailing list archive at Nabble.com.
