From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How can i write a new protocol for git
Date: Fri, 05 Sep 2008 02:38:56 -0700 (PDT)
Message-ID: <m3hc8vortf.fsf@localhost.localdomain>
References: <976e6d070809050222v1580ae53ye96dee913d44ae4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sky Patrick" <patricksky852@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 11:40:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbXnU-0000ac-VN
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 11:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbYIEJjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 05:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbYIEJjA
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 05:39:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:51790 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbYIEJi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 05:38:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so684515fgg.17
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=uGiJcU0iAkcaoxZU9dAzbXeUFjR+McmYnsIpfAIBKdY=;
        b=ByLMtc2O0YWUMV0cSapaMEYxQaDbuCD07Pop7mLbCvV/QOG4zbgPA00gm1wHc0suDg
         YjIAlm5c2THOXnx3RMsnuMxp7pKyTI26yJSbjpWjkAt+lYl05Y7LHioGYEUBz6GLcBoj
         tCGCXQnstvltfB8OknS3IkTrioMALyzpAvhq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=FMSOtW0cyRMtQ2rOFlE3j94kNltrsIbP+cd+K7K1QdthWaImFSDWJ/x2RNFNhtOksb
         n4xhY/8goxdtm1Ag0U7mLW3LkR9yUxrQ9OFrzhQ4OKiIVbZIfSiR7sCJ1l6RE5w1wNf3
         N6fLzMiG49z8wgYhshMKKxKashVTp+EOW8BHk=
Received: by 10.86.60.15 with SMTP id i15mr8608286fga.14.1220607537630;
        Fri, 05 Sep 2008 02:38:57 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.238.224])
        by mx.google.com with ESMTPS id 4sm779410fge.8.2008.09.05.02.38.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Sep 2008 02:38:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m859csrH024834;
	Fri, 5 Sep 2008 11:38:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m859cqhB024831;
	Fri, 5 Sep 2008 11:38:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <976e6d070809050222v1580ae53ye96dee913d44ae4b@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95004>

"Sky Patrick" <patricksky852@gmail.com> writes:

> If i want to write a new protocol for file transfer and would like to
> to integrate it with git. Is it possible and easy to integrate it ?
> Currently, i know that jgit may achieve it, but it is a Java
> implementation and may not work with git command line program that
> written in C.

What is exactly what you want to achieve? From the above it is not
clear if you want to add support for new protocol in git (like
amazon-s3 support in JGit, or currently in the works smart HTTP
transport (HTTP POST)), or perhaps you want some separate application
using some unknown file transfer protocol to somehow integrate with
git; but what this integration is to be?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
