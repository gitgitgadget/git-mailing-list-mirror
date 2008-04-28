From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Yet another Git tutorial
Date: Mon, 28 Apr 2008 16:34:33 -0700
Message-ID: <7v63u1blkm.fsf@gitster.siamese.dyndns.org>
References: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
 <20080428222717.GA6160@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Wiegley <johnw@newartisans.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 01:35:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqcsn-0006RB-6W
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 01:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934801AbYD1Xeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 19:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754999AbYD1Xen
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 19:34:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbYD1Xen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 19:34:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1209D4B39;
	Mon, 28 Apr 2008 19:34:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5D7084B36; Mon, 28 Apr 2008 19:34:36 -0400 (EDT)
In-Reply-To: <20080428222717.GA6160@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Tue, 29 Apr 2008 02:27:17 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80634>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Mon, Apr 28, 2008 at 02:39:46AM -0400, John Wiegley wrote:
>> I published another tutorial on Git today, this one describing the  
>> system from a "bottom up" perspective.  I know it's been written about  
>> this way before, but I was aiming at a bit more thoroughness, and a  
>> paced introduction to the basics.
>> 
>> There's a link to the PDF is in the following blog post:
>> 
>>   http://www.newartisans.com/blog_files/git.from.bottom.up.php
>
> In addition to what was mentioned before me:
>
> On page 6, instead of `git show --pretty=format:%T HEAD | head -1`, it
> is better to use `git log -1 --pretty=format:'%T' HEAD`. In general,
> `git show <commit-object>` is `git log -1 -p <commit-object>`, and
> you do not need diff here.

I may be misunderstanding what the discussion is about as I was not
following the thread, but is this a contest to find the most expensive way
to spell "git rev-parse HEAD^{tree}"?
