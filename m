From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 06 Feb 2013 23:01:32 +0100
Message-ID: <5112D2BC.2080407@alum.mit.edu>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com> <5110BD18.3080608@alum.mit.edu> <7v8v72u0vw.fsf@alter.siamese.dyndns.org> <51122D9D.9040100@alum.mit.edu> <20130206195515.GC21003@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:09:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3DAr-0007cb-Fz
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758713Ab3BFWIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:08:38 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:45681 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758314Ab3BFWIh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 17:08:37 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2013 17:08:37 EST
X-AuditID: 12074414-b7f9b6d0000008b3-0c-5112d2bf8928
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B1.9B.02227.FB2D2115; Wed,  6 Feb 2013 17:01:35 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r16M1WEb024946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Feb 2013 17:01:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130206195515.GC21003@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqLv/klCgwcnznBZdV7qZLBp6rzBb
	vL25hNHiR0sPs8X8QxNZHVg9ds66y+7xrHcPo8fFS8oef87vYfX4vEkugDWK2yYpsaQsODM9
	T98ugTtj06GpjAWbRSqaLv1kbmA8INDFyMkhIWAi0bDmMDOELSZx4d56ti5GLg4hgcuMEi+W
	b2SCcI4xSVzqnMgEUsUroC1x8O46FhCbRUBV4sfqVWA2m4CuxKKeZrAaUYEwid7X5xgh6gUl
	Ts58AlYjIqAh8fzTN7ANzALNjBJLrj8BWy0soC6xq/0QO4gtJHCeUeLXuhQQm1PAQGLjxq1g
	zcwCOhLv+h4wQ9jyEtvfzmGewCgwC8mOWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEv
	L7VI10IvN7NELzWldBMjJMxFdjAeOSl3iFGAg1GJh/f2UqFAIdbEsuLK3EOMkhxMSqK8eieB
	QnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4b3cC5XhTEiurUovyYVLSHCxK4rzfFqv7CQmkJ5ak
	ZqemFqQWwWRlODiUJHhXXgRqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFa3wx
	MF5BUjxAe9eCtPMWFyTmAkUhWk8xGnPsf9L+nJFj+28gKcSSl5+XKiXOuwukVACkNKM0D24R
	LMG9YhQH+luY9wBIFQ8wOcLNewW0iglolVIOP8iqkkSElFQDY9S2mzYmS43uVLjz/TLvFLqZ
	6nuNredArsKTXZznZS2zrqtMZsh6srako50/4feRm3UNpoG125h8eMoUxCbnJLAW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215649>

On 02/06/2013 08:55 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> [...]
>> But now every time I do a "gitk --all" or "git log --decorate", the
>> output is cluttered with all of his references (most of which are just
>> old versions of references from the upstream repository that we both
>> use).  I would like to be able to hide his references most of the time
>> but turn them back on when I need them.
>>
>> Scenario 5: Our upstream repository has gazillions of release tags under
>> "refs/tags/releases/...", sometimes including customer-specific
>> releases.  In my daily life these are just clutter.
> 
> For both of these use cases, putting the refs somewhere other than
> refs/heads, refs/tags, and refs/remotes should be enough to avoid
> clutter.

Thanks, yes, for release tags in particular your suggestion might be
workable.  But I also like the idea of being able to turn subsets of
references on and off easily, and have the choice persist until I change it.

> [...]
>> * Some small improvements (e.g. allowing *multiple* views to be
>>   defined) would provide much more benefit for about the same effort,
>>   and would be a better base for building other features in the future
>>   (e.g., local views).
> 
> Would advertising GIT_CONFIG_PARAMETERS and giving examples for server
> admins to set it in inetd et al to provide different kinds of access
> to a same repository through different URLs work?
> 
>> Thanks for listening.
>> Michael
>>
>> [1] Theoretically one could support multiple views of a single
>> repository by using something like "GIT_CONFIG=view_1_config git
>> upload-pack ..." or "git -c transfer.hiderefs=... git upload-pack ...",
>> but this would be awkward.
> 
> Ah, I missed this comment before.  What's awkward about that?  I
> think it's a clean way to make many aspects of how a repository is
> presented (including hook actions) configurable.

Awkwardness using GIT_CONFIG: the admin would have to maintain two
separate config files with mostly overlapping content.

Awkwardness using GIT_CONFIG_PARAMETERS or "-c transfer.hiderefs=...":
the hiderefs configuration would have to be maintained in some Apache
config or inetd or ... (or multiple places!) rather than in the
repository's config file, where it belongs.

Additional awkwardness using "-c transfer.hiderefs=...": AFAIK there is
no way to turn *off* a configuration variable via a command-line option.

It's all doable, but I find it awkward.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
