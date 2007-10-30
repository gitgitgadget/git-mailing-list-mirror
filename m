From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: How to merge git://repo.or.cz/git-gui into git.git
Date: Tue, 30 Oct 2007 10:12:28 +0800
Message-ID: <46dff0320710291912p36d7c83j8564ff0afc6c7b79@mail.gmail.com>
References: <46dff0320710280357u23927960hd204760b3d664ce2@mail.gmail.com>
	 <46dff0320710280400v523e2130nd3286a88a4920a9c@mail.gmail.com>
	 <20071028111443.GA29183@xp.machine.xx>
	 <46dff0320710282345r2922ac7dj9c7a4eb3e20fd011@mail.gmail.com>
	 <20071030005217.GT14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Peter Baumann" <waste.manager@gmx.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 03:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imgay-00076H-5S
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 03:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbXJ3CMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 22:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbXJ3CMa
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 22:12:30 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:65075 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbXJ3CM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 22:12:29 -0400
Received: by py-out-1112.google.com with SMTP id u77so3244474pyb
        for <git@vger.kernel.org>; Mon, 29 Oct 2007 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uocBQSbl2+s8K0gCTayHBj1SfDweWDDP+Z+HEIobgjg=;
        b=WDBYih0oxQErDDzpIQZBU2ql/HS74FE4GAC3KIOKHqV0hKKDujaWoc7mX+/MVARqTNtZvP5+lXj2lzo1yeJPTdEI8wL+oBZe+Ud7UWveMVpYHox//uxpGsP8DrwBGakqqkJFqlX61JxRYAiBOwpU/nUp9835B4hp7PVpKkmBbpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OCSQLedVtemk498QT0IXqYQWq7PBqu0XC9mc/KR8I3WagI4S4JqV+6qXFZyGSpHUajvsk5soBuOeGfHaeDF80CCAeVXc7el1wKVi3dULciHcrTn9BEHvMLhLhxK0aDFGXNyl5KmDJwi0UUO4Dn9UFB1Xvor5+UGdmofupOc37Ms=
Received: by 10.64.153.4 with SMTP id a4mr14190263qbe.1193710348579;
        Mon, 29 Oct 2007 19:12:28 -0700 (PDT)
Received: by 10.35.108.1 with HTTP; Mon, 29 Oct 2007 19:12:28 -0700 (PDT)
In-Reply-To: <20071030005217.GT14735@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62648>

> You are merging in the wrong direction.  You want to merge git-gui
> into git.git:
>
>         git clone git://repo.or.cz/alt-git.git mygit
>         cd mygit
>         git pull -s subtree git://repo.or.cz/git-gui.git master
>
> So you are pulling git-gui into git, not the reverse.  But yes,
> when this happens the entire history of the pulled project (in the
> above case git-gui) suddenly appears in the history of the parent
> project (in this case git).  If you don't want this to happen then
> you need to make git-gui into a submodule.  That has been talked
> about being done, but hasn't happened yet in the main git repository.
> git-gui is currently still being subtree merged in.
>
> --
> Shawn.
>
Ok, I see. I'm just be interested in the subtree strategy and try a
few ways and different directions to merge. And also i'm trying to
figure out which one of subtree merge and submodule is more suitable
for my project. However, the conclusion havn't come.

-- 
franky
