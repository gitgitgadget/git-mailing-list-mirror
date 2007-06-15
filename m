From: "Ed Schofield" <edschofield@gmail.com>
Subject: Newbie questions about moving around repositories
Date: Fri, 15 Jun 2007 14:52:42 +0100
Message-ID: <1b5a37350706150652y7710c380l79e785cba8f6b02e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 15:52:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzCER-0002iy-NP
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 15:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbXFONwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 09:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbXFONwp
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 09:52:45 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:25993 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbXFONwn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 09:52:43 -0400
Received: by nz-out-0506.google.com with SMTP id n1so955140nzf
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 06:52:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pw6N9kECoPVMgSnn4fJPZHHR4RX/b1ODV5wfc8zwCAFAKhsnibytzPu8VVpVx/FZATTRV8lbTP7lEo0WHcch90D/Le2Bf/BMSxthnlOgQHNMzxkpLv8KIjtHCyBYrmpt4bZVRHHV0OLC0SsNy2wN2bVbxuepLDhOVPQJDPvF/ZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TmhrXU6bp9sM0tnPoGP+lWUFdNw+dnvLsr9eLLqLsRZUIKKhmmBV5aB0Zix0OFqwg/HPAiPYOJ3trniHHelqiMuPsow95mEp8yLLafurc4eNfi3Bo2scad6D4MXp6igFkKwOYpJwKKEcpPELCQtrwXIUMX/xXLgvUt2B8qK8A+g=
Received: by 10.115.54.1 with SMTP id g1mr2980050wak.1181915562899;
        Fri, 15 Jun 2007 06:52:42 -0700 (PDT)
Received: by 10.114.196.16 with HTTP; Fri, 15 Jun 2007 06:52:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50261>

Hi all,

I've recently started using git to manage my own patchsets for a
public CVS repository that I don't have write access to. I have a
couple of newbie questions, please:

1. I would like to move my repository (including all branches) from
directory A to a directory B on a different filesystem. Can I use
git-clone for this? It seems that git-clone creates remote-tracking
branches, but I want to keep all of the branches as local branches so
I can remove the original repository.

2. I can't just move the entire directory A, because I get

Error in startup script: error: object directory
A/../A-cvs-git/.git/objects does not exist; check
.git/objects/info/alternates

I think I originally created the repository by cloning from my
A-cvs-git/ directory with git-clone --shared, but I don't quite
remember. So I suppose I want a way to stop using the alternates
mechanism and make my repository self-contained in one directory. Is
this possible? Will I then be free to move the directory?

I'd appreciate any advice!

-- Ed
