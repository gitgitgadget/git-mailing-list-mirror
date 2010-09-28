From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Another way to compare tools: is it possible to transfer full
 history?
Date: Tue, 28 Sep 2010 17:48:33 +0200
Message-ID: <4CA20E51.1000503@alum.mit.edu>
References: <loom.20100928T153519-936@post.gmane.org> <4CA20169.2040606@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tuomo <tuo.tie@gmail.com>, git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 17:49:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0cQV-0002N5-Iz
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 17:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab0I1PtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 11:49:02 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50622 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab0I1PtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 11:49:01 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.112] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o8SFmXXL027026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 28 Sep 2010 17:48:33 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.24) Gecko/20100317 Thunderbird/2.0.0.24 Mnenhy/0.7.6.666
In-Reply-To: <4CA20169.2040606@dbservice.com>
X-Enigmail-Version: 1.0.1
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157437>

On 09/28/2010 04:53 PM, Tomas Carnecky wrote:
> (shameless plug: just this weekend I started collecting the various fast
> import/export tools and made a webpage about it:
> http://caurea.org/fast-export-import/. It's far from complete though.
> And if you know any tools that perform better than those I've listed,
> I'd be glade to update the page).

cvs2svn [1] (in particular the cvs2git [2] and cvs2bzr [3] variants,
which are part of the same project) can convert from CVS to fast-import
format.  It is mature and actively maintained [4], has a lot of features
[5], help is available, and hopefully you agree that the documentation
[6,7] is well-written.

Michael

[1] http://cvs2svn.tigris.org/
[2] http://cvs2svn.tigris.org/cvs2git.html
[3] http://cvs2svn.tigris.org/cvs2bzr.html
[4] https://www.ohloh.net/p/cvs2svn
[5] http://cvs2svn.tigris.org/features.html
[6] http://cvs2svn.tigris.org/cvs2svn.html
[7] http://cvs2svn.tigris.org/faq.html
