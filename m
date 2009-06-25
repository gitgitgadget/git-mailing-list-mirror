From: Rustom Mody <rustompmody@gmail.com>
Subject: git in emacs
Date: Thu, 25 Jun 2009 18:05:49 +0530
Message-ID: <f46c52560906250535k6a0eb0a5ne05dc327760d14bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 14:35:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJoBJ-00015Y-QV
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 14:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbZFYMfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 08:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbZFYMfq
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 08:35:46 -0400
Received: from mail-pz0-f189.google.com ([209.85.222.189]:36509 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbZFYMfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 08:35:46 -0400
Received: by pzk27 with SMTP id 27so1311130pzk.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=SYqp7NpIwKsRIFza300AEhP3BkeE6HZBV53oxWdbWqw=;
        b=lfIU4PvJ9LxmWqdsH9+jYNG1itmTedkMcF5Ia4CtWcMD/UjRPcHiULTKf/tW1QUIRt
         QtHguDKIqOhNGkITc0q1bteZ/yX4RSvTMr8gNKHHMmoSd0/Tk4IFKYX2pJiFP9N6D+r3
         El+vic2E3V4im4lVnPjQJBVLA/CREoghjXoWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=c+I8GJKU4qXtS9dCB0pYJU0Su6pzyKhzds2+IQEIvS0WpKfYwL/T93Pw7Wakd5cZgO
         ChvXn1JTBtG0CXJpk1MjUKUs+jGcDLt97RmksQr2EmjpSst7tHKeFoLOuT5v8geEwcgh
         Vtf7E3tlG34paBWb11hyd/GN9vH89TQcboQ0I=
Received: by 10.114.199.1 with SMTP id w1mr3842969waf.151.1245933349408; Thu, 
	25 Jun 2009 05:35:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122203>

Ive been trying to use git.el in emacs

When I checked out an internal commit (I guess that's called a
detached head?) then git-status (in emacs) starts giving me

Branch:     fatal: ref HEAD is not a symbolic ref

This goes away when I do
git reset --hard <original-head-sha> --
git checkout master

[I'm not sure this the best way of restoring the head]

But my question is more about git in emacs. I gather that there are 3 options:
1. git.el
2. vc with git backend
3. dvc with git backend

Which is best/preferable?
Or is it best to stay with the command line?
