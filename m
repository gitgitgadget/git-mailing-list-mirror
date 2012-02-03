From: Feanil Patel <feanil@gmail.com>
Subject: Push from an SSH Terminal
Date: Fri, 3 Feb 2012 10:50:02 -0500
Message-ID: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 16:50:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtLPB-0004oB-19
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 16:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab2BCPuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 10:50:24 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60797 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab2BCPuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 10:50:23 -0500
Received: by wgbdt10 with SMTP id dt10so3992390wgb.1
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 07:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=6EsongkYvBM3ZBnolf8x0Z2tJKWyghkl3t2W3nM8G3Y=;
        b=ObEjYqIJKYQg6bk6x7J8kQM1zRMv81cwFSLaeN/p0qIVUFmcTYsKFhl9Rg6qfNFmcI
         PlOCTiWePCVXtRoAPAtKlfgCjSS6mrAXDBfio+lQkKNnAQ6sPs3U9VGLfS9kQfetGDGJ
         JRc+pK7q85GQkodAtM75pjbbZYCkKhMctYuSI=
Received: by 10.180.82.227 with SMTP id l3mr10525829wiy.1.1328284222128; Fri,
 03 Feb 2012 07:50:22 -0800 (PST)
Received: by 10.216.20.201 with HTTP; Fri, 3 Feb 2012 07:50:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189781>

Hi Everyone,

I tried looking for an answer to my problem online without much luck,
perhaps you can help me.  I'm SSHed from my laptop(Comp A) over to a
computer(Comp B) that has my git repo on it. I made some changes and
comitted them. Now I want to push them to my other server(Comp C). The
repository is password protected so if I'm physically at Comp B, I get
a gui prompt for my username and password. However Comp A does not
have X Forwarding setup to Comp B so I can't get the gui interface for
the username and password when I try to do the push.  Is there an
alternative way to provide my credentials when doing a git push that
does not require a gui?

--
Feanil Patel
