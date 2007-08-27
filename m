From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git-svn tags and branches
Date: Mon, 27 Aug 2007 19:08:47 +0200
Message-ID: <fav0e9$bbh$1@sea.gmane.org>
References: <faulrb$483$1@sea.gmane.org> <867inhqaj9.fsf@lola.quinscape.zz> <20070827153138.GA12936@glandium.org> <A0329662-9C87-44C2-84E4-4F60DCC1E95F@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 19:10:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPi5M-0005Js-2e
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 19:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507AbXH0RJD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 13:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbXH0RJD
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 13:09:03 -0400
Received: from main.gmane.org ([80.91.229.2]:44026 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbXH0RJB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 13:09:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPi54-0007Cs-PA
	for git@vger.kernel.org; Mon, 27 Aug 2007 19:08:50 +0200
Received: from host-62-10-78-152.cust-adsl.tiscali.it ([62.10.78.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 19:08:50 +0200
Received: from giuseppe.bilotta by host-62-10-78-152.cust-adsl.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 19:08:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-62-10-78-152.cust-adsl.tiscali.it
User-Agent: KNode/0.10.5
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56862>

On Monday 27 August 2007 17:36, Benoit SIGOURE wrote:

> On Aug 27, 2007, at 5:31 PM, Mike Hommey wrote:
> 
>> On Mon, Aug 27, 2007 at 05:09:30PM +0200, David Kastrup  
>> <dak@gnu.org> wrote:
>>> I actually don't see how one can safely make them tags at all (rather
>>> than branches) since Subversion does not enforce the members of a
>>> "tags" subdirectory to remain unchanged after the initial copy.
>>> Basically, tags are not different from branches in Subversion from
>>> what you can do with them.
>>
>> Well, git-svn could make tags when the tag/branch is created in  
>> subversion,
>> and then create a branch on the first commit on top of that tag/ 
>> branch in
>> svn.
> 
> Or update the tag ref in Git so that it points to the new "HEAD" of  
> the SVN tag.But all in all, it's more consistent to have it look  
> like a branch from the Git point of view, because that's really what  
> it is after all.

Yes and no. By making it just a branch you lose the tag POV on that
particular commit, and this is, in a way, a loss of information: yes, it
can behave like a branch but most projects use it as a tag.

I think the best approach is to have an annotated tag 'tagname'
corresponding to the tags/tagname copy on the svn side in addition
to the 'tags/tagname' branch that is currently used to track its head.

-- 
Giuseppe "Oblomov" Bilotta
