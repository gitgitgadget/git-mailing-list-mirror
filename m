From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: Revert option for git add --patch
Date: Thu, 8 Nov 2012 08:46:18 +0000 (UTC)
Message-ID: <loom.20121108T094500-131@post.gmane.org>
References: <CAPXHQbOxNG0XN80rH6mM6iSVtCtU26Yio_XQ=5ofBHBpZN3VyQ@mail.gmail.com> <CAPXHQbN0x-o_4rQO-Lq_gDTqs=beBE5XrrzJ1Th+7G2Lq7Dh_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 09:46:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWNlF-0004UX-5i
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 09:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114Ab2KHIqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 03:46:36 -0500
Received: from plane.gmane.org ([80.91.229.3]:54808 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab2KHIqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 03:46:35 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TWNl1-0004Mw-L8
	for git@vger.kernel.org; Thu, 08 Nov 2012 09:46:39 +0100
Received: from pc10.ivo.park.gdynia.pl ([153.19.128.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 09:46:39 +0100
Received: from michal.kiedrowicz by pc10.ivo.park.gdynia.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 09:46:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 153.19.128.10 (Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20100101 Firefox/10.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209149>

Nathan Broadbent <nathan.f77 <at> gmail.com> writes:

> I would like to propose a revert option for 'git add --patch', that
> reverts the hunk. I often use `git add -p` to skip whitespace changes
> when preparing a patch, and a 'revert' option would save me from
> running 'git checkout <file>' after I've staged the desired changes.


Doesn't `git checkout -p` do what you describe?

Kind regards,
Michal Kiedrowicz
