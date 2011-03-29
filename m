From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 11:38:45 +0200
Message-ID: <AANLkTi=7TNjLVrcJVppiULBnDdKCM_vqwhn1JqoW+DQo@mail.gmail.com>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 11:39:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4VOL-0001rs-FZ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 11:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab1C2JjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 05:39:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40823 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab1C2JjG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 05:39:06 -0400
Received: by bwz15 with SMTP id 15so36030bwz.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=5HyQNV0CuCfdxqmubRlIubd4WNrZKYuhfI254oadLPw=;
        b=P7UighNw47sGsDvx6Oro4Qu8SROcG7RGt8/neXj/hwdpGND/Rnw9ezDADcz6lYA88c
         9NL1GRgI3sDSZH7mt0+VyBKXYln93FQymamY0AYKFHQT8dNwTAkP9ySFStoJj3teGQkQ
         FxzU5Uj+ewazaQ53DCyKy3Xnk++w9qmzjJvI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TDgXxgZgFb8lfIhqqNRcY06vXt0Rs6qc35tyfU2H2MOB1ekYr/SijRdWWKMLb7sSUp
         xwSjtjJ0h+/XZXYf5B9Kq5K7QWGYBI78TT6t+tbYmI6pO3498LzLWXTWPxh02V8V9wDk
         Px/lZp5haZf4A9dhCQ61VrEzVEJCTPds0frZ8=
Received: by 10.204.84.166 with SMTP id j38mr4625867bkl.84.1301391545113; Tue,
 29 Mar 2011 02:39:05 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Tue, 29 Mar 2011 02:38:45 -0700 (PDT)
In-Reply-To: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170250>

On Tue, Mar 29, 2011 at 07:42, Lynn Lin <lynn.xin.lin@gmail.com> wrote:
> All,
> =C2=A0 I have only have two commits in repo,then I want to squash the=
se
> two commit into one through git rebase -i .However it fails
>
> $ git rebase -i HEAD^1
> it only show up one commit so can't squash (can't squash without a
> previous commit)

$ git rebase -i HEAD~2

8-]
