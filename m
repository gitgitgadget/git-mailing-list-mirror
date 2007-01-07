From: "Chris Lee" <clee@kde.org>
Subject: Re: Simple UI question...
Date: Sun, 7 Jan 2007 03:50:52 -0800
Message-ID: <204011cb0701070350l4c736bcerbb236caf09a4d461@mail.gmail.com>
References: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
	 <20070107111305.GD10351@spearce.org>
	 <204011cb0701070321w18942a3w7fb4f7ecd26fc457@mail.gmail.com>
	 <20070107112944.GF10351@spearce.org>
	 <204011cb0701070338i5f8a8b4bw8b39050aeb192edb@mail.gmail.com>
	 <7vk5zz12va.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 12:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3WYD-0001Ax-AY
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbXAGLux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbXAGLux
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:50:53 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:18313 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932500AbXAGLux (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:50:53 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7680931wxd
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 03:50:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=AxmIdgtvA2zXM21ZXAuq3UUet2WzHjUvc5HU2UhW/FpfuGrZTVPEox1ATaz2dS4Ft8NJTV8dAWXGzZPL63hlT6XPhj7RY9pKj1ecDulBOvV6OfLIq4xxLrASZBEI4AJJ+GNfTUQSbVc+/soaQn3Kzxa0HyXq0vWdYSIx2GjOni4=
Received: by 10.90.104.14 with SMTP id b14mr1623722agc.1168170652480;
        Sun, 07 Jan 2007 03:50:52 -0800 (PST)
Received: by 10.90.81.19 with HTTP; Sun, 7 Jan 2007 03:50:52 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vk5zz12va.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: ffd20a51a8f77e74
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36166>

On 1/7/07, Junio C Hamano <junkio@cox.net> wrote:
> "Chris Lee" <clee@kde.org> writes:
> > So, if I were starting with an empty working directory, and I had just
> > synced over the .git folder from the place where I'm doing the actual
> > importing - how would I populate the working directory with a copy of
> > the contents of the tree from (say)
> > 07058310db903317faa300b93004a5a2e0fc2dcc ?
>
> git reset --hard 070583

Okay, thanks :)

(I don't really care about trying to do actual development on any of
the branches that I've imported - I mostly am interested in finding
out some numbers on things like 'How much faster is git when rewinding
the directory tree to a given commit ID?' and related issues.)
