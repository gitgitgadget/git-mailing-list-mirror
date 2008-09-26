From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: A note from the interim Git maintainer
Date: Fri, 26 Sep 2008 14:24:31 +0100
Message-ID: <e2b179460809260624n4b329345q3610069af5af75c2@mail.gmail.com>
References: <20080924154632.GR3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 26 15:25:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjDKT-0002Y3-VY
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 15:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYIZNYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 09:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbYIZNYe
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 09:24:34 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:64219 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbYIZNYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 09:24:32 -0400
Received: by qw-out-2122.google.com with SMTP id 3so144712qwe.37
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ERBZDE8C/4X87pCGi2I1Q1VxPs3pm/Xc9ywiQOcjCek=;
        b=jasoiBv6CDefJ+nFO7fJREQwqciwsHcqm92lZvf1LgKmq+v4d/5jaeZjrKBlV6R9Rn
         Wz3Fxj0CWa6AZQzXcFYCwa2M+7lAm36ydp0hNOfbE5kTjXAQ4GJWsueiShCswe7MdklU
         1kHwPnrhEIDXOyvl4IDsqZsalw2BqTloOoniw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SCU39PaLIadaBaiuCPz9nWf0nQN2Yb7ZE8LPuRuIU1NVslNwVtwA6mMlBGEZYyNTnc
         tu3Lv1JqQjE2vb8iqOXcQ36tjcvmLGRQaPjVasHwvm3Un0AIKrKbr37nkoGBdh8mXkSG
         DkltFpjIgX5rewhYWErahQJQoG4Pul3SiVTJU=
Received: by 10.215.41.20 with SMTP id t20mr1123234qaj.22.1222435471657;
        Fri, 26 Sep 2008 06:24:31 -0700 (PDT)
Received: by 10.214.215.10 with HTTP; Fri, 26 Sep 2008 06:24:31 -0700 (PDT)
In-Reply-To: <20080924154632.GR3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96849>

2008/9/24 Shawn O. Pearce <spearce@spearce.org>:
> My tree is being published here:
>
>  git:    git://repo.or.cz/git/spearce.git
>                  repo.or.cz/srv/git/git/spearce.git
>          http://repo.or.cz/r/git/spearce.git
>
>  gitweb: http://repo.or.cz/w/git/spearce.git
>
> The usual maint/master/next/pu stuff applies.  I'm basically just
> picking up from where Junio left off.
>
> I would appreciate it if anyone who normally tracks Junio's "next"
> or "master" branch for their production work can switch over to my
> next (or master) branch for the next few weeks.  Something about
> many eyeballs and fewer bugs.

Now there are new commits in this tree, Gitbuild
[http://repo.or.cz/w/git/gitbuild.git] has spearce/master,
spearce/maint and spearce/next branches and I'm currently running my
automated AIX test builds on these branches and pushing the relevant
tags along.

Jeff, if you want to switch your BSD builds to Shawn's tree too, I
made and pushed a tiny change to the gitbuild.sh script to allow for
the spearce/{branch} format becoming spearce_{branch} in the tag
names.

Cheers, Mike
