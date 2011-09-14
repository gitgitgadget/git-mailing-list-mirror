From: Joshua Stoutenburg <jehoshua02@gmail.com>
Subject: Setting up Git Server
Date: Tue, 13 Sep 2011 19:46:47 -0700
Message-ID: <CAOZxsTqFfOR+Eb3rqz5hZSJRTe=a1N-CEM--GGGGO2yayT-HLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 04:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3fV2-0000Cn-Gp
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 04:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417Ab1INCqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 22:46:49 -0400
Received: from mail-ew0-f52.google.com ([209.85.215.52]:37899 "EHLO
	mail-ew0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab1INCqt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 22:46:49 -0400
Received: by ewy28 with SMTP id 28so762637ewy.11
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 19:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=BH7FntJLSAP08zPt7f9yEBVpihswOZEvqa5TIKc3C7M=;
        b=qwoNhhoFmvQF8bHU2URrAj0CnT/vxlmkZfBcJOzfzf3qBEdvOj38JF56ABUvSEUadN
         y7pkSeartH8+drvRNcIigsay0UBkmSJiVhzyJXVCn22ljeBNZb8DpssnEiIHqvcAG0iT
         5XpC2uorBhIr1SdPN2RjHynIrGPCA72UYj2vM=
Received: by 10.213.16.141 with SMTP id o13mr683322eba.91.1315968407780; Tue,
 13 Sep 2011 19:46:47 -0700 (PDT)
Received: by 10.213.16.195 with HTTP; Tue, 13 Sep 2011 19:46:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181335>

Looking for some guidance in setting up a git server customized to my
specific needs. =A0Could anybody walk me through the process?

I have a VirtualBox VM server on which I want to set up a cluster of VM=
s
each one for a different purpose -- experimentation, web hosting, and,
of course, git.

I'm using Ubuntu 10.04 LTS for the operating system. =A0I have a single
public ip address.

I will want to access the git server over the internet. =A0I want to
easily control git users, groups, and permissions apart from the linux
user system, specifying who can access what repositories.

I don't mind CLI, as opposed to GUI, as long as it is well explained,
and it is the most efficient way to do it.

After setting up the server, I'd also like some guidance setting up
individual workstations (*nix and Winblows) to use git in the Eclipse
IDE.

You're guidance greatly appreciated.

I'd gladly put together a step-by-step guide as we figure it out for
other users looking to do the same.
