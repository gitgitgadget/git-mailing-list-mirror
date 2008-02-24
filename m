From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: on subtree checkout
Date: Sun, 24 Feb 2008 02:23:29 -0800 (PST)
Message-ID: <m3wsoubqmq.fsf@localhost.localdomain>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com>
	<200802241100.00107.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"git mailing list" <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 11:24:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTE27-0005QC-39
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 11:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbYBXKXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 05:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbYBXKXd
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 05:23:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:47777 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbYBXKXc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2008 05:23:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so380322ugc.16
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 02:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        bh=NjSIRpsE5Wox1sjTAcG6hnD9oz9Fu8Fql0buMoAs/r4=;
        b=qCwKvJgURvhZTeV+ae6A3d0zq4/RbSh1onjAaeFICqZUmvcBawxMcEZV8J1MS+n0TIvjThjrmMAYjcCWZHiZAcxY4yxCzuKiPHq7pQGqmmLk8e1HuoMAyBaPNGcnDMu+wuayz9SeYFufz+jKr3fLwBSZ1eoz8EZBxLSz0OInNHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        b=PvKKNk40IxCc45uHYIeUa/9f9j5hIZpfPJFDqfjU9sHkYfSOAUaNhGXBp+wCAW5M8IZMe8X8yWAZ6rZJWl97v2hmEC4gxc2tFd97jfoEEsho5NiUPXn7P6CJkLSLQHehO5Kb9E66RGsTFaROYtiCGxFhZrXxduAh/veLBf2bIzU=
Received: by 10.66.236.13 with SMTP id j13mr1595676ugh.30.1203848610600;
        Sun, 24 Feb 2008 02:23:30 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.46])
        by mx.google.com with ESMTPS id o7sm944573uge.71.2008.02.24.02.23.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 02:23:29 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1OAMsSO020505;
	Sun, 24 Feb 2008 11:22:59 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1OAMbBZ020501;
	Sun, 24 Feb 2008 11:22:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200802241100.00107.robin.rosenberg.lists@dewire.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74919>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> s=F6ndagen den 24 februari 2008 skrev Nguyen Thai Ngoc Duy:
> > I'm going to implement subtree checkout. The plan is to save "index
> > prefix" in GIT_DIR/prefix and update git commands to use index pref=
ix
> > when accessing the index. If I'm heading a wrong way, stop me now.
>=20
> Make it multivalue as having more than one directory checked out is
> quite reasonable in for example Eclipse, where there are hundreds of
> plugins all listed at the top level, but you only need a checkout
> for those that you actually want to change. KDE would be another
> example where you want to mention multiple roots.

IMHO both in case of Eclipse plugins, and KDE modules/apps/whatever
it would be much better to use submodules support than partial
checkouts.

IMHO the best example of partial checkout workflow would be
documentation writers or translators. You cannot put docs in separate
submodule, as you want to have whole-tree change+documantation update
commits.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
