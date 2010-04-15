From: skillzero@gmail.com
Subject: git svn for svn snapshots?
Date: Wed, 14 Apr 2010 17:38:21 -0700
Message-ID: <o2r2729632a1004141738y86cb0a6eyc99ca1e792553736@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 02:38:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2D6O-0007v8-TD
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 02:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679Ab0DOAib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 20:38:31 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:41574 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab0DOAiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 20:38:23 -0400
Received: by yxe37 with SMTP id 37so419679yxe.21
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=AeLp6Q9GpQuCM/wPC9ttHOd2Q83SrHvlD1JTd9Ct9+o=;
        b=TlZ/7SLpcv+og5df3lH8dkyR7GBkwDAudpctPmXFE8Y8n+63sJBUpSdb5h2qg4mCI2
         Pf4Fv3CedikCYRXtt1ThAoqXgWZASxrkSC0gn/D0YQgjAvuhza3N6x/0PxINztxO/R86
         n0TF7ZqptIGg657HoneGSLYxVUJUjMQ7rL9EU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=w/1K1QBDwvbM6Z8LM58DMYmC6FtzxL0m0LEplABJ+HQbxjpOEUCXhQLAsahjxbYOK5
         oyC72nGdI8cLeMJ/23To4Bi9ckvvqVQpAquH5U2KD0rE8ZgJ/VPezGIu48FkI4fNb0m9
         KlsFFZIUz4iBTY9eE75b8yDoqbh+z/w5eA4Xc=
Received: by 10.231.150.204 with HTTP; Wed, 14 Apr 2010 17:38:21 -0700 (PDT)
Received: by 10.231.156.80 with SMTP id v16mr3607182ibw.99.1271291901374; Wed, 
	14 Apr 2010 17:38:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144933>

I'm using a native git repository for my development, but to work with
a certain build system, the sources need to be in svn. So I want to
keep using git and then just periodically push a snapshot to an svn
repo to work with this build system.

Is there a way to do this with git svn? I tried just adding the svn
remote to my config file, doing a fetch, and using set tree, but it
said there were no upstream revisions. The svn repository is huge and
my stuff just goes into one folder in there (one that I just created
with svn mkdir).
