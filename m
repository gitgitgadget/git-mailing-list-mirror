From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Fri, 20 Mar 2009 13:50:24 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903201337060.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
  <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>  <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>  <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>  <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com> 
 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de> <ab9fa62a0903191217t5d0e6d9cn4915a425ed8084ff@mail.gmail.com> <alpine.DEB.1.00.0903200034230.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0903191652500.16753@asgard.lang.hm>
 <alpine.DEB.1.00.0903200128020.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0903191948050.4560@asgard.lang.hm> <alpine.DEB.1.00.0903201033310.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: saurabh gupta <saurabhgupta1403@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 21:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LklhF-000839-1F
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 21:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbZCTUue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 16:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZCTUue
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 16:50:34 -0400
Received: from mail.lang.hm ([64.81.33.126]:56014 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505AbZCTUud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 16:50:33 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2KKoOmI031870;
	Fri, 20 Mar 2009 12:50:24 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0903201033310.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114004>

On Fri, 20 Mar 2009, Johannes Schindelin wrote:

> On Thu, 19 Mar 2009, david@lang.hm wrote:
>
>> On Fri, 20 Mar 2009, Johannes Schindelin wrote:
>>
>>> I'd rather have more file types supported that are useful for the
>>> average user, than a generic XML merge driver that is useful to only a
>>> handful of people.
>>
>> we are both after the same thing,
>
> Apparently not...
>
>> the most use to the average user.
>>
>> you look at SVG, ODF word, ODF spreadsheet, OOXML, etc as completely
>> seperate things that should have support developed seperatly.
>
> No.  I look at SVG, ODF text, ODF spreadsheet, etc as things with
> completely different user interfaces.
>
> And likewise, the merge _helper_, the very thing the user will get to see,
> must have different user interfaces.

I absolutly agree with this. the UI and merge _helper_ tools for these 
different file formats are completely different.

> And I see much more potential for this project to fail in those different
> user interfaces than something as _trivial_ (in relation) as XML merging.

and the key thing that I am saying is that a properly done XML merge may 
eliminate the need to do _any_ development of a merge helper tool.

so rather than focusing on what the merge helper tool is going to be and 
what the UI for that is, I am focusing on the potential to eliminate any 
need to hae a specific helper tool by making it so that the marked up 
files can be manipulated with the existing tools for that file type.

David Lang
