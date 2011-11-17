From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Thu, 17 Nov 2011 10:36:47 +0400
Message-ID: <CACf55T6nHTv3knUo0PvmqqPO7JXKf+o5H5ESLoPr9b=ZW5kudA@mail.gmail.com>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 07:36:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQvaf-0006cx-Dq
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 07:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744Ab1KQGgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 01:36:48 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59541 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab1KQGgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 01:36:48 -0500
Received: by iage36 with SMTP id e36so1692126iag.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 22:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=U7Va8K05tiKxTGtR0xLnmSHdWW2/xQ6NLk748s2IVz8=;
        b=bm5+ge47LC7tblTNqU/lFe92nq2QOcBG65+jQrRfLaWoxGF2OtOk4ytP3LAK34wGmk
         COHbI7tyzr/U7U69kafPg7oKsvTvHA08LMBBUh89KrijdLSXKsgdQrQAm2Onq4wRlycH
         GkMWjUpkFG2mIAp+ODeeBP8kxdUDTiDDZGt9A=
Received: by 10.42.136.196 with SMTP id v4mr39014318ict.3.1321511807226; Wed,
 16 Nov 2011 22:36:47 -0800 (PST)
Received: by 10.68.66.230 with HTTP; Wed, 16 Nov 2011 22:36:47 -0800 (PST)
In-Reply-To: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185575>

I had fixed the problem by manually installing the most recent version
of the libcurl3-gnutls for Ubuntu (from precise):
http://packages.ubuntu.com/precise/libcurl3-gnutls
It will require also most recent libgnutls:
http://packages.ubuntu.com/precise/libgnutls26

Dmitry
