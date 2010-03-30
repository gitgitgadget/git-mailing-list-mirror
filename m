From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] JGit 0.7.1 / EGit 0.7.1
Date: Tue, 30 Mar 2010 07:08:20 -0700
Message-ID: <20100330140820.GA2097@spearce.org>
References: <20100330012323.GD32653@spearce.org> <fabb9a1e1003291851i73bc1389hadc6380a2884b678@mail.gmail.com> <76c5b8581003300702t1fb31b22jc1e5e14f5c9edff4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 16:08:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwc7J-0006tp-EH
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 16:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832Ab0C3OIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 10:08:25 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:60933 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab0C3OIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 10:08:24 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3741637qwh.37
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 07:08:23 -0700 (PDT)
Received: by 10.229.190.129 with SMTP id di1mr1475593qcb.75.1269958103311;
        Tue, 30 Mar 2010 07:08:23 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm1444103ywh.46.2010.03.30.07.08.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 07:08:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <76c5b8581003300702t1fb31b22jc1e5e14f5c9edff4@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143566>

Eugene Sajine <euguess@gmail.com> wrote:
> Is it possible to have the local update site available for download to
> install Egit inside closed/firewalled LAN with no connectivity to
> internet?

Open a bug against EGit (under the Technology project) at
https://bugs.eclipse.org/.  We can try to add this package
format to our download page.

Right now I think you would need to mirror the update site
using the P2 director.  Its not pretty.  Its probably much
easier to install Maven 3, clone JGit and EGit sources,
and build from source.
 
-- 
Shawn.
