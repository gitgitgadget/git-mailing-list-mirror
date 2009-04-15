From: Li Feng <nemokingdom@gmail.com>
Subject: RA layer request failed while git-svn fetch
Date: Wed, 15 Apr 2009 11:31:02 +0800
Message-ID: <f18356030904142031n2db32fcyc035a87b6797fee5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 05:32:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltvrd-0002n4-0e
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 05:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZDODbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 23:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbZDODbG
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 23:31:06 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:16694 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbZDODbE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 23:31:04 -0400
Received: by ti-out-0910.google.com with SMTP id 11so417562tim.23
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 20:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=fMskVbKZxoE3xYXwMjoVIc4KLQJM7UIwARk4Nco6iRc=;
        b=LeB3wsj/OfvqrWkdNp9QmzP89niSddSK+ddUGrD7wu2vD8V87BC/nqm4shmRV8PuUb
         yoRNiN5eg7Zeg1UVXTwM1u/wNxykpzugn6LBoOeEwg4RxToVXFzYu3keSMAdTGOyZnt5
         2IL+yoWCI/eQNReWIn37hrsbhkVI3NkNkzLSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=KrzSrTueFKu3iNUQBMWxK0W/QEfk2+hTexF5RxMis12PmKMptdwV2DC9UgSNYNjsqy
         HK/ZD5PA+fbuV9Ch6FO+//ADVE6Sn8mEXM0OuQNI3WOYo55O/zfaZLB9p5YZH1qk3hGy
         R4p0Jfw4Fl47heNxHFI0xnKD5exXzztJd6858=
Received: by 10.110.62.4 with SMTP id k4mr5053891tia.11.1239766262617; Tue, 14 
	Apr 2009 20:31:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116587>

Hi,

I don't know if this is a proper place for asking this
question, let me know if it's not.

I use git svn to sync with the subversion repos:

$ mkdir prj && cd prj
$ git svn init http://url/to/repos/branches/experimental
$ git svn fetch

and got the error message:

RA layer request failed: OPTIONS of 'http://url/to/repos/branches/experimental':
Could not read status line: connection was closed by proxy server
(http://url/to/repos) at /usr/bin/git-svn line 1352

Why and how can I fix this?

Thanks,
Li Feng
