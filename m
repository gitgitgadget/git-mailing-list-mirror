From: "George Spelvin" <linux@horizon.com>
Subject: Re: Is there a way to cherry-pick a merge?
Date: 14 Jun 2013 17:36:56 -0400
Message-ID: <20130614213656.6813.qmail@science.horizon.com>
References: <7v7ghwo4u4.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Jun 14 23:37:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unbg8-0006k2-NB
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 23:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab3FNVg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 17:36:59 -0400
Received: from science.horizon.com ([71.41.210.146]:20152 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754338Ab3FNVg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 17:36:57 -0400
Received: (qmail 6814 invoked by uid 1000); 14 Jun 2013 17:36:56 -0400
In-Reply-To: <7v7ghwo4u4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227917>

"George Spelvin" <linux@horizon.com> writes:
>> Sometimes I'd like to repeat a previously performed merge, preserving
>> the commit message.  And, if possible, the conflict resolutions.
> 
> Is it "git merge commit^2"?

I suppose that was an obvious one to leave out of my alternatives list.

This is what I've been doing, but it requires I cut and paste the commit
message.  Preserving timestamps, author, etc. is even more awkward.

That's why I've been looking for an alternative.
