From: Russell <russellsteicke@gmail.com>
Subject: Re: git as a backup tool?
Date: Tue, 15 May 2007 13:09:06 +0800
Message-ID: <c1b8b6670705142209x267e44cbrea26aa8818275aea@mail.gmail.com>
References: <Pine.LNX.4.64.0705141334120.20215@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 07:09:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnpHb-0000xO-QE
	for gcvg-git@gmane.org; Tue, 15 May 2007 07:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbXEOFJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 01:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756330AbXEOFJI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 01:09:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:17091 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406AbXEOFJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 01:09:07 -0400
Received: by nz-out-0506.google.com with SMTP id r28so12425nza
        for <git@vger.kernel.org>; Mon, 14 May 2007 22:09:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mx2NRVHEw1u+zjyTiT96+SDQv3g7B9dD2ztdO3404YJYS8EiMrHQiPDLqRSpg/u4jWxASqugsKychGNnTQFOaeNW9yPB2kQios7iUSYfgyPVmWB7CyhjBbIbyhCNwqu80YSr5aIc47uUVYYPsYbuHrDXuO8bPZrqqpj389VTyWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tpvi6fI7cE5GN/FLfPvk7r1HFUjIk0D+744uIU+FEKEHGXoBNclGllieDRHY+3MPhMcClfhY4j9txVCCaUsUHsGOlETIHgVaZdptjK7rYXbD3IzCPDBR+jFUJzwbmCakH8XKwNC4zJRSM0e1+XsK26zs3DMrCeOMF+cPLcDwh3g=
Received: by 10.114.102.1 with SMTP id z1mr1342662wab.1179205746178;
        Mon, 14 May 2007 22:09:06 -0700 (PDT)
Received: by 10.115.76.9 with HTTP; Mon, 14 May 2007 22:09:06 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705141334120.20215@anakin>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47314>

On 5/14/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>         Hi,
>
> Has anyone considered using git as a backup tool?  I.e.
>   - put your whole file system in git
>   - do `git add .; git commit -a' from cron
>   - copy .git to external media once in a while
>   - clean up old stuff (unused and older than xx days) from .git

I'm using git to backup my private email, all in Maildir format, in
that manner.  In addition, I push to a remote bare repository
automatically, using ssh host keys.

The most annoying issue was trying to prevent spam getting stuck in
the mail history.  I do this by having the "unsure" mail folder in a
different place, and then having a symlink from the mail store point
there so mutt can still find it easily if needed.

Backing up a whole home directory would require careful thought about
what _not_ to backup, similar to the spam issue.  You probably
wouldn't want to backup things that you download off the net and can
easily retrieve again, like foo-1.2.tar.gz etc.

I'm not sure what you mean by cleaning up old stuff.  git (or at least
my usage of it) requires the whole history to be in the repository.  I
haven't looked at shallow clones or other ways to prune history.



-- 
Virus found in this message.
