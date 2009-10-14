From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodule-summary
Date: Wed, 14 Oct 2009 23:27:25 +0200
Message-ID: <4AD6423D.10307@web.de>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org> <4AD61880.4040600@web.de> <7vfx9lbtpf.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 23:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyBSK-0006uq-HE
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 23:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760749AbZJNV2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 17:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759485AbZJNV2J
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 17:28:09 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:49985 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760633AbZJNV2G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 17:28:06 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5850F12BFC9EF;
	Wed, 14 Oct 2009 23:27:29 +0200 (CEST)
Received: from [80.128.106.100] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1MyBNZ-0008VH-00; Wed, 14 Oct 2009 23:27:29 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <7vfx9lbtpf.fsf_-_@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+v3vbr828FZ+LGzv/EwHswsNwqT0UJseccTY69
	hPRo82dA/5qbugHR2LwKBOWMxMHKKJ+Ov2bWhkdzf0Ex6B9UFT
	RKDlUM3m9yhJIYrqJNdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130341>

Junio C Hamano schrieb:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Dscho condensed his initial patch with the interdiff you mentioned,
>> additionally silenced a compiler warning and activated --first-parent.
>> This follows as patch 1/4. Patches 2/4 to 4/4 contain my two bugfixes
>> and the testcase i copied from submodule summary while adapting it to
>> the changes of the output format.
> 
> I think 2 and 3 should be squashed into the first one.  I do not see any
> good reason for keeping initial "oops that was wrong" etched in stone,
> once the review process has revealed obvious bugs and reasonable fixes
> have been given to them.  If the original author re-spun a v2 patch, that
> is the normal thing that happens.

Right, will do.


> I am not happy with the option name --submodule-summary, by the way.
> Naming this option --submodule-summary shows the confusion between this
> series being the _latest_ great invention and this series being the _last_
> great invention.  I'd freely grant the former but would like to avoid the
> latter.
> 
> I have this nagging suspicion that we should leave the door open for later
> addition of --submodule=full that actually gives the patch text for the
> entire aggregated tree, perhaps recursively.  People may want to add even
> more other useful modes that we do not think of right now. It would be
> better to name this --submodule=shortlog or something.
> 
> If users like the shortlog mode (or the full mode) very much, perhaps the
> current default output, which shows the differences between two commit
> object names, can become a --submodule=summary (or --submodule=twoline)
> mode later, and the shortlog mode could become the default.

Good point. (Personally i like the options --submodule=shortlog and
--submodule=twoline. Because IMHO --submodule=summary could make
people expect similar output to git submodule summary, no?).

Thanks for your feedback, will send new patches soon.
