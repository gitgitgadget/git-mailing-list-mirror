From: Andrey Borzenkov <arvidjaar@gmail.com>
Subject: branch name in remote.<remote>.push is not updated after "git
 branch -m"
Date: Tue, 22 Jan 2013 16:43:06 +0400
Message-ID: <20130122164306.3dc8b757@opensuse.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 13:43:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxdCl-0001hI-WC
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 13:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab3AVMnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 07:43:14 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:40285 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab3AVMnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 07:43:11 -0500
Received: by mail-la0-f51.google.com with SMTP id fo13so325427lab.38
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 04:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=s1ngPBHN/z1+YugAbubh4BLyiI8y3lSsdPTTr1+Ra+s=;
        b=JESo/imCEIstdqpYGkDBXN5bff5iQxtq+oqtdCyxS0XkAuyEamv5ClQXlg+CNDn9f7
         +c27syKVAWU2+PvUeZ1V6gUe4/STSATYNBxhf3dkmv9Kdb8Tl6CM1Ze7kGoKTlhMSU8r
         jccQqaS4xDB+7YMiNZoNvugJK1wjF7WIhDGKchwt//N7fOgKO8s0Tqez8TB/Ic0gW4qk
         bvLQQk6PGaLxBeZZOYGhJTJt8p4/X+cuqpBuafkyTxpMsE+KujIgY+nF7+5HjsDNeMTB
         zcBYYJgn3FFSVhTqc9T2xaYwEku1YaIGeSs+opvcVeZwUaZbGyGMWByS72KRH6j2bkFh
         mAFw==
X-Received: by 10.152.144.38 with SMTP id sj6mr20830961lab.48.1358858589934;
        Tue, 22 Jan 2013 04:43:09 -0800 (PST)
Received: from opensuse.site (ppp91-78-198-46.pppoe.mtu-net.ru. [91.78.198.46])
        by mx.google.com with ESMTPS id n2sm6925304lbc.5.2013.01.22.04.43.08
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 04:43:09 -0800 (PST)
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.10; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214233>

I renamed branches and noticed that branch name was not changed in
remote push config. I.e. after

bor@opensuse:~/src/bootinfoscript> git branch -m github master

I still have

[remote "github"]
        push = github:master
        url = git://github.com/arvidjaar/bootinfoscript.git
        pushurl = git@github.com:arvidjaar/bootinfoscript.git
        fetch = +refs/heads/*:refs/remotes/github/*

Is it expected behavior or possibly already fixed?

bor@opensuse:~> git --version
git version 1.7.10.4

TIA

-andrey
