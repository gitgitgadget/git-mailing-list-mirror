From: Herman van Rink <rink@initfour.nl>
Subject: Re: Subtree in Git
Date: Sun, 21 Oct 2012 22:23:15 +0200
Organization: Initfour websolutions
Message-ID: <508459B3.6030403@initfour.nl>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com> <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl> <87fwbgbs0h.fsf@smith.obbligato.org> <7v8vh78dag.fsf@alter.siamese.dyndns.org> <4FA82799.1020400@initfour.nl> <nngzk9jvemb.fsf@transit.us.cray.com> <nngaa0z3p8b.fsf@transit.us.cray.com> <87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl> <nng4npe6zsj.fsf@transit.us.cray.com> <50830374.9090308@initfour.nl> <7vbofwgwso.fsf@alter.siamese.dyndns.org> <5084102A.2010006@initfour.nl> <7vfw57fvtl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: greened@obbligato.org, Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, dag@cray.com
X-From: git-owner@vger.kernel.org Sun Oct 21 22:26:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ26m-00067S-Vo
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 22:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538Ab2JUUXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 16:23:20 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:33480 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab2JUUXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 16:23:20 -0400
Received: from [192.168.65.204] (hosted-by.initfour.nl [83.137.144.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id E8C8F9FC413;
	Sun, 21 Oct 2012 22:23:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <7vfw57fvtl.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208145>

On 10/21/2012 09:51 PM, Junio C Hamano wrote:
> Herman van Rink <rink@initfour.nl> writes:
>
>> On 10/21/2012 08:32 AM, Junio C Hamano wrote:
>>> Herman van Rink <rink@initfour.nl> writes:
>>>
>>>> Junio, Could you please consider merging the single commit from my
>>>> subtree-updates branch? https://github.com/helmo/git/tree/subtree-updates
>>> In general, in areas like contrib/ where there is a volunteer area
>>> maintainer, unless the change something ultra-urgent (e.g. serious
>>> security fix) and the area maintainer is unavailable, I'm really
>>> reluctant to bypass and take a single patch that adds many things
>>> that are independent from each other.
>> Who do you see as volunteer area maintainer for contrib/subtree?
>> My best guess would be Dave. And he already indicated earlier in the
>> thread to be ok with the combined patch as long as you are ok with it.
> Yes, dag volunteered to be the area maintainer to act as a
> gatekeeper for me.
>
> The message you addressed to me was sent as a response to his
> message, where he gave you specific suggestions to improve the patch
> and turn it into a readable series instead of a single ball of wax
> and it looked to me as if you are trying to bypass him and shove the
> single ball of wax to our history over his objection.
>
> I haven't formed an opinion on the particular change as to how bad
> its collapsing unrelated changes into a single change is. Maybe they
> are not as unrelated and form a coherent whole.  Maybe not.  Also I
> personally do not mind too much if the area maintainer for contrib/
> has a lower standard for atomicity of commits compared to the rest
> of the system.  But I do prefer the decision to be made at the level
> of area maintainer's, and have issues when people try to bypass
> without a good reason.
>
> Note that I was not following the thread very closely, so I may have
> misread the discussion.  I read his "Unless Junio accepts..." to
> mean "I (dag) still object, but if Junio accepts that patch I object
> to directly, there is nothing I can do about it".  That is very
> different from "I am on the fence and cannot decide it is a good
> patch or not.  I'll let Junio decide; I am OK as long as he is".
>
> Thanks.

Thanks for explaining.
I had read it the latter way.

The problem is that I don't have the time to split all these out. Dag
has indicated that he does not have the time either.

This single ball of wax was already an alternative to the 'messy' merge
history it had accumulated. The result of merging from dozens of github
forks with numerous levels of parallel/contra-productive whitspace fixes.

Dag: Did I read it correctly?

-- 

Met vriendelijke groet / Regards,

Herman van Rink
Initfour websolutions
