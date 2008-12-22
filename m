From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: push to backup repo periodically fails with "not fast forward"
Date: Mon, 22 Dec 2008 19:19:26 +0200
Message-ID: <94a0d4530812220919t25233fa9ub461c86f10ec366d@mail.gmail.com>
References: <19016122-e19d-4885-8b0f-dec7b686c6ea@o4g2000pra.googlegroups.com>
	 <94a0d4530812220911l37b825edj55178658f24755c1@mail.gmail.com>
	 <f95d47890812220915h5286d2bdv7c8412ecf77be999@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Copeland" <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 18:20:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEoSU-0001CV-QO
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 18:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbYLVRT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 12:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbYLVRT2
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 12:19:28 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:14040 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbYLVRT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 12:19:28 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1214289fkq.5
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 09:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tisYYJqqmPs/2Ac+X4FL+ewM+YDsT3vTNtYAr2MHUvU=;
        b=Je/zjhTbCP3UGSa0t67Nam8pMtfV/aA0LI2yIWEx5v4TfPJK+vZXhfLQMSLCJVoj1e
         TEPZLb00/XjFzmbPHvWW/TPQDsYiZ/X5QWtkwDk+n5meM/nlHJad4u3C3w5/p+awg0d/
         oZaolredqh9ajtanuh9keMrwMrvy8dxCn7pZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ekH1egSvZsXXbIlswFk3E9KY6l57B796zztHS5xRS1Cwvnk0bE3m9mTMuHSt6KgAxs
         HQwrhGKBsDNlefQuAZ3aTuej1n00YFUGAgaoQ4J7ZLgc/OR5NPyad5e8aH99ny0yPLH0
         vv1/+LtpcuJSTNmOsB8ySqAtQm0uD6pC8R3r0=
Received: by 10.181.206.7 with SMTP id i7mr2090627bkq.57.1229966366225;
        Mon, 22 Dec 2008 09:19:26 -0800 (PST)
Received: by 10.181.148.10 with HTTP; Mon, 22 Dec 2008 09:19:26 -0800 (PST)
In-Reply-To: <f95d47890812220915h5286d2bdv7c8412ecf77be999@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103762>

On Mon, Dec 22, 2008 at 7:15 PM, David Copeland <davetron5000@gmail.com> wrote:
> the original gets rebased from a git svn rebase on occasion; so I
> guess that is causing things to not be fast-forward.
>
> I guess all I really want to do is keep a duplicate copy of my repo
> somewhere else.  Should I just use --force in my hook, or abandon git
> as the mechanism and use rsync?

I would manually do 'git push backup' at certain points since not all
my commits are meant to be backed up, specially on temporal feature
branches.

But --force should do the trick.

-- 
Felipe Contreras
