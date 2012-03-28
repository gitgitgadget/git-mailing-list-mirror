From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: bash-completion now loads completions dynamically, so __git_ps1
 is not defined when you open a shell
Date: Wed, 28 Mar 2012 18:06:42 -0500
Message-ID: <20120328230642.GA16925@burratino>
References: <CANaWP3wu3260uFNzCLJ=YSG1BWFr=ge_6CmMGrG6zLThvFnjcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bash-completion-devel@lists.alioth.debian.org
To: Kerrick Staley <mail@kerrickstaley.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 01:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD1xE-0006ed-TI
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 01:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933263Ab2C1XG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 19:06:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45979 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567Ab2C1XGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 19:06:55 -0400
Received: by iagz16 with SMTP id z16so2119446iag.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 16:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lweJg7S1iOdEvgfAmGBv9xk3N0Bg+lhhghTC/AWvM+0=;
        b=lKTGwGM9STWAeF2vaCL11UfZ2OQUe1ipZai7mq0kCiWtZDOIFivujPK9bIpqI9Z9FQ
         eOu70eytD4oOOHNJIXTdlOuF113Bzlcso+8Fbpl0KcqNGCxVeYHJUCPWb9Sf3/i7yOn/
         79nt5prS6MS6Ex1S/PlLbJiUYYYQDDQR8/9C3zhrOKF6AYI+jt+ElMLFZ/h8Nc8NgMMn
         fRmxeAWMOgGqRfe+PTcdPf5TR1Hpn0Gyyt3GEGB/jeEdyoXEGAsIb+blb2x8/xo+L8GA
         CAJkjCLTJujOnZ+1k9vMhySdBNRDxBSq7xaiLMuZaQ3kYbCP9uJM6B/KeWQSfupiC5EO
         73dQ==
Received: by 10.50.153.201 with SMTP id vi9mr697777igb.46.1332976015325;
        Wed, 28 Mar 2012 16:06:55 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bh8sm4314188igc.9.2012.03.28.16.06.54
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 16:06:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANaWP3wu3260uFNzCLJ=YSG1BWFr=ge_6CmMGrG6zLThvFnjcQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194217>

Kerrick Staley wrote:

>                                                           Since
> bash-completion loads completions on-the-fly in newer versions, the
> __git_ps1 function isn't immediately available in a new shell. How
> should this be handled? Should users just source git-completion.bash
> before they redefine $PS1?

Yes, I think so.  Do the release notes for version 2.0 of the
/etc/bash_completion wrapper script mention this change?

Thanks,
Jonathan
