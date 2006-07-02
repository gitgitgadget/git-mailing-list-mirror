From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Sun, 2 Jul 2006 23:33:55 +0200
Message-ID: <e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com>
References: <e8954u$srh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 23:34:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx9aK-0001HE-AD
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 23:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWGBVea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWGBVea
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 17:34:30 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:42173 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750928AbWGBVe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 17:34:29 -0400
Received: by py-out-1112.google.com with SMTP id n25so1169320pyg
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 14:33:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i9SBO6Kotb3e+MoqH/ob2TOsewqvpo843kH3nfkougYEnrupBEMxz8EVwJOik2tkcCuGuDVYnu6Pu7H7uB3rWYRZSASX/Mk1azZFCoPabU3YYW8Tn/vENN8RKeLk2V//1ceZt53WrBGQ6/6u6TIx6AVHMPBJF61PVTp12lgKBlg=
Received: by 10.35.70.17 with SMTP id x17mr2266475pyk;
        Sun, 02 Jul 2006 14:33:55 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Sun, 2 Jul 2006 14:33:55 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e8954u$srh$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23123>

On 7/2/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Currently in qgit one can git-format-patch a commit. It woul be nice if one
> would be able to git-cherry-pick and git-cherry-pick -n a commit (denoting
> the head, i.e. where cherry pick would be applied to). It would be very
> usefull in reordering patches (cleaning up history).
>
> --

Currently in qgit you can git-format-patch a commit series and git-am
a given patch file series.
This can be done transparently with a drag & drop mechanic:

1) Open the source repository
2) Then open a new qgit instance (File->Open in a new window...)
3) Open the destination repository in the new qgit window
4) Drag & drop selected commits (multi selection in supported) from
source to destination.

I normally use this instead of git-cherry-pick  that, I admit, I don't
know very well, so please I need some more hints on how to upgrade
this behaviour introducing git.cherry-pick support.

    Marco
