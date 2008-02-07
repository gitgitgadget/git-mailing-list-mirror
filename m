From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] git.el: automatically revert emacs buffers
Date: Thu, 07 Feb 2008 16:03:53 +0300
Message-ID: <87tzkk2a12.fsf@osv.gnss.ru>
References: <874pcnh4ej.fsf@osv.gnss.ru> <87ir10q5yy.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 14:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN6Qq-0002fS-M4
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 14:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbYBGNEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 08:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbYBGNEQ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 08:04:16 -0500
Received: from javad.com ([216.122.176.236]:4577 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489AbYBGNEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 08:04:15 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m17D41d37227;
	Thu, 7 Feb 2008 13:04:01 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JN6Px-0001kx-Cp; Thu, 07 Feb 2008 16:03:53 +0300
In-Reply-To: <87ir10q5yy.fsf@wine.dyndns.org> (Alexandre Julliard's message of "Thu\, 07 Feb 2008 13\:57\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72936>

Alexandre Julliard <julliard@winehq.org> writes:
> Sergei Organov <osv@javad.com> writes:
>
>> If new custom variable git-auto-revert is 't', after git-revert-file,
>> revert corresponding emacs buffers from reverted files provided the
>> buffers were not changed. This is how pcl-cvs behaves.
>>
>> * git-auto-revert: new customizable variable.
>> * git-revert-some-buffers: new function.
>> * git-revert-file: call git-revert-some-buffers.
>
> I had implemented this a bit differently in the patch series I just
> sent, I did it the VC way by also checking for modified buffers and
> refusing to revert their corresponding files. I didn't add a custom
> variable for it though, so I'll merge that part of your patch.

I don't think the custom variable is necessary. I added it only because
PCL-CVS had it, even though I didn't ever customize it in PCL-CVS. So
please feel free to drop my patch entirely.

-- Sergei Organov.
