From: "Deepak Barua" <dbbarua@gmail.com>
Subject: git not tracking changes
Date: Tue, 2 Jan 2007 11:22:16 +0530
Message-ID: <b5a19cd20701012152n4f496198h93cab1b9b85a9a45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 02 06:52:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1cZU-0004o3-UE
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 06:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbXABFwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 00:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755270AbXABFwS
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 00:52:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:8865 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269AbXABFwS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 00:52:18 -0500
Received: by nf-out-0910.google.com with SMTP id o25so7210050nfa
        for <git@vger.kernel.org>; Mon, 01 Jan 2007 21:52:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pSIdmivbbmmVU6hIKS3h4C3g4WViJOixABDPR2eyyVCuhJL6G2+KYlfUie+qdKU8zNdOUWQbuON1lem6ZLstPZ238A4gjyM2MAY6r5PYNhsf+kXuyvaMzuVTZyiEUIaMjyqmPMt3gevG0S3ueo2VoOcJnicnZpxWPlov1tOilwU=
Received: by 10.48.245.17 with SMTP id s17mr22077897nfh.1167717136387;
        Mon, 01 Jan 2007 21:52:16 -0800 (PST)
Received: by 10.49.11.7 with HTTP; Mon, 1 Jan 2007 21:52:16 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35771>

Hi,
    When i do a git add of a config.h file then make some changes and
then do git commit it does not reflect the changes..
eg
dep@zion:~/programs/elinks/elinks-0.11-20061220$ git add config.h
dep@zion:~/programs/elinks/elinks-0.11-20061220$ vi config.h
dep@zion:~/programs/elinks/elinks-0.11-20061220$ git commit
nothing to commit
dep@zion:~/programs/elinks/elinks-0.11-20061220$ git commit
nothing to commit
dep@zion:~/programs/elinks/elinks-0.11-20061220$ ls
ABOUT-NLS     autogen.sh  config.h       configure     debian
INSTALL             Makefile.lib  SITES   TODO
acinclude.m4  BUGS        config.h.in    configure.in  doc
Makefile            NEWS          src     Unicode
aclocal.m4    ChangeLog   config.log     contrib       features.conf
Makefile.config     po            test
AUTHORS       config      config.status  COPYING       features.log
Makefile.config.in  README        THANKS
dep@zion:~/programs/elinks/elinks-0.11-20061220$

I am working on the hooks part modifying the perl script in the same
in the pre-commit hook but that is not related to this ...
what could be the problem...?

Also another file which you can see in the directory called "NEWS" is
being taken in to consideration...
the hook "pre-commit" is enabled and am adding a spell checker to it...
Regards
Deepak



-- 
Code Code Code Away
