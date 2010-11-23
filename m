From: Dun Peal <dunpealer@gmail.com>
Subject: Inexplicably deteriorating performance of Git repositories on Windows
Date: Tue, 23 Nov 2010 19:08:41 +0000
Message-ID: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 23 20:09:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKyEh-0006je-9Y
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 20:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456Ab0KWTIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 14:08:44 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36133 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756445Ab0KWTIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 14:08:42 -0500
Received: by pzk6 with SMTP id 6so659828pzk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=xqEFYs6OnyKNNAgH34jho1F+P/wr74bZj+KcJ00qVf0=;
        b=uhLHQ7YvcG06Ciy2LFqb64LRPz5QhZpN1249FRsIxV0GZBMBPB6d3KtjeYBVhd9CNs
         zvoiuEnqK5Q3yloqXMoBoLlDSAyIUYd6DVAcWJXXFerA+GSiQ4Vl9Cg9UBxc/0ZspHGW
         cVP9wn6fJdV2u7HlisWTk/Gsi+gWoqLXOlPNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=liuU1O5E+v0Dg1BpihhdXD5eF80/wlmSbXz6UD1CIsRk2iPkWPMkycYieUlKjlCxTN
         8oYI8YI4OzfnQaHkFkQNNCl6BdXT+xZdS4/Kqy3UUQU3WHdQX6nJNcy3J1RpW0EwPcyX
         2fw4mlwRYmhxw0Xds8Ng1nLbXXvxW/5Q0Lr4g=
Received: by 10.229.215.213 with SMTP id hf21mr6620078qcb.189.1290539321431;
 Tue, 23 Nov 2010 11:08:41 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Tue, 23 Nov 2010 11:08:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162010>

Hey,

We have a bunch of Windows users, unfortunately, and they're using the
latest msysGit release (Git-1.7.3.1-preview20101002).

An interesting issue we've noticed is that the Time To Complete of
their common operations start deteriorating inexplicably, and
severely, some time after the clone.

For instance, immediately after a clone, `git status` takes about
5-6s. Which is slow compared to Linux (consistent 1-2s), but still
usable (it's a BIG repo).

However, after a reboot (of all things), `git status` latency
skyrockets to 14-15s, making the repo unusable.

Any idea what's going on?  We just recently switched from SVN, and
those users are getting really frustrated. BTW, the only real
alternative I'm aware of, Cygwin's git, is even slower.

Thanks, D
