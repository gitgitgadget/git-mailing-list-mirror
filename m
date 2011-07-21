From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: can I use multiple worktree in same git repo ?
Date: Thu, 21 Jul 2011 11:17:57 -0700 (PDT)
Message-ID: <m3sjpzsdll.fsf@localhost.localdomain>
References: <20110720182438.3c40cf1d@shiva.selfip.org>
	<CACsJy8CLRjLag65H6KQ1AUABLwiL09wNQw3VH8Y-JQnw7CqLUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bakshi" <joydeep@infoservices.in>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 20:18:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjxpG-0008Tx-Tv
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 20:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab1GUSSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 14:18:12 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:47517 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab1GUSSA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 14:18:00 -0400
Received: by fxd18 with SMTP id 18so3903329fxd.11
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=XHJ+OmVO16Mh3xkKmoLjjSm/brRZTFcY21ILN+inSEo=;
        b=NbMEM/ZhWkQUf5Gx4F9WiPbEiiFHFf5apl0H0WW2cLcHPUoq6X4CS7FYVR50gRuwhh
         PzTfhs9qTgO8RKbWMJhVvbk7dk2/9UxOW/jZlXN0ZwNRcStlJv1+56YLRTgNTFjoKjBG
         IegiDso2ZFeHqmCZxcI9Y61ZHaQDMD5ib3Jiw=
Received: by 10.223.159.197 with SMTP id k5mr679572fax.50.1311272279014;
        Thu, 21 Jul 2011 11:17:59 -0700 (PDT)
Received: from localhost.localdomain (abwr62.neoplus.adsl.tpnet.pl [83.8.241.62])
        by mx.google.com with ESMTPS id j19sm1547464faa.41.2011.07.21.11.17.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 11:17:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6LIHQfE004150;
	Thu, 21 Jul 2011 20:17:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6LIHAvl004145;
	Thu, 21 Jul 2011 20:17:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CACsJy8CLRjLag65H6KQ1AUABLwiL09wNQw3VH8Y-JQnw7CqLUw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177605>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Jul 20, 2011 at 7:54 PM, J. Bakshi <joydeep@infoservices.in> wrote:
> > As a result whenever there is a commit , it updates the related folder in filesystem.
> > Say a commit at svn->mysite-repo->dir1->trunk->src ==> modify ==> /var/www/demo/dir1
> >
> > Can I do the same in git with multiple worktree ? possible ?
> 
> Using multiple worktree with the same repo won't work in git because
> the repo also have worktree-related information. [...]
[...]
> Also have a look at git-new-workdir in contrib directory of git
> repository. I don't use it but you might find it useful.

Actually with git-new-workdir you can have multiple working
directories associated with single repository, by the way of symlinks.

Note however that if you intend to *work* in those workdirs, they
better correspond to different branches... or you can mess something
heavy.

-- 
Jakub Narebski
