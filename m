From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: determine a linux kernel version of a patch file
Date: Fri, 15 May 2015 19:41:01 +0200
Organization: gmx
Message-ID: <c97f7591e4bf884ee810699f1e5278dd@www.dscho.org>
References: <CAJmOuExq3WF26Gufr5bAA7w3=EMxJ80NKMXf8Dgi0TK7kVXStA@mail.gmail.com>
 <vpqr3qicabd.fsf@anie.imag.fr> <1431709433.1401.9.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Pawel Por <porparek@gmail.com>, git@vger.kernel.org
To: Kelvin Li <ltwisabc@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 19:41:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtJbj-0008Rz-Tu
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 19:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbbEORlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 13:41:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:58273 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbbEORlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 13:41:06 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MOfx8-1YnHCK2EvW-0063yv; Fri, 15 May 2015 19:41:02
 +0200
In-Reply-To: <1431709433.1401.9.camel@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:9SkI1fk4//22rHEqwML/0kMZtp1kSNOCmQJAEba9dwtGjUh4k0t
 aB6xoVYqXBI9ylWGXJxrTq+cqOZbyA0d4H+jrDFtWQafEh89BLalzYH498pcUfyszW/SIi0
 K4D3MzTEVt3Fp1hFvqEMkiiOCz6B9MN5mXgTToU7WaFhEouS0RzDXD5edN0kFp+cT8hnjRg
 6qPx1/7RuI/iFgGpSi/zA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269160>

Hi,

On 2015-05-15 19:03, Kelvin Li wrote:
> On Fri, 2015-05-15 at 14:08 +0200, Matthieu Moy wrote:
>> Pawel Por <porparek@gmail.com> writes:
>>
>> > At the beginning I'm sorry if this post is completely unrelated to
>> > this mailing list.
>> > I'm trying to find the base linux kernel version from which a patch
>> > has been created and posted to LKML.
>> > Most patches contain the index line. Is it the well known git index
>> > (staging area) ?
>>
>> This is the id of the blob object corresponding to the _file_ being
>> patched (index <from>..<to> <mode>). That's why you don't see it in git
>> log: git log shows you ids for commit objects (which point to trees,
>> which in turn points to blob).
>>
>> See Johannes' answer for how you can get some possible commits.
>>
> 
> Come to think of it, why is that line named "index"? Conceptually, this
> "diff header index" seems distinct from the "staging area index", but
> calling both "index" is confusing, in my opinion.
> 
> Is there already a note about this in the docs somewhere? At the very
> least, "git help diff" seems to happily use both senses of the word
> without any acknowledgement that we're overloading it.

By default, `git diff` works on the index, unless you force it to compare revisions or the working directory to a revision. I guess that is where the wording comes from.

In any case, it is too late to change it now...

Ciao,
Johannes
