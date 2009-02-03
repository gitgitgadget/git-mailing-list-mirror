From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2git migration - cloning CVS repository
Date: Tue, 03 Feb 2009 13:45:06 +0100
Message-ID: <49883C52.3060102@alum.mit.edu>
References: <286817520902020624y7f4c2942l34fafc0fe0fa0b48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rostislav Svoboda <rostislav.svoboda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 13:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUKfl-0003SM-5F
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 13:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbZBCMpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 07:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbZBCMpL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 07:45:11 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50480 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbZBCMpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 07:45:09 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n13Cj602000947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Feb 2009 13:45:06 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <286817520902020624y7f4c2942l34fafc0fe0fa0b48@mail.gmail.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108182>

Rostislav Svoboda wrote:
> I'd like to clone a CVS repository to a local machine in order to
> prepare it for a migration to git. I tried:
> 
> $git cvsimport -p x -v -d
> [...]

If your goal is a high-quality one-time conversion from CVS to git, then
you would be better off getting a filesystem copy of the CVS repository
then converting with cvs2git [1].  "git cvsimport" does not convert a
CVS repository faithfully to git, though it might barely be adequate if
you absolutely need to keep git and CVS in sync.

If you do not have filesystem access to your CVS repository, you might
be able to clone it using CVSSuck [2,3].

Michael
the cvs2svn/cvs2git maintainer

[1] http://cvs2svn.tigris.org/cvs2git.html
[2] http://cvs.m17n.org/~akr/cvssuck/
[3] http://cvs2svn.tigris.org/faq.html#repoaccess
