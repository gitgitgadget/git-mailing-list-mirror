From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] git-submodule: New subcommand 'summary' (2) -
 show commit summary
Date: Thu, 06 Mar 2008 02:42:02 -0800
Message-ID: <7vwsog9ls5.fsf@gitster.siamese.dyndns.org>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
 <1204481710-29791-2-git-send-email-pkufranky@gmail.com>
 <7vk5kgiv0v.fsf@gitster.siamese.dyndns.org>
 <46dff0320803051816x5b957da0m6396d31cad8b4116@mail.gmail.com>
 <7v3ar4lcgf.fsf@gitster.siamese.dyndns.org>
 <46dff0320803052156u374d70c1i45f7789233beb32c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 11:43:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDZ7-0007VO-41
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757476AbYCFKmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 05:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758189AbYCFKmS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:42:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757944AbYCFKmR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 05:42:17 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 063AA1817;
	Thu,  6 Mar 2008 05:42:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 485E51816; Thu,  6 Mar 2008 05:42:11 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76366>

"Ping Yin" <pkufranky@gmail.com> writes:

>>  Why would you want to see the bottom one?  I still don't understand.
>>
>>  And I do not mean this as a rhetorical question.  I am here to learn and
>>  I would like to make sure that I do not make a suggestion based on wrong
>>  understanding of what the user wants to see.
>>
>>  I probably am lacking imagination to think of a good use scenario that
>>  showing the bottom one would be useful to the user, and you as the author
>>  of this patch must thought about what the user want much more than me.
>>
> Showing the bottom one can give the user an impression where
> the submodules goes at first glance if the user is familiar with the
> developing progress of the submodule.

I think you are talking about the top one (the latest commit), and we both
know that is interesting information to show.  I was asking about the most
ancient one, which often is "Initial version of frotz."
