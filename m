From: "Tyler Silcox" <tsilcox@gmail.com>
Subject: After successful push, all files are listed as modified, uncommitted changes on origin server
Date: Mon, 28 Apr 2008 11:34:12 -0400
Message-ID: <1d2b97db0804280834g8457151q658f54ff66e469@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 17:36:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVO2-0004wa-NO
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 17:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933403AbYD1PeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 11:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933537AbYD1PeP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 11:34:15 -0400
Received: from el-out-1112.google.com ([209.85.162.176]:2363 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933971AbYD1PeO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 11:34:14 -0400
Received: by el-out-1112.google.com with SMTP id n30so1564536elf.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=OscVcLwx1IaZYWvT0WW3gTM4R1pFzwxgtjxAe1IFaIU=;
        b=mfK2hbxJMSJ2SfQlLlKnlDQx4MZ8SJuBDFI6LYXwXMHIL78+8+dT9BGhCxehWmAgWblfuy6tTtgiTXUSi8wLsTdq7b2YEpH2WNR6pvjdwd3/X+b3cLS1umxUQDfoJWb60Szq3Q/PRRJznnUer58kioaJpFu/mxmk4e+bfm8AM88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=xruSZ1Qoflg8xafaWIEM6WMKNMR+ilZhDU8loPMlorIdIppawEbwB4ZfXkPxha/kfZnf6My1XepzEeCjbKcg8olC+Rxa9s1X4lff+nAOuGVWnZdUofo3pLQx71KobTnym8U+g7mrs+PFUFBb9fAVAjQrF8/zQI8blDAwRrXLW4o=
Received: by 10.140.174.11 with SMTP id w11mr558093rve.17.1209396852632;
        Mon, 28 Apr 2008 08:34:12 -0700 (PDT)
Received: by 10.140.172.12 with HTTP; Mon, 28 Apr 2008 08:34:12 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80548>

Myself and another developer are both experiencing this 'issue'. We
will run a local commit and pull (on Macs), then push to the origin
server (which is on Windows.) If you view the git status, it will list
all files as modified, but I can't pull any details about what was
modified with diff. In gitk, it shows all the files under 'local
uncommitted changes, not checked in to index', but again, it doesn't
tell me what was changed, it just lists the file names in the left
column.

I'm thinking it's an OSX file browser process that is modifying the
files' meta data when git is checking the repository. It is not
affecting our workflow, but it is an annoyance. Any info that can help
prevent this would be appreciated.
