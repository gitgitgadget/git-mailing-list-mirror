From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: git clone through http bug?
Date: Thu, 14 Feb 2008 09:36:22 -0800
Message-ID: <ee77f5c20802140936y28be9b39i59753af66e1a5e36@mail.gmail.com>
References: <873arvv479.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sergei Organov" <osv@javad.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:37:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPi14-0001N8-Nc
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 18:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbYBNRgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 12:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbYBNRgY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 12:36:24 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:37991 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbYBNRgX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 12:36:23 -0500
Received: by rv-out-0910.google.com with SMTP id k20so274227rvb.1
        for <git@vger.kernel.org>; Thu, 14 Feb 2008 09:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+IgHKPEJN9d0mLVbaz3U37NjLgx2axiFE7Pz5AWOEKg=;
        b=sSvveTJRwoI2yDiXctx41IuiF0+ovZAMVr5pBx0m0AirdSCGFQzzOOfrnZ9LiKyGFD2kHPh9jmIacU0kfsHsTf8KsvP9SE4KncMlUwdvbo7oB8/14luBqpLOTdlt3K8+GQNYgSP/k8i9KJyrOeBZOzCumgVPZOY7bmQsAa5/RDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lwe5vhy7AA2k3aqrtNk6Y8bhWMshbrH6kvyXa1NuK+wSCHoU4NYUiqFAEPZbCIE177CcNOxkmm6pg3huJYNLLcQWVyYh4vAVP45coXrY83SxdW7MR7D3lvyLOCE7443GeZs3hl8Ln11FW7adeh7cUdC6ElWij3YbXDSpN7TQ0YU=
Received: by 10.141.122.20 with SMTP id z20mr1145988rvm.239.1203010582131;
        Thu, 14 Feb 2008 09:36:22 -0800 (PST)
Received: by 10.140.135.17 with HTTP; Thu, 14 Feb 2008 09:36:22 -0800 (PST)
In-Reply-To: <873arvv479.fsf@osv.gnss.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73898>

On Thu, Feb 14, 2008 at 9:27 AM, Sergei Organov <osv@javad.com> wrote:
> Hello,
>
>  I've just cloned the public repo (it's rather small):
>
>  $ git clone http://ydirson.free.fr/soft/git/cvsps.git
>
>  and it has created cvsps/.git, but no working copy.

That's because the remote side doesn't have a HEAD. Just run "git
checkout --track -b master origin/master" to create a local branch the
tracks the origin/master branch.


Dave.
