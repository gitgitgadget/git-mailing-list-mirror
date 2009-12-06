From: Gary Pickrell <gary@pickrell.com>
Subject: Re: Approach for collaborative branches
Date: Sun, 06 Dec 2009 10:56:01 -0800
Message-ID: <4B1BFE41.1040905@pickrell.com>
References: <4B1BE266.2000208@pickrell.com> <vpqhbs4f2gz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Dec 06 19:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHMHA-0007Ok-Ba
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 19:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933886AbZLFSz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 13:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933978AbZLFSz4
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 13:55:56 -0500
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:49899 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932935AbZLFSz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 13:55:56 -0500
Received: from OMTA20.emeryville.ca.mail.comcast.net ([76.96.30.87])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id DuZy1d0021smiN4A2uw3yj; Sun, 06 Dec 2009 18:56:03 +0000
Received: from [192.168.1.101] ([24.19.102.232])
	by OMTA20.emeryville.ca.mail.comcast.net with comcast
	id Duw21d00E50qwaY8guw3gE; Sun, 06 Dec 2009 18:56:03 +0000
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <vpqhbs4f2gz.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134688>


Thank you Matthieu,

It did exactly what I wanted and I wouldn't have figured it out by myself.

    -Gary


Matthieu Moy wrote:
> Gary Pickrell <gary@pickrell.com> writes:
>
>   
>> 1) Clone the repository on Ubuntu
>> 2) Made an Ubuntu branch
>> 3) Made my changes to the code.  Added files...ect
>> 4) Used git push origin Ubuntu to push the changes to the repository
>>
>> I'm unable to see my Ubuntu changes on my windows machine.  How should
>> I proceed?
>>     
>
> On the windows machine, you should do first
>
>   git fetch
>
> this will tell you about the new branch if you didn't fetch it
> already. If it's called Ubuntu remotely, it's probably called
> origin/Ubuntu on your local repository after doing a fetch. Therefore,
> you can now do
>
>   git merge origin/Ubuntu
>
>
> Now, you probably also want your local branch to be named the same way
> on both machines. One way to do that is to create a branch "foo" on
> the repository, then on both sides, fetch it and do
>
>   git checkout --track origin/foo
>
> this will create a local branch foo, and tell git that further "pull"
> should take their changes from origin/foo.
>
>   
