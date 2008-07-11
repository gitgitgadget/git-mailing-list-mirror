From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: git cherry-pick before archive
Date: Fri, 11 Jul 2008 12:09:02 -0400
Message-ID: <6dbd4d000807110909n1ced22eeraef45af441c20cca@mail.gmail.com>
References: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com>
	 <alpine.DEB.1.00.0807111649290.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:10:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHLCA-00030r-OX
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 18:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbYGKQJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 12:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYGKQJH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 12:09:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:9386 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbYGKQJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 12:09:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1561030fgg.17
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZRu/ErZhPz+KcX0NWvkHUZF9oNBO7Eh/YhsqE94nZy4=;
        b=B1acL9rgNTt0j0H+W++laMa7aqdShY6miGdoyTNOfvmHd2M/LEvXSAe0KTkadFiJgC
         a/u5JXNOMaU7hxUONd1bj3rPnNV4u7uIV7sp2JiV+aULh7+S8bzz8fKTXwAf/jMCRZVS
         rzIDzvM4eLp3J8NHPcL2uigALYK795DfT0kaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hBCl+9yOfZ/5LSwQD3BU/5PPtUdlMgODAa1WUrWZciUhjSiAK2ISqFkKpC6ww0ulQS
         hy40Ux3YNn/rlNumAMUoArh3UQ9ufCfAicB4dG8iXeWwxVcl9ocs00sQ8Yb0voq821gO
         DObCxEpITXOxmfJ1VIIn7ljAizGktud0Bwqkc=
Received: by 10.86.80.17 with SMTP id d17mr10114927fgb.24.1215792542886;
        Fri, 11 Jul 2008 09:09:02 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Fri, 11 Jul 2008 09:09:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807111649290.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88136>

On Fri, Jul 11, 2008 at 11:51, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> $ git cherry-pick -n <bla>
> $ git archive --format=tar --prefix=pfx/ $(git write-tree) | gzip > prj.tgz
> $ git reset

Thank you!  This is much better.  The only thing that could improve it
is by some way to "un-cherry-pick" the applied change (so that after
"git reset" there are no local modifications to the file(s) changed by
cherry-picking <bla>).

Is there an easy way to invert a patch to undo the change the original
patch introduced?


-- 
 Denis
