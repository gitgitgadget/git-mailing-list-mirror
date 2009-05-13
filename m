From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to create a new commit with the content of some commit?
Date: Wed, 13 May 2009 14:36:15 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh0lmmv.5j5.sitaramc@sitaramc.homelinux.net>
References: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com>
 <46dff0320905120847wae71bday4d4a890b00abc222@mail.gmail.com>
 <83048193-FBD1-4D14-9CC9-B95BD08C67F7@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 16:36:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4FZn-0004yQ-T0
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 16:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757626AbZEMOg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 10:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757002AbZEMOg1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 10:36:27 -0400
Received: from main.gmane.org ([80.91.229.2]:45793 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755816AbZEMOg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 10:36:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M4FZL-00038x-EI
	for git@vger.kernel.org; Wed, 13 May 2009 14:36:27 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 May 2009 14:36:27 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 May 2009 14:36:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119053>

On 2009-05-12, Tomas Carnecky <tom@dbservice.com> wrote:
>
> On May 12, 2009, at 5:47 PM, Ping Yin wrote:
>
>> On Tue, May 12, 2009 at 10:35 PM, Ping Yin <pkufranky@gmail.com>  
>> wrote:
>>> a----b
>>>  \----c
>>>
>>> Given the graph above, I want to create a commit b1 on top of c,  
>>> where
>>> b1 and b have the same content. i.e.
>>>
>>> a----b
>>>  \----c----b1    ( content(b) == content(b1) )
>>
>> More precisely, b1 and b point to the same tree object
>
> git checkout c
> git cherry-pick b

I do not think this does what was wanted.  Applying the
change from a->b onto c may not give you "b" unless a==c.
