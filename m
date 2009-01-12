From: mark <markkicks@gmail.com>
Subject: git log, outputs something weird for colors
Date: Mon, 12 Jan 2009 13:51:53 -0800
Message-ID: <82fa9e310901121351y22feaf21rfb880bcd0d6cb1a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 22:53:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUio-0001e5-PL
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbZALVvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbZALVvy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:51:54 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:13214 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbZALVvy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:51:54 -0500
Received: by rv-out-0506.google.com with SMTP id k40so10405091rvb.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 13:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=1z11Jw7jxMXL4w44LcpfsFuJFNBMaY/72CiifPI4IzM=;
        b=I7dz2qKze4Ar7myqz767WX+UmoRTnq0mYiCL+RNl8AxOMrVfo3qdbH3SAVBUPvoyN5
         3rJxOQvVVudtKyMizteUNS0Xge4jKzYkS3mAoAqMHoRiO4mzuToiQu+lg+9CQoyKutDv
         pmk7bGzuJ9oxkQa/5sm1FboUAkQ9067RllQDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=uRSI8A0n2CTIpskglCWu8osH2o6pkkidwSvr08lQ9jCh7XvrOwRTPGZxwKZixgek86
         kqU4q1tPiVoAMGrBkLAk7Dqg2uixSa6F+kXIL4zO59PNkj3sPN0e0ntLYZSYB85W8pCr
         dmIj3erG68jr0cxBSBr5dffwfmaYzb05SuKAU=
Received: by 10.114.185.8 with SMTP id i8mr19800736waf.85.1231797113395;
        Mon, 12 Jan 2009 13:51:53 -0800 (PST)
Received: by 10.114.59.17 with HTTP; Mon, 12 Jan 2009 13:51:53 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105396>

hi
i am using kde konsole, and i am getting weird output for colors, for
example for git log i get the following output


git log
ESC[33mcommit 8b918256d944221f741e5d7300873810e31466a6ESC[m


settings in my bash and git.

export | grep -i term
declare -x TERM="xterm-256color"


~/.gitconfig
[color]
 branch = auto
 diff = auto
 status = auto

do you know what is wrong?
thanks
