From: "Patrick Aljord" <patcito@gmail.com>
Subject: Re: Git Screencast ?
Date: Tue, 27 Nov 2007 15:18:22 +0100
Message-ID: <6b6419750711270618j35432bd7p47bbdfe5aa8f12bd@mail.gmail.com>
References: <fi1a9f$30q$1@ger.gmane.org> <86bq9n4469.fsf@blue.stonehenge.com>
	 <d411cc4a0711211603o525a25c4i3e04d0319e68204f@mail.gmail.com>
	 <d411cc4a0711261333p4c99f447k81c3833cd679e551@mail.gmail.com>
	 <6b6419750711270602q53e2c51dr7046aca1417c801a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:19:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix1Gu-0007Ba-Hy
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 15:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbXK0OSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 09:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbXK0OSZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 09:18:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:12377 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbXK0OSY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 09:18:24 -0500
Received: by nf-out-0910.google.com with SMTP id g13so963955nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 06:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fkQsAQtlF843MxmzvAzJspu6qau78NDYvdj7H6kWhsQ=;
        b=Lrxxewfz7lz+tNSadH6lv0o8MacD8hSMAFbUcTG1IDcaHtCZn7cpt/Q1QYH06Db/IXblMeZsUe68RRYjH/UUGSyw51Zo+9yHRtoipe3biAvr3Eyf834vsBMsQWP9WTVhxNKuRizYepf6SSWJvxs8WzaDbve9xwOiDKrA4A0JGhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c9sObfAX1FUU4TrQ7JyctnExvdROfH46BKNbowcZKO988Nz/HXo6jNhFlrWGq74olnVtxmTgsOsY9pMTaCjVJN1o6Mqn86TeQc1XuBB23GHd2GBFAS1Dyc98EvbHqN1we9pu73iZaUEmm8TpgHFR8W9CsAWZcttDJ+5TzBTOEaM=
Received: by 10.82.108.9 with SMTP id g9mr9839120buc.1196173102929;
        Tue, 27 Nov 2007 06:18:22 -0800 (PST)
Received: by 10.82.184.13 with HTTP; Tue, 27 Nov 2007 06:18:22 -0800 (PST)
In-Reply-To: <6b6419750711270602q53e2c51dr7046aca1417c801a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66215>

On Nov 27, 2007 3:02 PM, Patrick Aljord <patcito@gmail.com> wrote:
> > http://jointheconversation.org/railsgit
> >

I think you can just use 'git-init' now no need for git-init-db.

also once you've created your remote bare git rep, you don't need to
use scp, you can just do:
$ git-push --all git://server/remote.git

and to push there automatically:
$ git remote add origin ssh://server/remote.git
$ git config branch.master.remote origin
$ git config branch.master.merge refs/heads/master
$ git fetch
$ git merge master

also for adding new files, rather than doing "git add file1 file2
file3  etc" I just do "git add ." and put in .gitignore all the files
that I don't want to commit but I don't know if that's recommended :)
