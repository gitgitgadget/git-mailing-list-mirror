From: Jeffrey Ratcliffe <jeffrey.ratcliffe@gmail.com>
Subject: Re: bundles with multiple branches
Date: Sun, 23 Aug 2009 23:04:06 +0200
Message-ID: <30e395780908231404k7240dbacu5c258d9816e35dd7@mail.gmail.com>
References: <30e395780908231336p403c2171ie383a81c3d1bb020@mail.gmail.com>
	 <c376da900908231352o5c5746c0h9e39b80adede66e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 23:04:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfKEp-0006oV-S5
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 23:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934079AbZHWVEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 17:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbZHWVEH
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 17:04:07 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:64612 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879AbZHWVEG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 17:04:06 -0400
Received: by fxm17 with SMTP id 17so1187474fxm.37
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Faj0STwjSK9y1l7oarJQMnGTQ5bz369xG1kbxjgKmyE=;
        b=ba/jCywizGlFCfor6v8CQ7F/qSzL/oJO+/7H0Nd1mlh6d+M6of0quQqAKi2X4semFC
         avgGrjh028VfCu9+1yLfDiwt/nywv/VL6pgVhgaOU3b44tatdrNbx+yMsdU0vEsZL2/1
         8T4r1wu1f5a5hyLWLRKvcFbf+BI9KgG1MQ0Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OqiOGvlrn94IS0xkOVun8nAhZNK5jM3XErmNa6uf+noYpW5CWYsQjmfBjcjz/zp48c
         pLbPHfFyJhfOJ7TDVJy6RV9mJbGYO1QwJgpK8/vGYeNrtvYPqvwwNcBzMcXooqRQA+X+
         1fbTGsJ9sAF6Uc6B79KE5ZlDx+X/mL5ViIwRA=
Received: by 10.102.245.20 with SMTP id s20mr1530993muh.74.1251061446359; Sun, 
	23 Aug 2009 14:04:06 -0700 (PDT)
In-Reply-To: <c376da900908231352o5c5746c0h9e39b80adede66e8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126878>

Thanks for the help

2009/8/23 Adam Brewster <adambrewster@gmail.com>:
> git remote add bundle /media/cdrom
> git config --replace-all remotes.bundle.fetch refs/heads/*:refs/remotes/bundle/*
> git config --add remotes.bundle.fetch refs/remotes/*:refs/remotes/*

On

$ git pull bundle

or

$ git fetch bundle

I get

fatal: '/media/cdrom': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly

Any ideas?

(I used the mount point of the USB stick where the bundles were but
the principle is the same)

Regards

Jeff
