From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Update local tracking refs when pushing- no way to disable
Date: Fri, 6 Jul 2007 10:26:32 +0200
Message-ID: <e5bfff550707060126t781587aaxbe2f6eca1c282985@mail.gmail.com>
References: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
	 <Pine.LNX.4.64.0707052320090.14638@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Dan McGee" <dpmcgee@gmail.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 10:27:06 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6j9d-00039B-M2
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 10:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760155AbXGFI0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 04:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754374AbXGFI0f
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 04:26:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:37338 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760145AbXGFI0d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 04:26:33 -0400
Received: by wa-out-1112.google.com with SMTP id v27so180008wah
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 01:26:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dx+DXeHKcRQykVDizLn2GhkrT+Im5NQ0Rnio2yZo7xe4CGN3PaLrhTc8kqq1b05jhYbBkhjf6UtzzOn6NoO9981id/jftEv05aSn8Yg0oWQ57C4Lr4G4c0ZMbgBtI6DmO4Fstg3y96Y5XCeYgLwa4qiNANnkRp+Y8p6vrtVeemE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QShObaa0uMyYESvT2g7R3IGRwoIhkYn0g6K3Nh7TDo4E4KfAm6LQ6ZIG5TvD0+SzY9VgP5LArEUrCZMNWdGM3nYDk4lpKrmmaxwoSDwXKJMYhULDTA8LE5mKcFTAyQIYAO3An9+TGbFTjY8/Zk6Ku2/EEoe2hGgLDKO2IxBB4OE=
Received: by 10.114.158.1 with SMTP id g1mr439290wae.1183710392479;
        Fri, 06 Jul 2007 01:26:32 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Fri, 6 Jul 2007 01:26:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707052320090.14638@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51731>

On 7/6/07, Daniel Barkalow <barkalow@iabervon.org> wrote:
>
> (AFAICT, the only additional stuff that -a shows with git branch is the
> stuff that you're deleting; perhaps qgit should have an option to not show
> remotes, or not show them by default or only show them if what they point
> to isn't otherwise marked? Anyway, it shouldn't be necessary to avoid
> having this information just so that it isn't shown in interfaces you
> use.)
>

Probably an option "show remote branches" from a popup context menu
(right click) is the more natural and predictable solution.

In case someone is interested, please confirm me, I will add that.

Marco
