From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: multiple .gitignore and friends in same workdir possible?
Date: Fri, 23 Apr 2010 15:01:42 +0200
Message-ID: <y2kfabb9a1e1004230601zcede9e2ah2db8cb0f082bcbb4@mail.gmail.com>
References: <4526533254752708319@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Konrad Karl <kk_konrad@gmx.at>
X-From: git-owner@vger.kernel.org Fri Apr 23 15:02:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5IWL-0007Mm-JQ
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 15:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739Ab0DWNCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 09:02:07 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:59957 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab0DWNCF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 09:02:05 -0400
Received: by ey-out-2122.google.com with SMTP id d26so911276eyd.19
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=GuwPWTXi7ZoJEu1WkmYwv8gAPrZlX2vV8+lGvR5mF0U=;
        b=Y6TNKiz2MnsDt12h3gkEu20BZ3q5w6S3bqwqcMnXT+qYcfzjE0QLYKWcThwthcObjh
         5ATWWKQ2EZdXl1MfD/U0nFMxsXmwWiJQe9l6vgEU4mT6KoJGZIBAm5KmQBpdO0zSWKSu
         G3E8ArLyq5sUdzL2MDHE2EFKztytyCUXwIp8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xKw0TiVZxCKrjYDLZwyee9yaJaukLKDwppk4tvq691HVEoMng1+tnWXCibsmNroa1Z
         M72wnY0XI3/qW2VoyHvR/On/fDq1+Tk8mvJD/SAo4qmEFFFNpczp/n1AmQrJBMZX1Jr7
         Slqb0odMLbS3xIUCK2ciq7R96n+xOriypLLDw=
Received: by 10.103.168.14 with HTTP; Fri, 23 Apr 2010 06:01:42 -0700 (PDT)
In-Reply-To: <4526533254752708319@unknownmsgid>
Received: by 10.103.141.3 with SMTP id t3mr3354615mun.48.1272027722073; Fri, 
	23 Apr 2010 06:02:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145615>

Heya,

On Fri, Apr 23, 2010 at 14:46, Konrad Karl <kk_konrad@gmx.at> wrote:
> Is this currently possible or am I missing something? It would ease
> my task a lot.

I assume that each repo has it's own gitdir, in which case it has it's
own config file, so you could just use "git config core.excludesfile
.gitignore.one"?

-- 
Cheers,

Sverre Rabbelier
