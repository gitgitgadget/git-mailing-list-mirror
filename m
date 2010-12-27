From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: Bug: git add with absolute path fails if repo root dir is a symlink
Date: Mon, 27 Dec 2010 10:23:12 +0300
Message-ID: <AANLkTimPxhqwMebfTw9oHucuvABmSBynpZgG1zp6uwVz@mail.gmail.com>
References: <AANLkTi=Mj3AdinC87Ys35fv9DpZqefiZXhPbHMLdmyPh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 27 08:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PX7Qi-0006pU-4P
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 08:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab0L0HXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 02:23:34 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36650 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab0L0HXd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 02:23:33 -0500
Received: by qyk12 with SMTP id 12so9183272qyk.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 23:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=uiS0WPy6k5P0ofaE+NNFFGN2RqfnMtMXz7fgngMhyoY=;
        b=boYPuW1qJ5IAJ6J1Ib1pFutxjrjeOC7sOAXjkWgCcVdrg/nQO/tOqEWCQ4GtFRXqps
         hxhv/wBB0/PMzm5cAN4iiR5yDwDvQovrk3p4fKTcVpWgqrhAhbvB73piWPxLFsDekS4E
         h1IeIKkAbQjXw87XfaS5FxMuENWaqKiy9uPEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=ulsPqxycV6ZoYTwiCSEVli6Hmu/yuC8Zc/f58JgGKib30h9XiJrCeR2CdY3XMU9ben
         SYZTMDB93ROqHCH/nxi9G5njdgDSHwYaNWO5625HRtwMEhocIOT5tlzd/eZ60Dcn3ZkN
         NYypY3gUdiWyA3G6V/LkfWiQMXOafpvOAbPxE=
Received: by 10.229.235.205 with SMTP id kh13mr10402815qcb.243.1293434612616;
 Sun, 26 Dec 2010 23:23:32 -0800 (PST)
Received: by 10.229.48.5 with HTTP; Sun, 26 Dec 2010 23:23:12 -0800 (PST)
In-Reply-To: <AANLkTi=Mj3AdinC87Ys35fv9DpZqefiZXhPbHMLdmyPh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164213>

On Mon, Dec 27, 2010 at 09:25, Alexander Gladysh <agladysh@gmail.com> wrote:

> I can't run git add with absolute path if the repository's root
> directory is a symlink.

Note that this issue is also triggered if *any* of the directories in
path above of my repo are symlinks.

This is a show-stopper for my current workflow.

Is there a way to quickly workaround this somehow?

Alexander.
