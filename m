From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 12:59:55 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>  <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>  <7veix33f5e.fsf@gitster.siamese.dyndns.org>  <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>
  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com> 
 <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm> <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 21:01:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhr64-0007ow-Ad
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 21:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbZCLUAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 16:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbZCLUAE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 16:00:04 -0400
Received: from mail.lang.hm ([64.81.33.126]:35382 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbZCLUAC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 16:00:02 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2CJxtIJ017440;
	Thu, 12 Mar 2009 11:59:55 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113118>

On Fri, 13 Mar 2009, saurabh gupta wrote:

> Very well described, David. I agree with you and providing these merge
> options to the user, merge drivers can do the work and mark the
> conflicts according to the option. The work to do is to modify the
> merge driver. I think in this way, even people who have only a
> terminal can also gain from it. They can choose the apt option to see
> the conflict markers in their way. So, the aim is to make merge driver
> configurable and create the merged/conflicted file according to the
> options.

for the GSOC I suspect that the right thing to do is the define one or 
more merge drivers to create, and list what applications are going to be 
used for testing these merges.

you and the mentor can decide what is a reasonable amount of work.

it may be just doing an XML merge driver is a summer's worth of work, or 
it may be that it's not really enough and you should try to do another one 
or two.

it also may be that there is a lot of overlap between different merge 
drivers, and once you have the XML driver the others become fairly trivial 
to do. (I'm thinking the config file examples I posted earlier in the 
thread)

David Lang
