From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Anonymous commit (empty Author and Committer)
Date: Fri, 30 Oct 2015 17:33:04 +0300
Message-ID: <20151030173304.b199c558199149fea057dc86@domain007.com>
References: <56337DF8.5050802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: The development of GRUB 2 <grub-devel@gnu.org>,
	git@vger.kernel.org, savannah-users@gnu.org
To: Andrei Borzenkov <arvidjaar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 15:33:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsAkT-0008SA-Pa
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 15:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997AbbJ3Odl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 10:33:41 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:37968 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758636AbbJ3Odk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 10:33:40 -0400
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t9UEX4md016739;
	Fri, 30 Oct 2015 17:33:05 +0300
In-Reply-To: <56337DF8.5050802@gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280487>

On Fri, 30 Oct 2015 17:26:00 +0300
Andrei Borzenkov <arvidjaar@gmail.com> wrote:

> See 
> http://git.savannah.gnu.org/cgit/grub.git/commit/?id=206676601eb853fc319df14cd3398fbdfde665ac
> 
> I was not even aware that this is possible. Is there anything on
> server side that can prevent it?

A hook running on "update" event could check the commits being pushed
and reject the update if some commit among those does not pass the
necessary checks.

Please see the githooks(5) manual page.
