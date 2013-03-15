From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: building git ; need suggestion
Date: Fri, 15 Mar 2013 17:56:15 +0400
Message-ID: <20130315175615.0759deab3f313479eb24fb84@domain007.com>
References: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in>
	<20130315124415.GA23122@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Joydeep Bakshi <joydeep.bakshi@infoservices.in>,
	git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 14:56:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGV7t-0007Fh-2o
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 14:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab3CON4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 09:56:24 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:36687 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab3CON4V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 09:56:21 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r2FDuFjI008807;
	Fri, 15 Mar 2013 17:56:16 +0400
In-Reply-To: <20130315124415.GA23122@paksenarrion.iveqy.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218244>

On Fri, 15 Mar 2013 13:44:15 +0100
Fredrik Gustafsson <iveqy@iveqy.com> wrote:

[...]
> The webgui that's most populair is cgit and git-web. They don't do ACL
> afaik.

gitweb passes around branch names using a specific parameter in the
GET queries it operates on, like
http://gitweb.domain.local/?p=repo.git;a=shortlog;h=refs/heads/master

So I think it should be possible to somehow implement different
access rules in the front-end web server based on the qieries.
