From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing
 submodule does not yield complete logs")
Date: Fri, 22 May 2015 16:41:24 +0200
Organization: gmx
Message-ID: <5b4bab2727a9fcee3a07724c64752cf9@www.dscho.org>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
 <73db761f3c737965f64ac45005f7a716@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 16:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvo8n-00048Z-0g
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 16:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364AbbEVOlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 10:41:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:59862 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756850AbbEVOlb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 10:41:31 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LqE5k-1ZQlEc1xNQ-00drvP; Fri, 22 May 2015 16:41:26
 +0200
In-Reply-To: <73db761f3c737965f64ac45005f7a716@www.dscho.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:FvKY/iqAypb6ZanLkl8yfJeVVX66lwZp/B3Nu0iqNQMIue8SKKS
 poXlmRAaiwoRG/a+1etv2CGc1j2TPXgTFJhsBkrHnTeEZErP5NhS8yTbtJx7bEG9H5HOFel
 0bJWZpJNC46DiHf+3/7Ey7QX5CGij4HO3u4MrKFndZUzF9u4bOmEtFv5lm8Ql4nDz/8ijlq
 DmcqRY/kvfemIScAA7JRg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269724>

Hi Roberto,

On 2015-05-22 11:42, Johannes Schindelin wrote:

> On 2015-05-22 10:33, Roberto Tyley wrote:
>> On Tuesday, 19 May 2015, Stefan Beller <sbeller@google.com> wrote:
>>> On Tue, May 19, 2015 at 12:29 PM, Robert Dailey
>>> <rcdailey.lists@gmail.com> wrote:
>>> > How do you send your patches inline?
>> [snip]
>>> This workflow discussion was a topic at the GitMerge2015 conference,
>>> and there are essentially 2 groups, those who know how to send email
>>> and those who complain about it. A solution was agreed on by nearly all
>>> of the contributors. It would be awesome to have a git-to-email proxy,
>>> such that you could do a git push <proxy> master:refs/for/mailinglist
>>> and this proxy would convert the push into sending patch series to the
>>> mailing list. It could even convert the following discussion back into
>>> comments (on Github?) but as a first step we'd want to try out a one
>>> way proxy.
>>>
>>> Unfortunately nobody stepped up to actually do the work, yet :(
>>
>>
>> Hello, I'm stepping up to do that work :) Or at least, I'm implementing a
>> one-way GitHub PR -> Mailing list tool, called submitGit:
>>
>> https://submitgit.herokuapp.com/
> 
> Wow!!!
> 
> I will make sure to test it with a couple of patches I want to submit anyway.

I just tried this with https://github.com/git/git/pull/139 and would like to tell you about two wishes I had immediately:

- If the author of a patch I am submitting is not myself, could submitGit maybe add that `From: ` line at the top of the mail?
- The patch series is sent without a cover letter, but it would be *really* great if a path series consisting of more than one patch could have the initial comment of the Pull Request as a cover letter, with the link to the original Pull Request at the bottom? This would also be the mail to use in the "In-reply-yo" header instead of the first patch.

Thanks so much!
Dscho
