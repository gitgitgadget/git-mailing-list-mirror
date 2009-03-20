From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 19 Mar 2009 20:09:13 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903191948050.4560@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
  <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>  <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>  <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>  <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com> 
 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de> <ab9fa62a0903191217t5d0e6d9cn4915a425ed8084ff@mail.gmail.com> <alpine.DEB.1.00.0903200034230.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0903191652500.16753@asgard.lang.hm>
 <alpine.DEB.1.00.0903200128020.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: saurabh gupta <saurabhgupta1403@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 04:10:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkV8G-0001JN-89
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 04:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbZCTDJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 23:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbZCTDJW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 23:09:22 -0400
Received: from mail.lang.hm ([64.81.33.126]:38025 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbZCTDJW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 23:09:22 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2K39Dg3028132;
	Thu, 19 Mar 2009 19:09:13 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0903200128020.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113883>

On Fri, 20 Mar 2009, Johannes Schindelin wrote:

> On Thu, 19 Mar 2009, david@lang.hm wrote:
>
>> I see good support for XML being a superset of what's needed to support
>> ODF or SVG, not a subset.
>
> No, not at all.  If we can get away with the default 3-way merge of Git,
> the generic XML merge driver be damned.

I would agree, but unless you don't do any auto-merging and punt 
everything to the 'conflict resolution tool' the existing merge drivers 
won't work for a structured file. And if you do want to do that, it's not 
a git project, it's a project for whatever tool you are working from to be 
the GUI plus (possibly) a smidge of scripting to call that tool from git.

> I'd rather have more file types supported that are useful for the average
> user, than a generic XML merge driver that is useful to only a handful of
> people.

we are both after the same thing, the most use to the average user.

you look at SVG, ODF word, ODF spreadsheet, OOXML, etc as completely 
seperate things that should have support developed seperatly.

I look at the same formats and am seeing a strong similarity between them. 
that being that they are all structured XML. so if you get the ability to 
handle XML in a configurable way (and define the appropriate 
configurations), you not only get the tools for these things, but many 
others as well.

I would be a little disappointed if the result of the summer only handled 
XML files (and more so if it only handled a handful of popular XML-based 
files). I think that there are a number of file types that aren't handled 
well by the current merge drivers. Saurabh has voiced the opinion that 
many of these have similar problems as the XML situations, so it may end 
up making sense to handle them in the same driver.

it would probably be a good thing to see suggestions from a bunch of 
people as to what file types they see being useful.

David Lang
