From: Barry Roberts <blr@robertsr.us>
Subject: Re: Noob question on using branches
Date: Tue, 06 May 2008 10:15:35 -0600
Message-ID: <48208427.5080800@robertsr.us>
References: <48207DA4.80502@robertsr.us> <vpqiqxrctio.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue May 06 18:16:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtPqB-0006lv-Ax
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 18:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbYEFQPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 12:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbYEFQPl
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 12:15:41 -0400
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:46015 "EHLO
	QMTA08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922AbYEFQPl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 12:15:41 -0400
Received: from OMTA12.emeryville.ca.mail.comcast.net ([76.96.30.44])
	by QMTA08.emeryville.ca.mail.comcast.net with comcast
	id NG3V1Z03E0x6nqcA800K00; Tue, 06 May 2008 16:13:56 +0000
Received: from dalmuti.xactvalue.com ([76.27.63.88])
	by OMTA12.emeryville.ca.mail.comcast.net with comcast
	id NGFc1Z0011uEJYk8Y00000; Tue, 06 May 2008 16:15:38 +0000
X-Authority-Analysis: v=1.0 c=1 a=ffpF9_s7givzdkazqcMA:9
 a=Zh9Vsqyn9v4a3g9KTYTyb9vn-zoA:4 a=vNGxQsTWjH8A:10
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <vpqiqxrctio.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81365>

Matthieu Moy wrote:
> Barry Roberts <blr@robertsr.us> writes:
>
>   
>> I have a branch in my git repository that is a "released" branch.  It
>> only gets defect fixes as they are needed to patch our production
>> servers.
>>
>> I want to get all those defect fixes back into the master, but I don't
>> want changes from the master getting into the production branch, so I
>> don't think I want to do:
>> git checkout master
>> git merge production
>>     
>
> Why wouldn't you?
>
> The "git merge production" will take all the changes in production and
> put them in the current branch. You'll get a new revision that
> contains both the stuff in master and the one in production. But
> what's important is that the reference "master" is updated to that new
> revision, but "production" stays where it is.
>   
So it does.  That does appear to be exactly what I need.
> Just try it, then run "gitk --all" to see if the result is what you
> wanted. If not, "git reset --hard HEAD^" will move back "master" to
> where it used to be (read about "git reset" before you run it).
>
>   
