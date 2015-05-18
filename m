From: John McIntyre <joh98.mac@gmail.com>
Subject: Git Server Repository Security?
Date: Mon, 18 May 2015 11:07:02 +0100
Message-ID: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 12:07:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuHxB-00024v-AU
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 12:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbbERKHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 06:07:09 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:36420 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbbERKHE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 06:07:04 -0400
Received: by lagv1 with SMTP id v1so211764954lag.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Gk/Cux1hDkimcZEheYvpXVanNvPoqyML7asQOzjb/x8=;
        b=TDl8BLGSAuy7RMAnbG7971gd240cE4W4CRyExO0SOR3Gb0bDfOjdWWjqArlzNHaPqx
         YDRujrEjhAp71VrpEOSZQa3wsIO/E1hC1Ce27hkbIdYyrfN0MnExKRaMHrb4zI+uKivL
         FnT+4efE//woIdoiUkKitdRbYg3haNxO6n1HFjAqyFjvgaiyUWWMmxoJzIbdKfmMd3Wj
         0c3bArEDSW43HRknToNjkBBnnV1ur5zB2ktaJLqO8Bf2mGUdr8VvcLyJm0Wsl8R7h8cq
         JjFOdFG5z8JXT87ACr5cHnWDtmkcJSC/Erj9eAdo6XOT6umOMuWAyjaHkGpWhfNkJwr3
         hFjQ==
X-Received: by 10.112.155.169 with SMTP id vx9mr3617860lbb.121.1431943622717;
 Mon, 18 May 2015 03:07:02 -0700 (PDT)
Received: by 10.152.129.228 with HTTP; Mon, 18 May 2015 03:07:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269225>

Hi,
I've been asked to set up a git repository for a few projects.  So I
have a Linux CentOS server running git.   I place the repositories
under /opt and I use the .ssh/authorized_keys of the git user, to
grant access. The user sends me his private key, and I paste it into
the end of the file.

And now, I realise that there's a problem.  If I have /opt/repo1.git
and /opt/repo2.git, then all users can access both repositories.

Is there a way to prevent this?

Thanks.
