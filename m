From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Problem using curl + c-ares
Date: Sat, 23 Jun 2012 22:41:47 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1206232240080.28168@tvnag.unkk.fr>
References: <20120622020308.GA31477@atarininja.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Wesley Shields <wxs@FreeBSD.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 22:42:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiX9d-0005j8-3y
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 22:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057Ab2FWUl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 16:41:56 -0400
Received: from giant.haxx.se ([80.67.6.50]:47121 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600Ab2FWUl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 16:41:56 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id q5NKflDC030440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 23 Jun 2012 22:41:47 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id q5NKflZJ030411;
	Sat, 23 Jun 2012 22:41:47 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20120622020308.GA31477@atarininja.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200505>

On Thu, 21 Jun 2012, Wesley Shields wrote:

> I'm trying to debug a problem that came to my attention when using git to 
> clone a repository over HTTP or HTTPS if curl is built to use the c-ares 
> bindings.
>
> The symptom is well documented at:
>
> http://www.freebsd.org/cgi/query-pr.cgi?pr=ports/167517

This is most probably one of the c-ares bugs that were already fixed in the 
1.9.x releases.

-- 

  / daniel.haxx.se
