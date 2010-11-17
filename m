From: Albert Strasheim <fullung@gmail.com>
Subject: Versioning configuration files on a server: fatal: Unable to create
 '//etc/.git/index.lock': No such file or directory
Date: Wed, 17 Nov 2010 08:24:04 +0200
Message-ID: <AANLkTi=UPWTeZP9uF+FGtsSs7wH3AmwdeLtsPJQnKvez@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 17 07:24:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIbRc-0003e8-MY
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 07:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934273Ab0KQGY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 01:24:26 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34787 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934264Ab0KQGYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 01:24:25 -0500
Received: by bwz15 with SMTP id 15so1210505bwz.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 22:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=1Vc1WJ64r8dDf+xN7h+4AJPYyy1BUPODjY1MN6miDqM=;
        b=ppNk4eRt3FR0tSRiIxD1GRIe7Q4njKtQ40IOjugUCXFvd+gafPubbBnLEu7aJVs7TO
         GIyxdiYhabKGd04Kmsy6kpKjkNzUXU46XYdXdn18WNy0NjGw2nlyjQHWPjwDxuoSuu5a
         +D5//N0AAFrC8K0cY7Ob4sY6GwTGWw7OTZeps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=vSKcwaEjftMdRuEmAFmTr6db4fMAF33KVz23CV6Jitc6txTHelN476ej+rx562bK5u
         kBR0MdprPQoA4mPziSYJiRiP9VPl4w91V/w8YWGXcswytSiGdOXKApyP2JcR6Bz4JSAp
         grsgNQe0+QuTjjYYMYLUsT9miDbiCzvnb4qNU=
Received: by 10.204.116.201 with SMTP id n9mr8772313bkq.138.1289975064205;
 Tue, 16 Nov 2010 22:24:24 -0800 (PST)
Received: by 10.204.49.8 with HTTP; Tue, 16 Nov 2010 22:24:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161599>

Hello all

I'm trying to use git to version all the configuration files on a server:

su
cd /
git init
cd /
touch k
git add k #this works
cd /etc
git add hosts

This fails with:

fatal: Unable to create '//etc/.git/index.lock': No such file or directory

I'm running git-1.7.3.2-1.fc14.x86_64.

Is there any way to convince git to work in this scenario?

Regards

Albert
