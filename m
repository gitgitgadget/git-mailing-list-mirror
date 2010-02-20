From: Ben Gamari <bgamari@gmail.com>
Subject: Re: Storing (hidden) per-commit metadata
Date: Sat, 20 Feb 2010 12:41:36 -0500
Message-ID: <1266687636-sup-7641@ben-laptop>
References: <1266599485.29753.54.camel@ganieda>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 19:59:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NitKr-0003i1-5W
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 18:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759Ab0BTRll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 12:41:41 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63158 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756712Ab0BTRlk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 12:41:40 -0500
Received: by vws11 with SMTP id 11so427690vws.19
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 09:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:subject:from:to
         :in-reply-to:references:date:message-id:user-agent
         :content-transfer-encoding;
        bh=cRt6FyxZAaJRTlkqf2cgKLgyfZRRUByM6gic+Yk7ucA=;
        b=JzMyYbItnnuAbW1/ZtMc4iC2d5P8gkvBH+lbvPDEnNOnP87xBhhtm/kS7um3aPLO5X
         rjpd5N7gMfYTqbseA+JrFDcuiU6rkzpwO9uJPnMpKoiaf/BxJycoFfwtKfmrS8nv9KWy
         0f5eVYRz7S5bChdN4axTc/yPx4XyOju107I7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:subject:from:to:in-reply-to:references:date:message-id
         :user-agent:content-transfer-encoding;
        b=LbhqfHuN26CVNrFALXqjl95xAv2CS741vT5lZ+zTvPOl4uZx1ssDKADAeJz6qSF5oZ
         jbHIwxI+C2AVZ8KtmHhXFCSoxCifC+V66Ep7yCML8RFVyG23gxOludMXpFmniPORN1cZ
         sKL61OjZyViTzwAtY/BiHdKNOnDcGknoE3pmA=
Received: by 10.220.127.17 with SMTP id e17mr5573024vcs.169.1266687699305;
        Sat, 20 Feb 2010 09:41:39 -0800 (PST)
Received: from localhost (208-58-69-114.c3-0.161-ubr2.lnh-161.md.cable.rcn.com [208.58.69.114])
        by mx.google.com with ESMTPS id 36sm13220468vws.17.2010.02.20.09.41.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 09:41:38 -0800 (PST)
In-reply-to: <1266599485.29753.54.camel@ganieda>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140540>

Excerpts from Jelmer Vernooij's message of Fri Feb 19 12:11:25 -0500 2010:
> To allow round-tripping pushes from Bazaar into Git, I'm looking for a
> good place to store Bazaar semantics that can not be represented in Git
> at the moment. This data should ideally be hidden from the user as much
> as possible; it would e.g. contain mappings from git hashes to Bazaar
> ids. 
> 
Are you sure you want to hide this? I believe git-svn puts this
information in its commit messages (although I don't know whether it's
stored elsewhere as well).

- Ben
