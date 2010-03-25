From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Reuse .git directory.
Date: Thu, 25 Mar 2010 23:28:39 +0530
Message-ID: <f3271551003251058y45a37ea2n9867fc1abbb50a07@mail.gmail.com>
References: <10467746.91269539410487.JavaMail.mvaidya@mvaidya-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 18:59:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NurKm-0000EH-4g
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 18:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab0CYR7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 13:59:01 -0400
Received: from mail-yx0-f200.google.com ([209.85.210.200]:50364 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab0CYR7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 13:59:00 -0400
Received: by yxe38 with SMTP id 38so4526657yxe.22
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=e/d1oh5dIo7hGUNo5uCAvZjcFsFXGUkSkfx/p6MFtJo=;
        b=Oo8gxenriOg58B5FeX56Ytauy41BRWH9bjM4AgINsJQSWvs198T844gl110Ccfdst6
         6vDD3NuRI+ZixKudqfKSfouYCWc6FhjckuWMFefLHlvPy1dSltPVkbngxEN5gt5RGOcQ
         TylQbojF7Jngw3B/16aNevTgbx3RT3aXiAs7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=i4t1wuJrwUkA7yMFtzCP2xa5zFkHFwprNfZ7M2rKgBVRFZLDrPTdPp+AxotRLYamsw
         RslfSjnYvwtu8+iY7+6gP0366cFbXMYIUL5YBuJKQZ+V1dL4azXwqSuJ+Sc2k2bbHlQt
         jqnl5HelltiilalsovAANyf6bzMcpUN1jxGKs=
Received: by 10.142.208.20 with SMTP id f20mr4121205wfg.54.1269539939124; Thu, 
	25 Mar 2010 10:58:59 -0700 (PDT)
In-Reply-To: <10467746.91269539410487.JavaMail.mvaidya@mvaidya-desktop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143188>

Hi,

> I would like work 4 different branch simultaneously viz.
> master, feature, bugfix, expt but would like to use same same GIT_DIR. Is this possible ? so that I can save some space ?

All Git branches *are* contained in the same GIT_DIR. I'm not sure
what your question is, but I suspect you don't understand how
branching works in Git. Please read up some introductory material on
this.

-- Ram
