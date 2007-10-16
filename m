From: "Shun Kei Leung" <kevinlsk@gmail.com>
Subject: Re: git-fast-import crashes
Date: Tue, 16 Oct 2007 16:01:18 +0800
Message-ID: <e66701d40710160101x5c697a6fmeecea4c81dfd9972@mail.gmail.com>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com>
	 <20071013032916.GL27899@spearce.org>
	 <20071013033407.GM27899@spearce.org>
	 <20071013073640.GC7110@artemis.corp>
	 <20071013075027.GD7110@artemis.corp>
	 <e66701d40710142153o70a7b696r928491be437ac6d@mail.gmail.com>
	 <20071015073307.GA1508@artemis.corp>
	 <e66701d40710150119y7c9e0ff6n83c5fbd25d351fc6@mail.gmail.com>
	 <e66701d40710160013h270f685sef57f80382089f3c@mail.gmail.com>
	 <20071016074645.GA6919@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Shun Kei Leung" <kevinlsk@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:01:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhhMt-0000ul-E7
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758038AbXJPIBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759377AbXJPIBV
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:01:21 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:28793 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142AbXJPIBU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:01:20 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1019718ika
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 01:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SIHTh+MQ5jZm1Q+Upe9gK5gQN7QGVY/pGaGZMXqZ5xg=;
        b=PiKCj4wrGYfkijdNEQntfxmsMl+VlX1UbmNNMUnPz5ZK9sNWgSNWA/Y+fcWwQJROwFCrjc+B68GYqOmPwSchdfui27HH1M1iV76+6Au0RZtgEO8BDVLJBszBHZDFqEG+G8LVc6ftqC3DExqby4iIJEY/FdjYBBCchsZYrVsd0mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d+/0BkD7R6hDcmdShT+prbwmH3PkK/ExU+9HXjDcqA743H9RbqOqJeOUY+3ljBiJfYRVOI/C1A2TkFAbVjwD4n7fLn4wi2J5dzM9QjDDbSTQACpl28wEcnuT49Mqy7lTi6SIc03OsT4lTi+5hw6sIulaZ0Mjyrr+Bu7UTN4YNu0=
Received: by 10.78.159.7 with SMTP id h7mr4654045hue.1192521678086;
        Tue, 16 Oct 2007 01:01:18 -0700 (PDT)
Received: by 10.78.132.20 with HTTP; Tue, 16 Oct 2007 01:01:18 -0700 (PDT)
In-Reply-To: <20071016074645.GA6919@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61111>

>   What I _really_ need is that you run your test into valgrind (the easy
> way is to rename git-fast-import into git-fast-import.bin, and make
> git-fast-import be a shell-script doing:
...

valgrind is not yet ported to Mac OS X, sadly enough.

Regards,
Kevin Leung
