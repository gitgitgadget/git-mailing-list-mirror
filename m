From: Mark Lodato <lodatom@gmail.com>
Subject: Script to convert git patches to Hg format
Date: Sun, 11 Oct 2009 18:56:46 -0400
Message-ID: <ca433830910111556r6b11e787l58596b9cf56ac0ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 00:58:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx7NN-0003fZ-Nr
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 00:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbZJKW52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 18:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbZJKW52
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 18:57:28 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:45571 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbZJKW51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 18:57:27 -0400
Received: by bwz6 with SMTP id 6so2776602bwz.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=oij1KY48jcwpbAbce1bZ+30tciIppWotj6LONirPMGg=;
        b=HMGj3vtc4o8kwgYEjJ1jvqRKPjZHLIYAdxkRn6edfFUnLmcZxyi4S+XtmAytDgW1kF
         +WSPjM0Kel7AfVj4SyvelQWBHYXn7y+asgKj0+Kle/mMr34lg8ts7q/+vXN5cS5hECia
         ArrNnpTR9IQYiJATn6xph+ywiAJ3G1qBSFzrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ppciByTqXrPFBNO/uy1CEVTFTD+R7MUOM1t3KeKEFPlQmU91E68PhX11C0Lq/Y20tA
         ZKEBzAfVVNVEeX/ByVZvF3/YrOJP4ojh8CK+2Tn3Ynr4Ui7NUkSJZPudhuA+5m9ouHHt
         IH/xSnAB59LTcPBx3yVoRtvQRgIUcUZw1yiPs=
Received: by 10.223.5.18 with SMTP id 18mr1436277fat.58.1255301806510; Sun, 11 
	Oct 2009 15:56:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129964>

To make it easier to submit patches to a project using Hg, I wrote a
small script to convert the output of `git format-patch' to something
suitable for `hg import'.  The latest version is available at:

http://github.com/MarkLodato/patch-converter

While `hg import' *can* read a git patch, it does not interpret the
date, and it includes the diffstat in the commit log.  This script
fixes those problems.

The script worked well enough for me, but bugs may exist.  If you have
ideas for improvement, patches are welcome :)

--
Mark
