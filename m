From: "Adam Mercer" <ramercer@gmail.com>
Subject: problem pushing repository
Date: Thu, 21 Jun 2007 21:49:25 -0400
Message-ID: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 03:49:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1YHA-0007YL-H8
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 03:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbXFVBt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 21:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbXFVBt1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 21:49:27 -0400
Received: from ag-out-0708.google.com ([72.14.246.241]:22319 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbXFVBt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 21:49:26 -0400
Received: by ag-out-0708.google.com with SMTP id 35so635213aga
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 18:49:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NdCR2h2EjthrLql7QY6kD/3+wImyLD2hqJHTl0R7S+Cas9H07FwTq2l09fcUY3KcECBrgVFaSJStBFc1m8C5ZGcKM1P12nnGhlkXB1a5PJSWMgIDHdi8sCBOYU4yDW1J09gSGPHGQIILk7HFSmugmyASzAmV+n6YIQ5oHFDAa7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XfDAzC7Z14echxqKMOV6DW8zX0mMaNC6UBF4v92DKBXHsGe2ke5fTk0tue28eY4SCuZVoXPT3dhF9+yRaBWDSWImqmlcfraMQGP+0ivxVBYHkrUbYHPunaJpezj3cvob7fg1mPXeWA6/BY00VmUfS+rNsaFGpX+HzX3HaAb4G5Q=
Received: by 10.90.94.2 with SMTP id r2mr2322623agb.1182476965625;
        Thu, 21 Jun 2007 18:49:25 -0700 (PDT)
Received: by 10.90.28.17 with HTTP; Thu, 21 Jun 2007 18:49:25 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50664>

Hi

I've just started using git to track a project I'm working on and I'm
having a problem pushing my repository.

[ram@skymoo glue]$ git push
ssh://ram@newberry.ihepa.ufl.edu/~ram/public_html/git/glue.git
bash: line 1: git-receive-pack: command not found
fatal: The remote end hung up unexpectedly
error: failed to push to
'ssh://ram@newberry.ihepa.ufl.edu/~ram/public_html/git/glue.git'
[ram@skymoo glue]$ which git-receive-pack
/Users/ram/opt/git/bin/git-receive-pack
[ram@skymoo glue]$

git-receive-pack is in my $PATH so why can't it be found when trying to push?

Cheers

Adam
