From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Automating builds and testing of git.git
Date: Wed, 24 Mar 2010 22:07:41 -0400
Message-ID: <32541b131003241907l4b2bbf62j3430f78fba75643e@mail.gmail.com>
References: <20100325013352.GE4062@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 03:08:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NucUV-0007I0-BE
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 03:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab0CYCIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 22:08:05 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34595 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab0CYCIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 22:08:04 -0400
Received: by gwaa18 with SMTP id a18so2279388gwa.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 19:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:content-type;
        bh=/2ZB3LOfZ5hI1e540VQwQvz/XVK1tGlce72x5Wp/+wg=;
        b=JeMR8+wpFn+v1jUPO/ckASH0mC0CnlqP86eJtjEMMjJi3/7TeJZMmC2/EWxRpX1UqN
         fqBd4Q7TV9LbPkayS/NQBPZFg+OjETyEvYZefI0ySRHlCEZWoyhYe/ungF3z8uFm+s6y
         s1pCHhqzUi7HpjA6VgndYyU5DEwIAiqAFysmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=a06gnuWNLYZbQNMHuIsKqnhp2vEaMtic9CAIBlbNNiSvESjfoPh2FY9twYckdLrs1E
         DaXhodMDpMCtGAwQMyj+lE+haC9dO8w5T1s986F2OwSuqHFDXyvU49RI2+LiMk+EANiC
         uzHwlBsLA3vAH+snIPOai8iTB5tVWm7b9y8FE=
Received: by 10.151.148.17 with HTTP; Wed, 24 Mar 2010 19:07:41 -0700 (PDT)
In-Reply-To: <20100325013352.GE4062@kiwi.sharlinx.com>
Received: by 10.150.120.41 with SMTP id s41mr539250ybc.83.1269482881057; Wed, 
	24 Mar 2010 19:08:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143142>

On Wed, Mar 24, 2010 at 9:33 PM, R. Tyler Ballance <tyler@monkeypox.org> wrote:
> Howdy guys, I've been working on getting automated testing of git.git going
> over the past couple weekends (this is why I sent that FreeBSD related patch).

You may also be interested in:
   http://versabanq.com/demo/gitbuild/

It builds all the branches, not just the ones you specifically
configure, and bisects in case of problems.  (But since Junio is so
careful there are rarely any problems :))

Have fun,

Avery
