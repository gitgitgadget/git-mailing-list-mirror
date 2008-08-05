From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT v2 PATCH] Do not mess-up with commit message formatting when sending email
Date: Tue, 5 Aug 2008 21:48:27 +0100
Message-ID: <b0943d9e0808051348x7130f26cy4a233ea35ee9a5d0@mail.gmail.com>
References: <20080804141640.GB12232@diana.vm.bytemark.co.uk>
	 <20080804151913.4269.74254.stgit@dawn.rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com, git@vger.kernel.org
To: "Samuel Tardieu" <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Tue Aug 05 22:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQTTH-0000rM-AS
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 22:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758834AbYHEUs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 16:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760774AbYHEUs3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 16:48:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:32683 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbYHEUs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 16:48:28 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1893625waf.23
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=r3tQBu5FNmEGPnXjhn+/O3rtd8N9F/L3m684RCLxsgk=;
        b=J8q8Td7fwUuP64rIhvP1ug8FPTnNAte5fcTePt2Y0SRGpjAnvSU6Jx+b9EJbAyAlCs
         3By/cdND+JUZ+sVinT/q62LDgtYQDOf+ZBT+TaeMm+GD0XiKqi5m7+AD2vwJa3HyCZZU
         pRpU7Z1XRSPzInRjuNILElrYNZ5AqLaoPxGBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fBSsS3SdWtosQ/TJfd/SvA1BR8/qgBw5dKPYuWzvy5XPo4qNKbQhthtmTP3wjE6fjE
         SLPjrcXRRopH00WPbD25RrAp1aOmHe72qfGVRHBgZIuY7iYSEseC1dvBCUNLZKQJ7ijT
         +KoPKPyKSLFX9ScJb5pdHP7L0pgWhd0drwLpc=
Received: by 10.114.191.12 with SMTP id o12mr191795waf.224.1217969308015;
        Tue, 05 Aug 2008 13:48:28 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Tue, 5 Aug 2008 13:48:27 -0700 (PDT)
In-Reply-To: <20080804151913.4269.74254.stgit@dawn.rfc1149.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91461>

2008/8/4 Samuel Tardieu <sam@rfc1149.net>:
> The short description, which will be used as the email subject,
> gets its leading and trailing blanks removed.
>
> The long description gets its trailing blanks removed as well
> as any leading empty lines. Leading blanks are left untouched
> to preserve the formatting.

Thanks.

-- 
Catalin
