From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 02:49:16 -0500
Message-ID: <85mwfc4hab.fsf@stephe-leake.org>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
	<5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch>
	<53558A54.4060801@gmail.com> <53558ae6f1282_604be1f30cf3@nysa.notmuch>
	<53559020.1050407@gmail.com> <53558f6269f91_640076f2f08f@nysa.notmuch>
	<857g6h5ssh.fsf@stephe-leake.org>
	<5356996d12ede_3e5aed7308e5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 09:49:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcrvq-00043d-3l
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 09:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbaDWHtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 03:49:19 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:22177 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932156AbaDWHtT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2014 03:49:19 -0400
Received: from [75.87.81.6] ([75.87.81.6:52220] helo=TAKVER)
	by cdptpa-oedge02 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 6F/38-30401-D7077535; Wed, 23 Apr 2014 07:49:17 +0000
In-Reply-To: <5356996d12ede_3e5aed7308e5@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 22 Apr 2014 11:31:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246813>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Stephen Leake wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Ilya Bobyr wrote:
>> >> On 4/21/2014 2:17 PM, Felipe Contreras wrote:
>> >> > Ilya Bobyr wrote:
>> >> >
>> >> >> Also, most have names that start with either "pre-" or "post-".
>> >> >> It seems reasonable for both "pre-update-branch" and
>> >> >> "post-update-branch" to exist.
>> >> > I don't see what would be the point in that.
>> >> 
>> >> Do you see the point in the other hooks doing that?
>> >
>> > Yes, there a reason for the existance of those hooks. Now tell me why would
>> > anybody use post-update-branch instead of pre-update-branch?
>> 
>> I have a branch which should always be recompiled on update;
>> post-update-branch would be a good place for that.
>
> And why would pre-update-branch not serve that purpose?

Because the code that needs to be compiled is not yet in the workspace

-- 
-- Stephe
