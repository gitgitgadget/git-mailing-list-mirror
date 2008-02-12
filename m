From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Tue, 12 Feb 2008 12:48:48 +0100
Message-ID: <200802121248.49002.jnareb@gmail.com>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com> <200802111630.29159.jnareb@gmail.com> <200802121239.06287.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 12:49:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOtdk-0007Am-KJ
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 12:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761235AbYBLLs4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 06:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbYBLLs4
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 06:48:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:37593 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbYBLLsz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 06:48:55 -0500
Received: by ug-out-1314.google.com with SMTP id z38so464339ugc.16
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 03:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=hroXqKTdseIhlzpPdBQgMND9HGVuLmV+PzfvYMNPOwo=;
        b=ptkIYULwZUeO/eg3TWh3dH8xPealRFt9xfFuN/cHV8gevk7H9vUdXpxjaMswYDY+QgESyU5KkVIrqWZ4UmqdjgLxOGy/IqJSEWDR4UhIXpjTsyzkBqNwb9AYcMDLjxZeEw1UdwO4XWBgCQ+mf5ecyJEAgFt0Bv/zZCVxH0CV2s0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IsWprRFbvZxAU3XkYHEfZBZi8yaxyLHvx38GSj+vkf132I3omxsswzPKWaPHxCYJefx2mcthug9XVr0iZYsdbGro5HAie2eHb/r1qBIei0ZYsGiyb+YLg2sBRMVN68aab7fYMqQj2AytR0ygTaL30pd5pUI/BhuWRZoCYqxbJIg=
Received: by 10.67.196.2 with SMTP id y2mr438911ugp.60.1202816934312;
        Tue, 12 Feb 2008 03:48:54 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.23])
        by mx.google.com with ESMTPS id r38sm2806701ugc.55.2008.02.12.03.48.51
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Feb 2008 03:48:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200802121239.06287.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73654>

Jakub Narebski wrote:
> Actually the error is there even without using 'pathinfo' feature,
> namely if you use pathinfo to provide project, for example:
> =C2=A0 http://www.example.com/w/project.git?a=3Dshortlog
> then 'next' link on the page lacks project (instead of having
> dereferenced anonymous array reference, i.e. ARRAY(sth)), like below
> =C2=A0 http://www.example.com/w/?a=3Dshortlog;pg=3D1

Errr... what I forgot to write here is that I have checked that
the patch send (the first version) fixes this bug, as checked
"by hand", i.e. by examining gitweb running as Apache CGI module.

> But I could not come up with automated test which would _fail_
> on this error. So please check, and reply if this patch helps.

--=20
Jakub Narebski
Poland
