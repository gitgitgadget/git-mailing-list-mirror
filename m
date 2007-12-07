From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Let git-help prefer man-pages installed with this version of git
Date: Fri, 07 Dec 2007 13:16:06 +0300
Message-ID: <87d4ti7qu1.fsf@osv.gnss.ru>
References: <87hciv7jkt.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0712062107520.21625@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 07 11:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0aGB-0005nM-Kv
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 11:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbXLGKQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 05:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbXLGKQS
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 05:16:18 -0500
Received: from javad.com ([216.122.176.236]:4217 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200AbXLGKQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 05:16:16 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lB7AGCU12452;
	Fri, 7 Dec 2007 10:16:12 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1J0aFa-00026s-VU; Fri, 07 Dec 2007 13:16:06 +0300
In-Reply-To: <Pine.LNX.4.64.0712062107520.21625@wbgn129.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Thu\, 6 Dec 2007 21\:09\:05 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67407>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 6 Dec 2007, Sergei Organov wrote:
>
>> Prepend $(prefix)/share/man to the MANPATH environment variable before 
>> invoking 'man' from help.c:show_man_page().
>
> This commit message is severely lacking.  Why would you _ever_ prefer the 
> installed man pages before invoking "man", which should find them
> anyway?

Obviously because you want manual pages corresponding to the version of
git you are invoking, not any random version of man-pages man may find
by default.

-- 
Sergei.
