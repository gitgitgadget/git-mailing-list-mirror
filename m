From: Sergei Organov <osv@javad.com>
Subject: Re: tracking a file from another project in my own project
Date: Tue, 22 Jan 2008 20:30:11 +0300
Message-ID: <877ii17opo.fsf@osv.gnss.ru>
References: <20080122093546.72db8da0@synchrotron-soleil.Fr>
	<7v7ii2rzbq.fsf@gitster.siamese.dyndns.org>
	<20080122145658.18b6ef89@synchrotron-soleil.Fr>
	<m3fxwplw1i.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: picca <picca@synchrotron-soleil.Fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 18:32:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHMz3-0004mx-9O
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 18:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbYAVRb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 12:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbYAVRbz
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 12:31:55 -0500
Received: from javad.com ([216.122.176.236]:1559 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbYAVRbz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 12:31:55 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m0MHUId52969;
	Tue, 22 Jan 2008 17:30:18 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JHMwt-0006vL-WC; Tue, 22 Jan 2008 20:30:12 +0300
In-Reply-To: <m3fxwplw1i.fsf@roke.D-201> (Jakub Narebski's message of "Tue\, 22 Jan 2008 07\:23\:28 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71463>

Jakub Narebski <jnareb@gmail.com> writes:
> picca <picca@synchrotron-soleil.Fr> writes:
>> Junio C Hamano <gitster@pobox.com> wrote:

[...]

>> > Or "merge -s subtree".
>> 
>> I read the git help merge -s explanation but I do not understand how
>> it can help in my case.
>
> Using subtree merge strategy you can join histories of your project
> and git.git, embedding git.git as a subdirectory like gitk and git-gui
> are now in git.git.  It is an alternative to using submodules.

Is subtree merge strategy documented?

$ grep subtree Documentation/merge-strategies.txt
$

-- Sergei.
