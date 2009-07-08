From: Ondrej Certik <ondrej@certik.cz>
Subject: default aliases (ci, di, st, co)
Date: Wed, 8 Jul 2009 17:49:26 -0600
Message-ID: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 01:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOgtL-0008TQ-Gx
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 01:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770AbZGHXta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 19:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbZGHXt3
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 19:49:29 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:56245 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbZGHXt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 19:49:28 -0400
Received: by yxe26 with SMTP id 26so8557277yxe.33
        for <git@vger.kernel.org>; Wed, 08 Jul 2009 16:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ActJnEylBreE63qZ0KaeSBt25KfaM1qpC5LV8ZjJIME=;
        b=sVH1HgG+9ZDcbuQdKnv2QS5nyJepdxlOqLMkjUHL33LGRe6o/oAOH+lFdlqFW38xel
         3A2bDvKY8cI93Q7lDhl+mEkjY0CyHn4jvOsVz8zxXhFOThliQ3KuJUijn5zzwFD4h6J+
         xo4faovcthQ0aRqp0kmI76uEE8Bm5zhRJMsEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=kCyEgWCTlYysh8KEoORtG9Lr8bc8JytP6m0G6E6D2zO+5NnDZTOijfeAJ1hRgMJBW4
         jfWsVmERjDYWYTIpnF6W+7g4j8tnQZWDRCpRa2pIJxM/Fn8NHPPwqbDfbv/mQof+s2Ct
         e2EpZU7SlQPZ8aRbFPZYUFfcThg8odc1x8Lis=
Received: by 10.90.84.2 with SMTP id h2mr95008agb.38.1247096966990; Wed, 08 
	Jul 2009 16:49:26 -0700 (PDT)
X-Google-Sender-Auth: 2b2a2579e323c1d5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122926>

Hi,

coming to git from mercurial and svn, here is the alias part of my .gitconfig:

[alias]
    ci = commit
    di = diff --color-words
    st = status
    co = checkout


And all is fine until I share commands to checkout my branch (for
example) with other people, then basically I have to write those
commands in full (e.g. commit, checkout, ...), since I cannot assume
they have their .gitconfig setup the same way I do. Especially for
people who are new to git.

What is the view on this in the git community? Do most of you write

git checkout -b branch ...

(possibly with TAB completion) or do most of you write

git co -b branch ...

(like I do all the time, except when sharing my commands with other people)?

Could in principle those aliases be even made default by git? Or is
this not a good idea.

Ondrej
