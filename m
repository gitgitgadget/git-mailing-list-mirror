From: Jeremy O'Brien <obrien654j@gmail.com>
Subject: [BUG] git tab-completion gives error when "config" file exists in
	current directory
Date: Tue, 3 Feb 2009 22:24:31 -0500
Message-ID: <20090204032431.GA25244@newo.ZoomTown.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 04:25:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUYOa-0006pv-UW
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 04:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbZBDDYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 22:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbZBDDYV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 22:24:21 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:36106 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbZBDDYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 22:24:21 -0500
Received: by qyk4 with SMTP id 4so3125743qyk.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 19:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=F6zOxTIA0GZ0VZdRvBksuzSSlJ6I/iUPbEr02Z/Qm5c=;
        b=qGDuCU6HLjx/kqksK52SH1HvWGX/vByUL8AeSsfM7LE2HzXYKo0WHDWcwDyJmOtML4
         dFaCpYRSmGJAb1PPjPHJPW1AeRD49ZMicNyafznVo/YcaIvGy0/FQNVLCw4l06s42YFQ
         O3NeHdeYBgtHoKZn7lwuZUBO0pwtQgHx7QexM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=F6y447Ifr7XVxlYO3Clya/lCGrBQcATfcSAFVXAnumUEGgaOmOCWKQThZrVGLbjxxY
         DbTDKOSBgxY3Ko7vPnh4p+XjHZV76JHYvZ7psXbrzK+e0q1pSDcJjWi0ttET8A8PjJ23
         OlQ0z8AL0GCoDqiWHiLfb5nmNCxo3ws9EXxjM=
Received: by 10.214.116.20 with SMTP id o20mr1374290qac.260.1233717857707;
        Tue, 03 Feb 2009 19:24:17 -0800 (PST)
Received: from newo.ZoomTown.com (WS1-DSL-208-102-255-127.fuse.net [208.102.255.127])
        by mx.google.com with ESMTPS id 6sm1558549ywc.49.2009.02.03.19.24.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 19:24:17 -0800 (PST)
Mail-Followup-To: Jeremy O'Brien <obrien654j@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108290>

If a file "config" is present in the current directory, and no
.git/config or .gitconfig file exists, typing "git" and attempting tab
completion of any of its commands will yield an odd error like
"fatal: bad config file line 7 in config",
as git tries to use this file as a git config file.

Cheers,
Jeremy O'Brien
