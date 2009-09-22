From: Neil Roberts <bpeeluk@yahoo.co.uk>
Subject: Re: [PATCH] builtin-mailinfo.c: Trim only first pair of square brackets in subject
Date: Tue, 22 Sep 2009 17:51:15 +0100
Message-ID: <87k4zqvs70.fsf@janet.wally>
References: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
	<1246310220-16909-1-git-send-email-rleigh@debian.org>
	<87hbuv5km2.fsf@janet.wally> <7vocp3t0oz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 18:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq8aJ-0004Jn-E6
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 18:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbZIVQvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 12:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbZIVQvN
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 12:51:13 -0400
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:39958 "EHLO
	smtpout.karoo.kcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbZIVQvM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 12:51:12 -0400
X-IronPort-AV: E=Sophos;i="4.44,432,1249254000"; 
   d="scan'208";a="128319566"
Received: from unknown (HELO localhost) ([91.84.60.59])
  by smtpout.karoo.kcom.com with ESMTP; 22 Sep 2009 17:51:15 +0100
In-Reply-To: <7vocp3t0oz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 22 Sep 2009 09:15:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128949>

> Neil Roberts <bpeeluk@yahoo.co.uk> writes:
>
>> Is this patch going to get applied?

Junio C Hamano <gitster@pobox.com> writes:

> I do not think it is likely to happen for a patch without much
> comments nor progress after this long blank period, without a
> refresher discussion.
>
> It definitely won't be applied silently in its original form,
> especially because the final comment in the old discussion on the
> patch in question began with "One could _update_ ..." from the author
> of the patch, and then nothing happened.
>
>     http://thread.gmane.org/gmane.comp.version-control.git/122418/focus=122466

Ok, fair enough. I submitted another patch to mailing list earlier which
at least addresses the issue mentioned by the original author when he
says "One could _update_ ...".

> I actually liked the much simpler one by Andreas in the original
> thread, but if you really want to use a regexp (which we didn't have
> to) we should make it configurable.  See the neighbouring discussion
> here as well.
>
>     http://thread.gmane.org/gmane.comp.version-control.git/123322

Oh I didn't see that thread, sorry. It's quite tricky to track the issue
when it is spread across multiple threads in a mailing list.

I'm not particularly set on the idea of it being a regular expression so
I'd be happy with an improved version of the existing loop. I'd
certainly be happy with it being an option as in your patch here:

http://article.gmane.org/gmane.comp.version-control.git/123340

If it is an option as in that patch surely it's quite safe as it can't
affect anyone's existing workflow? It might also be nice if it was
possible to change it in .git/config so you could enable it by default
for projects that use the '[topic]' syntax (such as Cairo and Clutter).

> I think we all agree that the behaviour should be improved, but I
> think neither Roger's patch nor Andreas's one was the solution..
> People who care need to carry discussions and proposed patches forward
> to help us agree on an acceptable solution.

Ok, well I do care about this issue and it annoys me regularly so I
would love to reopen the discussion. What are the issues with the last
patch mentioned above?

- Neil
