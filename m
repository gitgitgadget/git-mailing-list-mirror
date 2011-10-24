From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Mon, 24 Oct 2011 22:49:49 +0100
Message-ID: <20111024214949.GA5237@amd.home.annexia.org>
References: <20111024201153.GA1647@x4.trippels.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>, meyering@redhat.com
X-From: git-owner@vger.kernel.org Mon Oct 24 23:50:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RISPP-0005Y1-6C
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 23:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968Ab1JXVuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 17:50:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62812 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754355Ab1JXVuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 17:50:00 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p9OLnv9v014085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 24 Oct 2011 17:49:58 -0400
Received: from localhost (vpn1-7-115.ams2.redhat.com [10.36.7.115])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p9OLntOF019859;
	Mon, 24 Oct 2011 17:49:57 -0400
Content-Disposition: inline
In-Reply-To: <20111024201153.GA1647@x4.trippels.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184186>

On Mon, Oct 24, 2011 at 10:11:53PM +0200, Markus Trippelsdorf wrote:
> Suddenly I'm getting strange protection faults when I run "git grep" on
> the gcc tree:

Jim Meyering and I are trying to chase what looks like a similar or
identical bug in git-grep.  We've not got much further than gdb and
valgrind so far, but see:

https://bugzilla.redhat.com/show_bug.cgi?id=747377

It's slightly suspicious that this bug only started to happen with the
latest glibc, but that could be coincidence, or could be just that
glibc exposes a latent bug in git-grep.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://et.redhat.com/~rjones/virt-df/
