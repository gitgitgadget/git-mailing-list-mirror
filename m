From: Lars Noschinski <lars-2008-2@usenet.noschinski.de>
Subject: Re: How can I force git to recognize a change change in file modes?
Date: Sat, 28 Feb 2009 01:25:24 +0000 (UTC)
Message-ID: <20090228012524.GB17106@lars.home.noschinski.de>
References: <e38bce640902271717s46cf47f9i7c6bf5aac0d5f273@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 15:13:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdPwJ-0001Rq-Kp
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 15:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbZB1OKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 09:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZB1OKI
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 09:10:08 -0500
Received: from main.gmane.org ([80.91.229.2]:41496 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbZB1OKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 09:10:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LdPtC-0006fE-Ih
	for git@vger.kernel.org; Sat, 28 Feb 2009 14:10:02 +0000
Received: from xdsl-87-79-132-209.netcologne.de ([87.79.132.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 14:10:02 +0000
Received: from lars-2008-2 by xdsl-87-79-132-209.netcologne.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 14:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: xdsl-87-79-132-209.netcologne.de
Content-Disposition: inline
In-Reply-To: <e38bce640902271717s46cf47f9i7c6bf5aac0d5f273@mail.gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111767>

* Brent Goodrick <bgoodr@gmail.com> [09-02-28 02:17]:
> I checked in a slew of scripts, only to realize that the file
> permissions were too open (I want them to be chmod 700, not chmod
> 755).  Somehow I thought that git was tracking those permission bits,
> but simply using "chmod 700 <fileset>; git add <fileset>" did not add
> the change of file modes, well, at least git status output doesn't
> show it. Is there a way to do this?

Git does only track the executable bit.
