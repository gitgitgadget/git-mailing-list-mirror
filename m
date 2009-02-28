From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: How can I force git to recognize a change change in file modes?
Date: Sat, 28 Feb 2009 04:55:31 +0100
Message-ID: <20090228045531.14399ebf@perceptron>
References: <e38bce640902271717s46cf47f9i7c6bf5aac0d5f273@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 04:57:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdGK2-0007jZ-7T
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 04:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbZB1Dzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 22:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbZB1Dzi
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 22:55:38 -0500
Received: from zoidberg.org ([88.198.6.61]:59249 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753882AbZB1Dzh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 22:55:37 -0500
Received: from perceptron (xdsl-78-34-136-74.netcologne.de [::ffff:78.34.136.74])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sat, 28 Feb 2009 04:55:33 +0100
  id 004043DB.49A8B5B6.000003B5
In-Reply-To: <e38bce640902271717s46cf47f9i7c6bf5aac0d5f273@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111746>

Hi,

> I checked in a slew of scripts, only to realize that the file
> permissions were too open (I want them to be chmod 700, not chmod
> 755).  Somehow I thought that git was tracking those permission bits,
> but simply using "chmod 700 <fileset>; git add <fileset>" did not add
> the change of file modes, well, at least git status output doesn't
> show it. Is there a way to do this?

git doesn't track permissions quite that closely; all it remembers is
whether the file should be executable or not.

-Jan
