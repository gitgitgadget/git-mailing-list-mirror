From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Supressing sorting of trees
Date: Mon, 12 Oct 2009 21:36:59 +0200
Message-ID: <46a038f90910121236x6bbe258bwa3bc3fdcc54de524@mail.gmail.com>
References: <loom.20091012T152113-874@post.gmane.org>
	 <20091012142032.GG9261@spearce.org>
	 <loom.20091012T171550-239@post.gmane.org>
	 <alpine.DEB.1.00.0910121803360.4985@pacific.mpi-cbg.de>
	 <loom.20091012T182258-9@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sal Mangano <smangano@into-technology.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:39:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxQjm-0007U8-OC
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 21:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933186AbZJLTiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 15:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933180AbZJLTiI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 15:38:08 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:55724 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933166AbZJLTiH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 15:38:07 -0400
Received: by ey-out-2122.google.com with SMTP id 4so1986886eyf.19
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ZYMaDWWk0uflx2zCw4vV+clvL8Wm9Xpgjq42LjLjp5I=;
        b=A+eO1uK108CLw8c6OuaJ8o4LR/riTRfZczZYX3J2zcgUARL4jXh1/LSJRFdHoEUnlR
         mwS286UyIyGRSEFXtM+TrxDu7l+HYgOFKJF1gYjH8VH7iGb6gtwLFXLASHQy3DwuiE1K
         9VlN5EPntUbmVvh21nKgYwhFe5U0pJpROKoYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fn537Ngi4tBAf+GLSI25qkdZQyjfYA/wDGWuHZ93R1RyCcq5ImhQKq3PHobrhLiiS3
         XhjEJWybbaCqIc0R1GeuTLb14Ajati3g2vdXe+XSXwncdq+K1PyTyj4FVWWDEEveobzT
         3nqC1j6XaMXQ8dI6xQf3r1XoclIuXK6NeNjcA=
Received: by 10.210.7.21 with SMTP id 21mr7529097ebg.75.1255376219243; Mon, 12 
	Oct 2009 12:36:59 -0700 (PDT)
In-Reply-To: <loom.20091012T182258-9@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130055>

On Mon, Oct 12, 2009 at 6:51 PM, Sal Mangano
<smangano@into-technology.com> wrote:
> 2) I can use Git unchanged but preserve order by storing some information in
> each sub tree (e.g. an extra blob) which retains the real order. I can also

This #2 is your best bet by far. An extra blob in each subdir is just
one option, you can handle this "extra metadata" in a number of ways
-- maybe external to git, on a separate history will work best.

The downsides of messing with internal tree handling of git are so
staggering that you'd do better to throw git away.

(this is from experience of abusing git to various purposes that have
little to do with version control :-) )

In other words: Shaun and Dscho are right, so right that it hurts.

hth,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
