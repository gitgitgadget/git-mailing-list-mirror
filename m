From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 11:59:56 -0700
Message-ID: <7vtzix5kr7.fsf@gitster.siamese.dyndns.org>
References: <47E69044.3000207@zytor.com>
 <7vzlsp5ly8.fsf@gitster.siamese.dyndns.org> <47E6A850.5060308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:00:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdVR3-0001dX-Dy
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbYCWTAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 15:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754578AbYCWTAI
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:00:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYCWTAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:00:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A58815F1;
	Sun, 23 Mar 2008 15:00:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9033B15EE; Sun, 23 Mar 2008 15:00:03 -0400 (EDT)
In-Reply-To: <47E6A850.5060308@zytor.com> (H. Peter Anvin's message of "Sun,
 23 Mar 2008 11:58:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77942>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
> ...
>>> 2. cg-restore
>>>
>>>    Cogito separated "reset" and "restore".  This is a syntactic sugar
>>>    issue, but having to type "git reset --hard -- path" makes me
>>>    nervous, especially since hitting Enter at the wrong time could have
>>>    serious and irrevocable consequences.
>>
>> Why --hard?
>
> To make it actually change the file in the working directory
> (equivalent to the -f option in cg-restore.)

Then "git checkout HEAD -- path"?
