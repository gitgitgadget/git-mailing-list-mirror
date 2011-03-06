From: David Barr <david.barr@cordelta.com>
Subject: Re: [PATCH v2] vcs-svn: prepare to eliminate repo_tree structure
Date: Mon, 7 Mar 2011 07:41:33 +1100
Message-ID: <AANLkTimX1+hZGZ-y01ePCdWhPmwjUFpUbJe1-iB4GQrq@mail.gmail.com>
References: <20101210102007.GA26298@burratino>
	<20101210102806.GH26331@burratino>
	<20110306125259.GA20010@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 21:41:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwKlp-0005hL-Rm
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 21:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421Ab1CFUlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 15:41:35 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52760 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab1CFUlf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 15:41:35 -0500
Received: by wwb22 with SMTP id 22so4489190wwb.1
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 12:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=BsBA/c9KEtQTfRjLgXXxdAqXcKQWlLHUWuTD4x2sRTs=;
        b=C+miIUdzOmDWAzPibLen/WKpkc9T6s7vwfNCis7yXW8jx65HcEmnQ+mKOzb7QOnOcr
         v8q5a2Zt1dfhYIAY1y1hy53w3sQztqxb+EQ+y97x+I4ETg7c0y1XxfCFdZ0E7VECvEU4
         UUWihLWisukzL0VNrOIrKokVcBbI/5oRv/0zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=HhvTQN9zDL7pv10zQE5wGDyS+/xPt8/memJZ5U++fkKHvJxAWA/S97J74hHs65FFo6
         l3CeU5xHVQnlnVgHFYlH2BhYxmMb9BsS2Se8oOyWtb3RddME8DopmHo+x2YDh6Ocwr7M
         7TfE0nC3A17VgGWpAI1yF0WCniRN0n7PevGAg=
Received: by 10.216.209.230 with SMTP id s80mr2728434weo.26.1299444093526;
 Sun, 06 Mar 2011 12:41:33 -0800 (PST)
Received: by 10.216.19.79 with HTTP; Sun, 6 Mar 2011 12:41:33 -0800 (PST)
In-Reply-To: <20110306125259.GA20010@elie>
X-Google-Sender-Auth: J9ivfDa1Bo7WxUF23m6xnIRywAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168530>

Hi,

> David, may I have your sign-off on this series (the
> vcs-svn-incremental branch)?

Absolutely, I've updated my branch with the correct sign-offs.

Please pull

 git://github.com/barrbrain/git.git vcs-svn-incremental

for the complete series of back-ported patches to support incremental
imports for vcs-svn.

--
David Barr.
