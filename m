From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Configuring the location of ~/.gitconfig
Date: Wed, 26 Sep 2012 19:44:27 +0530
Message-ID: <CALkWK0nEP2gf4fYL=hjHg_U3X67M4PF1aupV+VJb9T6eBEo0MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Anurag Priyam <anurag08priyam@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 16:15:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGsOB-0005Pp-D3
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 16:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab2IZOOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 10:14:50 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:50918 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab2IZOOt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 10:14:49 -0400
Received: by qaat11 with SMTP id t11so1076662qaa.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=sbCL9lluNj29b4JRGt5O+hh4xIuZFq2RTV/o1w6KGjk=;
        b=uqdf6XA5yelxsLKAyrAIhVGdn9qswIVCKM1eHCzPnVEURDl6XDGB+a0m7RHDZjpRmJ
         vRcSA/yzncBrEwvEMg1Ad9DqUdwjif7wAIdCRzVvLjtD0l7+ww1fqCHDuhGq0X+JxJ01
         M2n2tuVrmOjP4FkrKywUz/LakbTvXgM3+1EhJgyFKWhUX1cD8+51fQp44bKaY+jw70bE
         gnP163ghOI0hG3wX/9DNNM3RvgdNx53lFlNrywk2ocwdMx9Lr1sV6ZlSHJjhowE6vaFb
         pVJ5ivA6jMuU7PFMrppztJt8YMOgQUlk2MPKecHtUFDjL/y08bqtafqpTktEh1aQfDCm
         muiw==
Received: by 10.224.78.141 with SMTP id l13mr2379391qak.25.1348668888870; Wed,
 26 Sep 2012 07:14:48 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Wed, 26 Sep 2012 07:14:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206417>

Hi,

I'd like to configure the location of ~/.gitconfig through an
environment variable.  My usecase is a simple enough: I have a
repository with all my dotfiles, and I don't want to symlink
~/dotfiles/.gitconfig from $HOME after cloning it.  Does anyone else
think the feature will be useful?

A couple of similar examples:
1. The git templates directory is configurable via the
GIT_TEMPLATE_DIR variable.
2. The location of ~/.zshrc, ~/.zlogin etc is configurable via the
ZDOTDIR variable in ZSH.

Ram
