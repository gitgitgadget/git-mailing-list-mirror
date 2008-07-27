From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Optional grouping of projects by category.
Date: Sun, 27 Jul 2008 01:53:43 -0700 (PDT)
Message-ID: <m3zlo3u2r2.fsf@localhost.localdomain>
References: <8763qsi2mt.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastien Cevey <seb@cine7.net>
X-From: git-owner@vger.kernel.org Sun Jul 27 10:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN21f-0006Xx-7W
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 10:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbYG0Ixr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 04:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbYG0Ixr
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 04:53:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:23652 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbYG0Ixq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 04:53:46 -0400
Received: by ug-out-1314.google.com with SMTP id h2so101414ugf.16
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=y0dReBnq3lPbuVS/aeNbbHOyjbe4RC3j4QAQQnV2Cac=;
        b=aVbXkJ0IG8gl6IEadrDWBi+a4tOEoigCaNIm4vO2rfZ+UjC4GunDbbq8v+qToBbOwC
         /k0aONhcsV5fOY94Kxai7Tyes8aw8/NWRbUXVJKLaKlvE74h5A73kraZW42ZK4LVg4DF
         cm5nj9E0dU206TaMriJg7rf4OzB8GnS+hi+MY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=e+2yiNWGX28931vjY0dHDp0WTTAegdOnZyYGqSemqye//XN9IyRzJaH0SJYVRxisBv
         BCv5HQygzulFYkGl41EKhhMhGixTBBBgGAalTTpMffGErMfcsBflPV6ToT6zJbTxhE6M
         qVou9WO9+4WBhh0qU7JL1hdSvBljvcipqD7hk=
Received: by 10.67.115.18 with SMTP id s18mr1262094ugm.52.1217148824092;
        Sun, 27 Jul 2008 01:53:44 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.240.214])
        by mx.google.com with ESMTPS id k1sm5128979ugf.21.2008.07.27.01.53.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Jul 2008 01:53:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6R8rdxh025609;
	Sun, 27 Jul 2008 10:53:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6R8rbJN025606;
	Sun, 27 Jul 2008 10:53:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8763qsi2mt.wl%seb@cine7.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90327>

Sebastien Cevey <seb@cine7.net> writes:

> This adds the GITWEB_GROUP_CATEGORIES option which, if enabled, will
> result in grouping projects by category on the project list page.  The
> category is specified for each project by the $GIT_DIR/category file
> or the 'category' variable in its configuration file.
> 
> The feature is inspired from Sham Chukoury's patch for the XMMS2
> gitweb, but has been rewritten for the current gitweb development
> HEAD.
> 
> Thanks to Florian Ragwitz for Perl tips.

Thanks a lot.  I don't know if it is a good time, with git being in
feature freeze, and GSoC project about adding caching to gitweb in the
works, but I'll take this patch and resend it if needed.  I'll try to
comment on it soon.

That said, I think that the subject (oneline commit summary) should
include 'gitweb', e.g.

  "gitweb: Optional grouping of projects by category"

-- 
Jakub Narebski
Poland
ShadeHawk on #git
