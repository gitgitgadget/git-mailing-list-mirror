From: Damien Wyart <damien.wyart@gmail.com>
Subject: Re: How to git diff files in renamed directories
Date: Thu, 15 Mar 2012 09:51:05 +0100
Message-ID: <20120315085105.GA27243@brouette>
References: <CAGATVH7KCr+dJNpx18==3BT8pzsvKeV5aYRWKts7xH0YZ8yaKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Sabin <patrick.just4fun@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 10:00:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S86Xg-0004OL-62
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 10:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760887Ab2COJAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 05:00:11 -0400
Received: from mailhost-c4-m0.mangoosta.org ([78.40.49.140]:39632 "EHLO
	smtp-delay2.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760879Ab2COJAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 05:00:09 -0400
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Mar 2012 05:00:09 EDT
Received: from maiev.nerim.net (smtp-154-thursday.nerim.net [194.79.134.154])
	by smtp-delay2.nerim.net (Postfix) with ESMTP id 51DF919CF242
	for <git@vger.kernel.org>; Thu, 15 Mar 2012 09:19:19 +0100 (CET)
Received: from brouette (damien.wyart.pck.nerim.net [213.41.244.197])
	by maiev.nerim.net (Postfix) with ESMTP id B5F0B2E038;
	Thu, 15 Mar 2012 09:51:05 +0100 (CET)
Received: by brouette (Postfix, from userid 1000)
	id D47384010F4; Thu, 15 Mar 2012 09:51:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAGATVH7KCr+dJNpx18==3BT8pzsvKeV5aYRWKts7xH0YZ8yaKw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193204>

Hi,

* Patrick Sabin <patrick.just4fun@gmail.com> [2012-03-15 09:32]:
> I want to diff a renamed file (to a different directory) in different
> commits.

You can try the "-C" option to git diff. In some cases, "-C -C" might be
needed (with potentially bad performance).

-- 
Damien
