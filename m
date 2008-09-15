From: "Michael Wookey" <michaelwookey@gmail.com>
Subject: Re: git-clone: path or ssh problem with git-upload-pack in 1.6.0?
Date: Tue, 16 Sep 2008 08:39:47 +1000
Message-ID: <d2e97e800809151539n1a074718h5c322ae757b65551@mail.gmail.com>
References: <d3a045300809091929h18c3c447gb3d4e79131f66986@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Johnston" <pcj127@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 00:41:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfMku-0002uG-NB
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 00:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091AbYIOWjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 18:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbYIOWjv
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 18:39:51 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:61821 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbYIOWju (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 18:39:50 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1205565gvc.37
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MLewQUOvDONd5xTlVjnOCxi+EkMhorV3s8jgx21fP8c=;
        b=mlsdP30ofkCTcQ+5lGjkd+JmLZu8Vu+gwyviSKFDUOFP3i+/NN+9RkPSfr87Gd2LOQ
         kAK50PhYsdmhquhQpXWEIUdd/IafYQ9i12an8pbkQCxfCOkVWR3rzCrZW6WrISqLwRGc
         1q8/y2l3Cz6z6/204ZX7YhtYgpgQNJxSK/9MU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IUcHjtb4CoX6qjkMuzZBmxvBoZOQiCdn9yck8qw+nSI/db+0LQlXkDXOLmNOOC0o1d
         /sCGBQVatT/vklt08AI8jebRUvH80kHnO3AXzU4cnpvod6KOAquBGXm6ZLhwklQztnR8
         NbguZ84pH8gDRJdwN9yuIpP/OvImhqkoAf4mI=
Received: by 10.103.222.12 with SMTP id z12mr169128muq.12.1221518388654;
        Mon, 15 Sep 2008 15:39:48 -0700 (PDT)
Received: by 10.103.134.19 with HTTP; Mon, 15 Sep 2008 15:39:47 -0700 (PDT)
In-Reply-To: <d3a045300809091929h18c3c447gb3d4e79131f66986@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95950>

> I'm having trouble with git-clone and I'm wondering if there's
> something I'm doing wrong or something wrong with git.  Probably the
> former, hopefully someone can set me straight.
>
> I'm an admittedly novice git user. I'm trying to clone a repository
> over ssh. The host machine 'imac' is my mac osx 10.4 with git 1.6.0
> installed from a macports package.  This installs into /opt/local/bin.
> I also cloned git from HEAD and 'make; make install'ed into ~/bin,
> this is the version shown below.  Either way, these are
> nonstandard/non-system-wide installation locations, and it requires
> that my shell PATH reflect this, obviously.

The following might help..

http://marc.info/?l=git&m=121378876831164&w=2
