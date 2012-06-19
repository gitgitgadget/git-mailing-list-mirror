From: Ryan Lortie <desrt@desrt.ca>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 17:50:24 -0400
Message-ID: <4FE0F420.4030604@desrt.ca>
References: <4FE091FB.7020202@desrt.ca> <87a9zztdxt.fsf@thomas.inf.ethz.ch> <7v8vfj17de.fsf@alter.siamese.dyndns.org> <4FE0E493.1010308@desrt.ca> <7v8vfjyolq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:50:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh6Ji-0006N6-KW
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab2FSVu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:50:27 -0400
Received: from manic.desrt.ca ([207.192.74.61]:45973 "EHLO mail.desrt.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab2FSVu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:50:26 -0400
Received: from [172.16.1.217] (173-230-190-244.cable.teksavvy.com [173.230.190.244])
	by manic.desrt.ca (Postfix) with ESMTPSA id 6DE9A12CD23;
	Tue, 19 Jun 2012 16:50:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7v8vfjyolq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200256>

hi,

On 12-06-19 05:32 PM, Junio C Hamano wrote:
> Won't happen.  "git branch new-branch-name" has always been the way
> to create from HEAD.  Suddenly requiring an extra argument is a
> grave usability regression.

Reminder: we're talking only about the case where an unrelated branch 
with the same name already exists upstream...

Cheers
