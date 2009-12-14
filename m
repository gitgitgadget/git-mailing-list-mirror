From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: b5227d8 changes meaning of "ls-files -x 'pattern'"
Date: Mon, 14 Dec 2009 21:21:06 +0530
Message-ID: <2e24e5b90912140751y5d769f15pa6782914bdb04dbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 16:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKDCb-0003VP-PL
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 16:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbZLNPvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 10:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757178AbZLNPvI
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 10:51:08 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:61628 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757044AbZLNPvH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 10:51:07 -0500
Received: by pzk1 with SMTP id 1so2353924pzk.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 07:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Q3nRFS9kLZwP3Uj8xC/NXn++KcM2UPQ10+JyH3bUcMQ=;
        b=v+h+Olzi6oLBhT3OJHGW4yZbBUQKPApopudNPSAze85SWCTvSM16cVP88PNnqQDp4l
         3rhyEUVcAYXFpKEUQ3oS7th2FgcqYXfP7mCR+H1WqNxM0bYAZ4U+bFsMsFU64oPa0DNJ
         6GV/wq99S+aZlUpQTO6efRBfojlcexQbnjHEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=iM+EIk2J42x9tD1bcbRxHUhcV6h1Gz8y/xSLPCiKPACbUrWfN5qN+mtHOUdSS+oDVh
         /i27PiJvGoTcBvX0knPKHpt1YJrBO0++F3gqVuMgDMVRAPbsmxqg7r+G+V2kD+1jkCyc
         HuoLTGUb0iVzDFO7avw2PSvZk2u9HDNoq0cTg=
Received: by 10.114.252.2 with SMTP id z2mr3311759wah.156.1260805866527; Mon, 
	14 Dec 2009 07:51:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135219>

Hello,

Before b5227d8, the following two commands would produce different
outputs (say on git.git):

    git ls-files
    git ls-files -x '*.c'

>From b5227d8 onward, they produce the same output.  The second command
no longer excludes *.c files.

I was unable to understand the commit message completely but it sounds
like this was intentionally changed to do this.

I've never been real clear on ls-files, and was wondering if someone
would be able to clarify the various ways of using it, including why
this change was made and is there a way (using some other combination of
flags perhaps) to get a list of files without *.c (to continue this
example).

Thanks,

Sitaram
