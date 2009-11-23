From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: OS X and umlauts in file names
Date: Mon, 23 Nov 2009 21:31:22 +0100
Message-ID: <4B0AF11A.3030804@syntevo.com>
References: <4B0ABA42.1060103@syntevo.com> <200911231845.04325.trast@student.ethz.ch> <4B0AD02E.1040408@syntevo.com> <alpine.DEB.1.00.0911231916510.4897@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 23 21:31:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCfZ6-0003yL-P4
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 21:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbZKWUbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 15:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbZKWUbE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 15:31:04 -0500
Received: from syntevo.com ([85.214.39.145]:56319 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbZKWUbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 15:31:04 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 5AD1237C7B5
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.1.00.0911231916510.4897@intel-tinevez-2-302>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133533>

I agree, that getting it done correctly could be a long and hard (maybe
incompatible) way. Neglecting the problem or blaming platform specific
"anomalies" does not help to solve that serious real-world problem for the
end-user. IMHO, telling a user to not use non-US-ASCII characters in file
names to stay platform-independent seems not to be state-of-the-art and
would exclude a lot of users world-wide. Finally, everyone would expect Git
to be better than CVS, also at this point.

But what about getting it working "somehow" on OS X in a few minutes? What
should I do to be able to stage/commit/work with files containing umlauts in
their name on my English OS X (by specifying the file names) as it seems to
work magically on a German OS X? Is this topic already /documented/
somewhere (I couldn't find something)?

Thanks in advance,
Tom


Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 23 Nov 2009, Thomas Singer wrote:
> 
>> Basically, getting it "somehow" to work on OS X is just one minor step. 
>> IMHO Git should standardize on file names in the repository and do the 
>> platform-specific conversion independent of any locale setting, if 
>> needed.
> 
> That is contrary to the design of Git which honors content (byte-wise!) as 
> much as possible, and treats file names very much as content.
> 
> There were beginnings of supporting OSX' brain-damaged filename mangling, 
> but an obnoxious OSX fan worked very hard on trying to defend the OSX 
> design and to decry Git's respect for the raw bytes on this list, so hard 
> that even the nicest developers had no fun working on this issue anymore.
> 
> This little background may help you understand why there is no solution 
> implemented in Git yet.  And maybe quite a few developers are reluctant to 
> discuss the issue and possible solutions due to said sad story, too.
> 
> Ciao,
> Dscho
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
