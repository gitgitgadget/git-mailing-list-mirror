From: Jon Seymour <jon.seymour@gmail.com>
Subject: error: * Ignoring funny ref 'refs/heads/' locally
Date: Wed, 17 Jun 2009 22:08:25 +1000
Message-ID: <2cfc40320906170508o4fc0fc14sca511742be03ee5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 14:08:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGtwQ-00034X-8U
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 14:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbZFQMIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 08:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757470AbZFQMIY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 08:08:24 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:47888 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769AbZFQMIX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 08:08:23 -0400
Received: by gxk10 with SMTP id 10so399702gxk.13
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/jyeEdMmbKP30W3wB5WmZW4XhbncSCXQVPE591yc+tg=;
        b=lquN3Wzi1npq0NMv01MyIs1QIohgB5gNEmumUvR3+eTx65zoImFJXF+UDCXU3hDDBQ
         rOCa9aOUDf/wMI6y2Y0HOFO4W/wOUVtDVOwkxbWBxemldFKlMMu/kuE35fPEt0mfwiBL
         KN6DhSo1wNgdZhGs0kXSpqiVL6sI7lW7zBAZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=GI7+N3OiHIeQi1RsXEKwcRUILxQc4/RqTdErURgFMw3eDNhkb1hS4jIe9jxQPPy8+w
         ikqmHxq07hP9uJCvIBcs3RdqLxBNqxAVxLOqCg5JrEG3ncIYffu4maSq37Jy03EwOIJg
         Nw1bWq5m7LM2ByZKpspi24Na0wmdqz6P5m2t4=
Received: by 10.151.134.8 with SMTP id l8mr1076050ybn.121.1245240505609; Wed, 
	17 Jun 2009 05:08:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121737>

Can someone tell me why this happens?

    error: * Ignoring funny ref 'refs/heads/' locally

It also happens with 1.6.3.1

$ mkdir root
$ cd root
$ git init
Initialized empty Git repository in /tmp/root/.git/
$ :> .gitignore
$ git add .gitignore
$ git commit -m "initial"
Created initial commit 6a7c768: initial
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
$ cd ..
$ git clone root clone
Initialized empty Git repository in /tmp/clone/.git/
$ cd clone
$ git fetch origin :
error: * Ignoring funny ref 'refs/heads/' locally
$ git --version
git version 1.6.0.4
$ exit
