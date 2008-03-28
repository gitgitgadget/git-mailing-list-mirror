From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Re: git-svn merging into branch?
Date: Fri, 28 Mar 2008 09:34:33 +0100
Message-ID: <ae63f8b50803280134v1d24854dwacd21a1ef95951ed@mail.gmail.com>
References: <AF82B803-0999-4C9F-95EE-184E829F2569@faithfulgeek.org>
	 <B3FD53D6-CB70-4D21-ACE2-7B9D4B19F675@faithfulgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Joe Fiorini" <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 09:35:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfA3S-0002Tn-87
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 09:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbYC1Ieg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 04:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbYC1Ieg
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 04:34:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:63451 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbYC1Ief (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 04:34:35 -0400
Received: by nf-out-0910.google.com with SMTP id g13so55175nfb.21
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=RO3/ivf6G30hRsv3FlNB8P6y/zG0Izn96HCAVoeLmVM=;
        b=Dq6Ljt0TeXYKinNc6DTho1Fb7hp2k2r6YaCCOm+S0TcexlvuaG57EvSmMiwG6mPanmb3dk6Za1aiRLWwvLPeKXDiS6VGDFR/ZyyxovC0wwrAgjgVrIIoJVu3RjN7AnLvVQKrSL/Pqg4WQYXSrnk1SBIhjQa8JswJf+pOfX+pnMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=heVSYR7EVYhMLmVk71boJY6QvkLEtIcSZe08LJYg/87/bf6x04EvD16WtWQi31ppqaamZEDDPw/PXBgP1C/10c0shmY903jdbKc+oUdry02IWx8BLGeeyPKd58r3rbnkQTE7z8s+bxUFOQj5gsa2JBTuACEGsZL0q/7dnJ9zpVA=
Received: by 10.78.188.10 with SMTP id l10mr7877288huf.53.1206693273743;
        Fri, 28 Mar 2008 01:34:33 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Fri, 28 Mar 2008 01:34:33 -0700 (PDT)
In-Reply-To: <B3FD53D6-CB70-4D21-ACE2-7B9D4B19F675@faithfulgeek.org>
Content-Disposition: inline
X-Google-Sender-Auth: 4ba503738444f118
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78392>

You can either use SVN-specific tools, namely svn merge or svnmerge,
or GIT-specific tools, namely git merge, git rebase or git cherry
pick.  If you choose the latter, once done you can simply git-svn
dcommit your changes.

Cheers,
-- 
Jean-Baptiste Quenot
http://caraldi.com/jbq/blog/
