From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: git and cyrillic branches
Date: Thu, 25 Jul 2013 16:45:22 +0400
Message-ID: <20130725164522.f8841abf18742cc5f6e0fdbe@domain007.com>
References: <922031374754788@web29h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?KOI8-R?Q?=C9=D7=C1=CE=CF=D7_=C9=D7=C1=CE?= <xowirun@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Jul 25 14:45:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2KvC-0006Wj-0V
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 14:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab3GYMp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 08:45:26 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:46991 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab3GYMpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 08:45:25 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r6PCjMC0014062;
	Thu, 25 Jul 2013 16:45:23 +0400
In-Reply-To: <922031374754788@web29h.yandex.ru>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231132>

On Thu, 25 Jul 2013 15:19:48 +0300
=C9=D7=C1=CE=CF=D7 =C9=D7=C1=CE <xowirun@yandex.ru> wrote:

> hello! there is problem vith git and cyrillic (utf-8) names of
> branches. branch creates perfectly, but when i clone this remote
> branch to local host, there are 2 bugs:
> 1) "git branch" doesnt show checked branch with asterisk (while on
> remote server it does)
> 2) "git push" gives 2 errors: "fatal: BRANCH_NAME cannot be resolved
> to branch." and "fatal: The remote end hung up unexpectedly" thanks.

Works for me across two Debian systems: both have Git 1.7.10.4; user
accounts on both systems have LANG=3Den_US.UTF-8 configured in their
environment.

Do both of your systems (local and remote) have an UTF-8-enabled (or
encoding-agnostic, like "C") locale active?
