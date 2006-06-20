From: Alexander Litvinov <lan@academsoft.ru>
Subject: Re: [PATCH] checkout -f: do not leave untracked working tree files.
Date: Tue, 20 Jun 2006 18:27:50 +0700
Organization: AcademSoft Ltd.
Message-ID: <200606201827.50808.lan@academsoft.ru>
References: <449557B6.1080907@garzik.org> <8764iw5bvl.fsf@gmail.com> <7vfyi09isf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 13:28:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FseOu-0006Rh-Qn
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 13:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWFTL2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 07:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbWFTL2F
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 07:28:05 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:2463 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932598AbWFTL2E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 07:28:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 5C3B2BDE0; Tue, 20 Jun 2006 18:28:02 +0700 (NOVST)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03125-09; Tue, 20 Jun 2006 18:27:53 +0700 (NOVST)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 37C21BDDF; Tue, 20 Jun 2006 18:27:53 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 216538DA0451; Tue, 20 Jun 2006 18:27:53 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 725C88DA044F;
	Tue, 20 Jun 2006 18:27:51 +0700 (NOVST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7vfyi09isf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22193>

Good news. I have a habbit to switch branches using two commands:

git checkout -f second-branch
git clean -d -q

Now this will work with single command. Thanks.
