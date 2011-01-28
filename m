From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Permissions and authorisations in git repository
Date: Fri, 28 Jan 2011 15:06:31 +0300
Message-ID: <20110128150631.33be0a9d.kostix@domain007.com>
References: <1296214884133-5969556.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: vikram2rhyme <vikram2rhyme@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 13:14:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PinDb-000309-0c
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 13:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab1A1MN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 07:13:57 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:39559 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010Ab1A1MN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 07:13:57 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jan 2011 07:13:56 EST
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id p0SC6WRc013959;
	Fri, 28 Jan 2011 15:06:33 +0300
In-Reply-To: <1296214884133-5969556.post@n2.nabble.com>
X-Mailer: Sylpheed 3.0.0 (GTK+ 2.10.14; i686-pc-mingw32)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165613>

On Fri, 28 Jan 2011 03:41:24 -0800 (PST)
vikram2rhyme <vikram2rhyme@gmail.com> wrote:

> I am wondering if there are any permission and authorization control
> over git repository.
[...]

In the simplest case -- r/w access via SSH -- those who know the
login/password or possess the necessary private key have (full) access
to the repository. The repository can also be made accessible for
read-only via Git protocol (as a whole as well). This can be used for
simple write/read access discrimination.
If a more fine-grained control
is needed, third-party tools exist: gitolite:
https://github.com/sitaramc/gitolite gitosis: http://swik.net/gitosis

Note that as Git does not suffer from a centralised VCS syndrome of
having a single repository shared by everyone involved, the problem
you're facing might not exist at all: every developer or a group of
related developers maintains their own repository and a "central"
repository (in whatever sense you're willing to put into it) is owned
by a special person or a group of persons.
