From: skillzero@gmail.com
Subject: git clone failing over slow links?
Date: Tue, 9 Jun 2009 08:52:10 -0700
Message-ID: <2729632a0906090852r124eff8eo8391ae90cbda5872@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 17:52:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME3cb-0003E4-Fr
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 17:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbZFIPwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 11:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbZFIPwK
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 11:52:10 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:51729 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbZFIPwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 11:52:09 -0400
Received: by gxk10 with SMTP id 10so37743gxk.13
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=MCnj1JQd5ZEaPc/rJpMvvgHc/sFS4sXh0FBQDvFvs5A=;
        b=AQO8TCmsV5qEgCU7miUtQk/T5tT6DJi3mfDBeFyVtYt1srH7+vAwneHw22glLda2OE
         0ukjmSdT364LDHdoxOaHewoxvQPQZvP9Pq7+2WhCO+uyswNCKXGc88y04Tw6MayxzdPp
         eWNfvWTfE3nB70bhyvweJBkz1TV0ixdaO5osE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=dwk1CHP9NtoSxr8909Lyi/b0HOaKncNJ8Nvk2pWRoTtpAD+M+4i46xONX3J+ZJQVa6
         xVHWnwlKVgcyC/0td3IpHpGktP/PC5fun9/8fL77Epg6o53HcrLT3Y37c0BtBU8udWnu
         sL8pmmLZZgr5c+TwAxAmyishaZi/wZFYpx0as=
Received: by 10.100.125.14 with SMTP id x14mr146307anc.136.1244562730207; Tue, 
	09 Jun 2009 08:52:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121178>

People with slower connections are having problems cloning my
repository. The server seems to just drop the connection. This
repository is about 300 MB. The server is using git 1.6.1. This is
using an ssh URL. They've tried many times and it usually dies at
different places in the clone (5%, 80%, etc., with one successful
clone so far for them).

remote: Counting objects: 121290, done.
remote: Compressing objects: 100% (82778/82778), done.
fatal: The remote end hung up unexpectedly62.14 MiB | 147 KiB/s
fatal: early EOF
fatal: index-pack failed

Are there any known issues with git 1.6.1 that might cause this? I can
try to get the server updated to 1.6.2.3, but I was curious if anyone
knew of any specific issues like this. The server is running Mac OS X,
if that matters.
