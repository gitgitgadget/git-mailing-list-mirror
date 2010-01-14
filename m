From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [RFC] Git Wiki Move
Date: Thu, 14 Jan 2010 10:52:35 -0800
Message-ID: <4B4F67F3.8000202@eaglescrag.net>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net> <alpine.DEB.1.00.1001141136450.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 19:52:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVUoM-0003YM-S1
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 19:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022Ab0ANSwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 13:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143Ab0ANSwo
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 13:52:44 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51752 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab0ANSwn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 13:52:43 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0EIqZZ3007432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 14 Jan 2010 10:52:35 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <alpine.DEB.1.00.1001141136450.4985@pacific.mpi-cbg.de>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 14 Jan 2010 10:52:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137009>

On 01/14/2010 02:43 AM, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 14 Jan 2010, J.H. wrote:
> 
>> On 01/13/2010 05:24 PM, Petr Baudis wrote:
>>
>>> On Thu, Jan 14, 2010 at 12:29:08AM +0100, Petr Baudis wrote:
>>>> I would like to notify you that unfortunately, Czech UPC terminated 
>>>> the sponsorship of the hardware and connectivity hosting the Git Wiki 
>>>> and repo.or.cz (after generously donating it for several years).
>>>
>>>   ...please scratch the Git Wiki part, you would be supporting just 
>>> repo.or.cz - we are considering to move the Git wiki to 
>>> wiki.kernel.org MediaWiki installation and I would like to ask if 
>>> anyone disagrees with this. The motivation is that:
>>>
>>> 	(i) wiki.kernel.org is actually maintained! Thus, there should be 
>>> 	less spam or upgrade issues and better support in case of problems.
>>>
>>> 	(ii) Also, I personally think MediaWiki is so much nicer than 
>>> 	ikiwiki...
> 
> ... not to mention than MoinMoin...
> 
>>> 	(iii) ...and OBTW, no CamelCase!
>>>
>>>   Of course, there will be compatibility redirects.
>>
>> Just a heads up I've got an initial import of the current wiki up at
>> http://git.wiki.kernel.org - some of it was quite a clean conversion,
>> some of it not so much.
> 
> Did you use a script?  And did you leech the sources, or did you get a 
> dump?

Used a conversion script form a dump from Petr, needless to say it wa
sthe one generally recommended by mediawiki and even their commentary on
it was "It's the least bad" basically

> I note that "<<<!-- ! TOC here -->(2)>>" could be converted to "__TOC__", 
> I believe.

I'll have to go in behind and track those down, should be easy enough to
find / fix.

>> Please note that user accounts were not carried over but edit histories 
>> were.
> 
> IIUC there are no email addresses stored in the Git Wiki, so I think that 
> we'll have to live with that.  You might get the occasional complaint of a 
> stolen account.

I'm fine with dealing with those on an individual basis, and it would be
good for people to re-create their accounts as soon as possible.

>> I'll work on cleaning up the rest of if tomorrow, assuming that there 
>> isn't any objections to Petr's e-mail above.
> 
> I like it.  Especially since there is a fun project waiting for me to 
> get some time to do it, to convert the full history of a MediaWiki 
> instance into a Git repository.  Maybe via the git-remote* mechanism, once 
> Sverre and Ilari manage to flush out the last remnants of clumsy design.

Now you've got a solid wiki to work with that's pertinent ;-)

- John 'Warthog9' Hawley
