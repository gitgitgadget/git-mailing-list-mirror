From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Installation instructions for gitweb?
Date: Fri, 23 Mar 2007 17:12:10 +0100
Message-ID: <20070323161210.GI8017@planck.djpig.de>
References: <etufpl$7en$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Mar 23 17:13:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUmOB-00059x-CO
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 17:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992516AbXCWQM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 12:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992513AbXCWQM4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 12:12:56 -0400
Received: from planck.djpig.de ([85.10.192.180]:36839 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992500AbXCWQMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 12:12:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 5D43588136;
	Fri, 23 Mar 2007 17:12:11 +0100 (CET)
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (smtp.lichtenheld.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27140-09; Fri, 23 Mar 2007 17:12:10 +0100 (CET)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 8AD7188137; Fri, 23 Mar 2007 17:12:10 +0100 (CET)
Mail-Followup-To: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <etufpl$7en$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lichtenheld.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42945>

On Thu, Mar 22, 2007 at 02:52:53PM -0300, Han-Wen Nienhuys wrote:
> I'm trying to get gitweb to serve my local repositories on the intranet
> here, but I am not successful in getting it to run.  I got as far as
> getting gitweb page, containing no projects but only "403 forbidden - No
> projects found." I tried setting the projects_list to a directory, a
> subdirectory, a file with the projects to be published, etc.

>From looking at the code this error can mean quite a few things:

- you set $projectroot incorrectly
- you set $projects_list incorrectly
- you set $export_ok to something != "" and didn't create
  the necessary files
- your repositories lack HEAD refs (don't know how this could happen,
  though)

More diagnosis is difficult without knowing your exact setup.

> Is there a guide on setting up gitweb for hare-brained people like me
> that don't know apache and don't know perl? In particular, the format of
> gitweb_conf.perl is not documented at all.

gitweb_conf.perl is just included as perl code. It is primarly useful
for overriding the variables defined at the top of gitweb.cgi

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
