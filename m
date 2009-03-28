From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Getting GIT+git-daemon+gitweb working properly on Fedora 10
Date: Sat, 28 Mar 2009 23:18:36 -0000
Message-ID: <12F76915BCBF4FAAB0E3C18BCC2528D5@HPLAPTOP>
References: <EA1460555FA0423EB6C233B3B0F4F098@HPLAPTOP> <37fcd2780903281351w6f77a647kd44a9afe4d2ee953@mail.gmail.com> <AE2ECDC6B332479293D910D9352DCF21@HPLAPTOP> <8c9a060903281501t268897d1pe2afa2f82fd2fd3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 29 00:20:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnhp1-00055D-Sf
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 00:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbZC1XSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 19:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177AbZC1XSo
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 19:18:44 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:2869 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbZC1XSo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 19:18:44 -0400
Received: by ey-out-2122.google.com with SMTP id 4so453880eyf.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:references
         :subject:date:mime-version:content-type:content-transfer-encoding
         :x-priority:x-msmail-priority:x-mailer:x-mimeole;
        bh=qFlEzXUG9+sgTgI+la19U7SgYWV6Ba+m9Fs3s9GghEw=;
        b=Y7+W1IXIRKxSHt/g0WPWcWXDg8daTSeRz9jbiwJaX5cxAuIXtUIWVuqEJrl/vuietz
         fqeTw41hdSSfCnVI7sNxB+Vy1xV7sUrVUisfDam9qL00OgWm4W8135i0XQgK8evmlmlt
         VjcVovdKv4D503ezNSkZ2GRSqm47wbn7hOOaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=E2bJEKrUxoUCaVEb39qvLytd6cdURvLnbWzBl5zvWvZpatzKhkRhzuCdVQQFqsImef
         b6pDIKZmpoPmLTof55eIZ4gngox+77uoMXfhoU535MxzrLiotnT/JZBNEVA99JFDBt2s
         rY2zpOHtD1Ox60RIiJU8cdc4U4rywRr89E/eI=
Received: by 10.211.178.8 with SMTP id f8mr2833647ebp.91.1238282321559;
        Sat, 28 Mar 2009 16:18:41 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 7sm3701008eyg.27.2009.03.28.16.18.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 16:18:41 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114992>

gitweb is showing a repository last changed on the front page 2 days ago but 
in the summary is showing a change 3 hours ago.

I am getting different behaviours from different repositories. on gitweb and 
in their base directories some have file some donot. The ones with files 
have not been checked out and will not commit either.

What I need is a well written set of instructions on how to import both 
small and large SVN repositories and how to serve them and how to get gitweb 
to reflect actually what is going on.

Thanks,

Aaron
