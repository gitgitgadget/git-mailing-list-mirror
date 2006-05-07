From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: symlinks
Date: Sun, 7 May 2006 17:47:49 +0000
Message-ID: <f36b08ee0605071047h32ccef4bk76ac360ada1331a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun May 07 19:47:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcnMG-0008Lt-QB
	for gcvg-git@gmane.org; Sun, 07 May 2006 19:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWEGRru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 13:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWEGRru
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 13:47:50 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:38601 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932211AbWEGRrt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 13:47:49 -0400
Received: by py-out-1112.google.com with SMTP id x31so1273543pye
        for <git@vger.kernel.org>; Sun, 07 May 2006 10:47:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TsymHhqCovAzzJUVC9oH0XQiB+DeC0hZNiFrS9pGYti0cjqgWxtsBJuuXsqbFHeR0CcLZQaFFnRn6fl2SzEl0h9Ot+KIzRBnBOjX78EOCmtlVRKG2/v91E335kpj/JJafSpSRuS43ceDZBgzigOij1FUQM9iP2Fy+XRFLs+SBIk=
Received: by 10.35.70.17 with SMTP id x17mr1759905pyk;
        Sun, 07 May 2006 10:47:49 -0700 (PDT)
Received: by 10.35.96.18 with HTTP; Sun, 7 May 2006 10:47:49 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19707>

Hello,

I have a project that makes heavy use of symlinks in the source tree.
I added it to git, then cloned the repository, and all symlinks were
converted to plain files. What am I missing to preserve symlinks ?

Yakov
