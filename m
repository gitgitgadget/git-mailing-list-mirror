From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: direct ref manipulation
Date: Sun, 5 Sep 2010 18:36:39 -0500
Message-ID: <20100905233639.GB18103@burratino>
References: <20100905232525.GA494@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 01:38:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsOnH-0004Ur-LL
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 01:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab0IEXif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 19:38:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36862 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab0IEXie (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 19:38:34 -0400
Received: by gyd8 with SMTP id 8so1442181gyd.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 16:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o52WpRV93hCmrnV/6qBRqxaeSMIMGdIM5599/oaW2dM=;
        b=TEDR1Wyo2yDoK5YUfbddJhqQDlqWNqhM6AvuDblXDxdgtaD388LQkWTiOZv0I6IfIt
         FqjQ2ZG19N4RS/FWaDqeqCwPMTyFmbFQI3mkzkDWHVWmxYtH4/IotHtORFGuj2H2BX/R
         XWhkbK31KjarL5G/K+TnkzfUsi8WOW99PJe6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YDeUIGE5+v/anW/EDLzZrzH6xCNmkX0I5wNe1PxpaLdVADrC7EROHO+u56OSunFnBc
         y9IpitlG3mmgF16LDqG0yC6ET3I3yQkN7v8z6HeP8ZqXlpcYR/41iusUThKwr2gL8Vzv
         UNPINGnddWxpdzOhjjPqNRQspBD0pxY7sDXak=
Received: by 10.151.62.21 with SMTP id p21mr822547ybk.170.1283729914209;
        Sun, 05 Sep 2010 16:38:34 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm2818184yba.0.2010.09.05.16.38.33
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 16:38:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100905232525.GA494@nibiru.local>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155497>

Hi Enrico,

Enrico Weigelt wrote:

> is there already an command for directly manipulating refs
> (eg. set a specific to given object id) ?

$ man git |grep ref
    Do not use replacement refs to replace git objects. See git-replace(1) for more information.
See the references above to get started using git. The following is probably more detail than necessary
    Move objects and refs by archive.
    Download objects and refs from another repository.
    Update remote refs along with associated objects.
    (deprecated) Recover lost refs that luckily have not yet been pruned.
git-pack-refs(1)
git-reflog(1)
    Manage reflog information.
    Create, list, delete refs to replace objects.
move objects and references between repositories.
git-symbolic-ref(1)
    Read and modify symbolic refs.
git-update-ref(1)
    Update the object name stored in a ref safely.
git-for-each-ref(1)
    Output information on each ref.
    List references in a remote repository.
git-show-ref(1)
    List references in a local repository.
git-check-ref-format(1)
    Ensures that a reference name is well formed.
...

Perhaps you are looking for git-update-ref.

Hope that helps,
Jonathan
