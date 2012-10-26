From: Herman van Rink <rink@initfour.nl>
Subject: Re: Subtree in Git
Date: Fri, 26 Oct 2012 15:10:43 +0200
Organization: Initfour Websolutions
Message-ID: <508A8BD3.9020901@initfour.nl>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com> <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl> <87fwbgbs0h.fsf@smith.obbligato.org> <7v8vh78dag.fsf@alter.siamese.dyndns.org> <4FA82799.1020400@initfour.nl> <nngzk9jvemb.fsf@transit.us.cray.com> <nngaa0z3p8b.fsf@transit.us.cray.com> <87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl> <nng4npe6zsj.fsf@transit.us.cray.com> <50830374.9090308@initfour.nl> <7vbofwgwso.fsf@alter.siamese.dyndns.org> <5084102A.2010006@initfour.nl> <nnga9vefu1v.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, greened@obbligato.org,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: dag@cray.com
X-From: git-owner@vger.kernel.org Fri Oct 26 15:11:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRjgm-00088S-C5
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 15:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab2JZNKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 09:10:52 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:35453 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab2JZNKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 09:10:51 -0400
Received: from [192.168.42.73] (initfour.xs4all.nl [80.101.157.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id 9F46B9FC159;
	Fri, 26 Oct 2012 15:10:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <nnga9vefu1v.fsf@transit.us.cray.com>
X-Enigmail-Version: 1.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208438>

On 10/22/2012 04:41 PM, dag@cray.com wrote:
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
> Let's be clear.  Junio owns the project so what he says goes, no
> question.  I provided some review feedback which I thought would help
> the patches get in more easily.  We really shouldn't be adding multiple
> features in one patch.  This is easily separated into multiple patches.
>
> Then there is the issue of testcases.  We should NOT have git-subtree go
> back to the pre-merge _ad_hoc_ test environment.  We should use what the
> usptream project uses.  That will make mainlining this much easier in
> the future.
>
> If Junio is ok with overriding my decisions here, that's fine.  But I
> really don't understand why you are so hesitant to rework the patches
> when it should be realtively easy.  Certainly easier than convincing me
> they are in good shape currently.  :)

If it's so easy to rework these patches then please do so yourself.
It's been ages since I've worked on this so I would also have to
re-discover everything.

And yes it's ugly, but so is the code that you've merged in.
Which you haven't changed a single line in after merging. So it's still
the version from Avery which hasn't been maintained for the last two years.

This ball of wax is still a big improvement in my opinion.

Feel free to scrape the github forks for improvements on your own,
cleanup the code style and create fitting test cases.
But if you intend on taking in changes only when presented to you on a
silver patter, then we're better of with subtree removed from the
contrib tree.

What would a random user have to do to get a patch in? I've found a
number of subtree related mails on the git-user list go completely
unanswerd.
Amongst them a patch from James Nylen wich seems very reasonable.

-- 

Met vriendelijke groet / Regards,

Herman van Rink
Initfour websolutions
