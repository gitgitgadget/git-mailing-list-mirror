From: Bruce Korb <bruce.korb@gmail.com>
Subject: Next problem... (thank you in advance :)
Date: Sun, 20 Sep 2009 11:53:22 -0700
Message-ID: <4AB67A22.4010004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 20:53:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpRXO-0001I6-Ml
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 20:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543AbZITSxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 14:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755504AbZITSxV
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 14:53:21 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:48892 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbZITSxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 14:53:20 -0400
Received: by yxe37 with SMTP id 37so2442036yxe.33
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=YDdbj3xKIE96qSRYdNcHasu/wl6mqUrWJtT5Ds+pQrc=;
        b=f4xlrHXhaLwN4Z0nMrguz+mYtExYE1oIreSY6Aw/EB6piRYcfBlf5RJN8KDRu7TaAk
         sX4uP374JAz/Y/XvJumCyVr3ZlijGvef6DGXblisL2jH0y/2mxWVpQ22Wmvx2AgkiYVc
         kMF69NmFryb4KmH6/6clQ3jrKS76dSUWKZN+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=vMzbI+xyYorQ01fvhVBh63Vbs0rEoPpvNIn+4vaC980JW/0tiBbys3xhOGY4a5i/EX
         tqlB/81oK9ISnozV6Ev5lgpGO4hGfkg40CqrI8VdSMUA/TfcohZtdmgKqKGGn2T/Z0+F
         erJz5s4UA9/Oq3bXuqowhPexPnmi6lGO1dJ64=
Received: by 10.91.144.16 with SMTP id w16mr2763819agn.21.1253472804305;
        Sun, 20 Sep 2009 11:53:24 -0700 (PDT)
Received: from ?10.10.1.101? (adsl-75-2-129-55.dsl.pltn13.sbcglobal.net [75.2.129.55])
        by mx.google.com with ESMTPS id 11sm3804055aga.74.2009.09.20.11.53.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Sep 2009 11:53:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090310)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128856>

$ git push
fatal: The remote end hung up unexpectedly

Trying to push to Source Forge:

[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	url = git://autogen.git.sourceforge.net/gitroot/autogen/autogen
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master

I did a fresh clone just to be certain that the .git/config file was
formatted correctly.  Still "hangs up".  What is this trying to
tell me?  Thanks again - Bruce
