From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: git-archive and submodules
Date: Sat, 29 Mar 2008 09:47:27 -0400
Message-ID: <8ec76080803290647h25e86f18k7a86bc4cb2cc3d38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 14:48:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfbPn-0004Lr-Sl
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 14:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbYC2Nr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 09:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbYC2Nr2
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 09:47:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:46478 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbYC2Nr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 09:47:27 -0400
Received: by wf-out-1314.google.com with SMTP id 28so644284wff.4
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=0YCC2CPHEtwT99Sa8UIUOD+Auu9cf43wb5hz3vCkk0o=;
        b=am9uqglsfmn1QEXct4kaEzwJCsfJJd/RpBu5L/FcgtR4ZD+X4lss41ZcFP2AOZwO23PX6uTTHzxdo5bcuNGjHKwCeeZblMDbewFcFIFbhr8LZqY52E/wQTadCmy5lcLOUs6zoHkF4tU3fpkWWoBzulB+40sOpnJbRkXw2AkX3Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=itJyK7tu4KbPlhARt5Yfn37o4TdOVWjoxQygiH92WsOdXxSX5dWnMsse6ElXrkq+qa6ED9s2qix4wBW91mhZ+/ue5KpiFJxgUsPm3J6VJ5+kfAgOJrj8f13e5xLNSmksdcoR7Vltj/ZUZKQn6MPxnI2nuuqBM9mUqn3Zc7wwOUM=
Received: by 10.142.226.2 with SMTP id y2mr2634139wfg.137.1206798447421;
        Sat, 29 Mar 2008 06:47:27 -0700 (PDT)
Received: by 10.142.187.13 with HTTP; Sat, 29 Mar 2008 06:47:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78467>

Is there a way to ask git-archive to archive the submodules of the
project as well?

I have a project that needs it's submoduels distributed with it.

Is anyone else using submodules in this way?

my project is: 	git://repo.or.cz/fts.git

It has a submodule: 	tslib at git://repo.or.cz/tslib.git

I create the archive by:
git archive --format=tar --prefix=fts/ HEAD | gzip > ~/fts.tar.gz

and when I go into the tslib submodule directory after expanding the
archive, it is empty.

-Whit
