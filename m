From: Steve French <smfrench@austin.rr.com>
Subject: cherry pick FROM remote repository
Date: Fri, 11 Aug 2006 15:44:38 -0500
Message-ID: <44DCEC36.20403@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 11 22:44:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBdrY-00040d-MV
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 22:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWHKUoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 16:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWHKUoF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 16:44:05 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:59324 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932421AbWHKUoB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 16:44:01 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7BKhwHP009786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 11 Aug 2006 16:44:00 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k7BKhw71267394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 11 Aug 2006 16:43:58 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7BKhwvQ018090
	for <git@vger.kernel.org>; Fri, 11 Aug 2006 16:43:58 -0400
Received: from [9.41.38.127] (smf-t41p.austin.ibm.com [9.41.38.127])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7BKhwIB018067
	for <git@vger.kernel.org>; Fri, 11 Aug 2006 16:43:58 -0400
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25238>

Has anyone written a script (or seen a tool) that can do
    "get this changeset from repository at this git url and merge it 
locally"
something like a
    "git-cherry-pick <commit> <remote-git-url>"

I have seen examples of how to cherry pick push files to  a remote 
repository
