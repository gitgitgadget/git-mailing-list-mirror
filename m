From: <dag@cray.com>
Subject: Re: Subtree in Git
Date: Mon, 22 Oct 2012 09:41:32 -0500
Message-ID: <nnga9vefu1v.fsf@transit.us.cray.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl> <nngzk9jvemb.fsf@transit.us.cray.com>
	<nngaa0z3p8b.fsf@transit.us.cray.com>
	<87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl>
	<nng4npe6zsj.fsf@transit.us.cray.com> <50830374.9090308@initfour.nl>
	<7vbofwgwso.fsf@alter.siamese.dyndns.org>
	<5084102A.2010006@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <greened@obbligato.org>,
	"Hilco Wijbenga" <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:44:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQJEZ-0008Ne-2l
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 16:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab2JVOnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 10:43:50 -0400
Received: from exprod6og101.obsmtp.com ([64.18.1.181]:42783 "EHLO
	exprod6og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab2JVOnt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 10:43:49 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob101.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUIVbneHsRHV07kXwmEeiHcO6BI24ac9Q@postini.com; Mon, 22 Oct 2012 07:43:49 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Mon, 22 Oct
 2012 09:41:33 -0500
In-Reply-To: <5084102A.2010006@initfour.nl> (Herman van Rink's message of
	"Sun, 21 Oct 2012 17:09:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208191>

Herman van Rink <rink@initfour.nl> writes:

> On 10/21/2012 08:32 AM, Junio C Hamano wrote:
>> Herman van Rink <rink@initfour.nl> writes:
>>
>>> Junio, Could you please consider merging the single commit from my
>>> subtree-updates branch? https://github.com/helmo/git/tree/subtree-updates
>> In general, in areas like contrib/ where there is a volunteer area
>> maintainer, unless the change something ultra-urgent (e.g. serious
>> security fix) and the area maintainer is unavailable, I'm really
>> reluctant to bypass and take a single patch that adds many things
>> that are independent from each other.
>
> Who do you see as volunteer area maintainer for contrib/subtree?
> My best guess would be Dave. And he already indicated earlier in the
> thread to be ok with the combined patch as long as you are ok with it.

Let's be clear.  Junio owns the project so what he says goes, no
question.  I provided some review feedback which I thought would help
the patches get in more easily.  We really shouldn't be adding multiple
features in one patch.  This is easily separated into multiple patches.

Then there is the issue of testcases.  We should NOT have git-subtree go
back to the pre-merge _ad_hoc_ test environment.  We should use what the
usptream project uses.  That will make mainlining this much easier in
the future.

If Junio is ok with overriding my decisions here, that's fine.  But I
really don't understand why you are so hesitant to rework the patches
when it should be realtively easy.  Certainly easier than convincing me
they are in good shape currently.  :)

                            -David
