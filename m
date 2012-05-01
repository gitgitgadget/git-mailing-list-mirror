From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 10:29:59 -0700
Message-ID: <4FA01D97.6040803@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com> <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com> <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com> <7vvckgbew5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 19:30:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGts-0003fD-6I
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834Ab2EARaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:30:01 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:18949 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab2EARaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:30:00 -0400
X-IronPort-AV: E=Sophos;i="4.75,512,1330934400"; 
   d="scan'208";a="13244128"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 01 May 2012 10:30:00 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q41HTx4V001971;
	Tue, 1 May 2012 10:29:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vvckgbew5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196706>

On 4/30/12 23:21 , Junio C Hamano wrote:
> Michael Witten<mfwitten@gmail.com>  writes:
>
>> Here's a start for a more precise discussion.
> When does the "Cache server" updated from the "$uri_for_central_repo" in
> this picture?  If it is after push by either from Machine A or B, somebody
> needs to reconcile that and whatever A/B pushed.
>
> And between Hg style "split head" or Git style refs/remotes/* namespaces
> there is no difference to perform that reconcilation.  Somebody needs to
> run "merge" on the "Cache server" and at some point the result needs to be
> pushed to the $uri_for_central_repo back.
Untrue.  In the hg style, the reconciliation can happen at any 
repository.  Or never.  It's completely legitimate to allow this "split 
head" to become the beginning of a de facto branch.  The only difference 
between a "split head" and a branch is whether the same branch pointer 
points to both or whether they have different branch pointers.  They can 
even have both.

--rich
