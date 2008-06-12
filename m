From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Thu, 12 Jun 2008 03:00:34 +0200
Message-ID: <48507532.3030007@keyaccess.nl>
References: <484F2174.9020508@keyaccess.nl> <7v3anjbmov.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 03:01:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6bBr-0000tq-OB
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 03:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbYFLBAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 21:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYFLBA3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 21:00:29 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:56133 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYFLBA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 21:00:29 -0400
Received: from [213.51.146.188] (port=46176 helo=smtp3.tilbu1.nb.home.nl)
	by smtpq1.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6bAx-0007MO-R6; Thu, 12 Jun 2008 03:00:27 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:54767 helo=[192.168.0.3])
	by smtp3.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6bAx-000566-D1; Thu, 12 Jun 2008 03:00:27 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7v3anjbmov.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84690>

On 12-06-08 01:01, Junio C Hamano wrote:

> Rene Herman <rene.herman@keyaccess.nl> writes:

>> The manpages seem to be making somewhat of a point of mentioning "git
>> pull . <branch>" as the way to merge a local branch into the current
>> one but a simple "git merge <branch>" seems to work well. Is there a
>> difference?
> 
> There isn't any.
> 
> "git pull . this_branch" is just a natural and logical consequence that
> you can fetch and merge a branch B from remote U with "git pull $U $B".
> 
> "git merge that_branch" exists and useful because people on average merge
> local branches more than they fetch and merge from remote repository.

Thank you. Slowly getting more comfortable with git...

Rene.
