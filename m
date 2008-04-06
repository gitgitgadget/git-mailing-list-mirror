From: "seventh guardian" <seventhguardian@gmail.com>
Subject: Re: [bug] git-clone over ssh fails when repository has local commits
Date: Sun, 6 Apr 2008 19:11:09 +0100
Message-ID: <1caff7430804061111u743e6257vf34d35303c864b49@mail.gmail.com>
References: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com>
	 <20080406161120.GB24358@coredump.intra.peff.net>
	 <1caff7430804060922seba4978qa13b123103b8282b@mail.gmail.com>
	 <20080406165655.GA26060@coredump.intra.peff.net>
	 <1caff7430804061011ye82e74v289dd3536b253bcb@mail.gmail.com>
	 <20080406175136.GB32399@coredump.intra.peff.net>
	 <1caff7430804061106m49a60bc0wbbd9001394e83589@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 20:12:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiZLP-0003Uf-8h
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 20:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbYDFSLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 14:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbYDFSLL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 14:11:11 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:29619 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbYDFSLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 14:11:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so975658wah.23
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WxnDdfEEwxQS/EfgydkWUV9z7rX+1MPttKkHhMDfnqE=;
        b=Ok1GPLweVmWJ+O6rnBzdJF3VcLyvqYL3+oJ+5PIWHr4l3wnkttSmIN284R0hkCkeCnaQ9GtJsnlCiqZMAEsiA+kgw1aHbSrkv3YZw3WpVpAwNIAv0aHHLOVLvxFg557RBfCe3gZoohH7nJ4Kqov4+DK89Jd7cgpsvYBtBbchFqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DjmkIdtfjP/vLh/wMpYxo7i0SAeHsZO6t0dZ4krbMslDEiYt0U0a8GPBVkG6BFlYGFOOf5XngwIz0ULgYKZeuNLvydID+VGL5/1qtA1UFjX7RQTTo2tMGlgjqIEKHsfIFeJBUGUzB2WrCtvH5t4K0syHH7XIH7+YSWMk11jJLUc=
Received: by 10.114.15.1 with SMTP id 1mr5018043wao.27.1207505469574;
        Sun, 06 Apr 2008 11:11:09 -0700 (PDT)
Received: by 10.114.126.18 with HTTP; Sun, 6 Apr 2008 11:11:09 -0700 (PDT)
In-Reply-To: <1caff7430804061106m49a60bc0wbbd9001394e83589@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78905>

On Sun, Apr 6, 2008 at 7:06 PM, seventh guardian
<seventhguardian@gmail.com> wrote:
>  Now that I look at the addresses, the "nouveau" part is common to the
>  problematic repo's. I'll make a local change on the last repo and see
>  if it also exhibits the problem. I'll report back ASAP.

The last repo also exhibits the problem after committing a local
change. A hard reset to "origin" fixes the problem, but also throws
away the local changes..

Cheers,
  Renato
