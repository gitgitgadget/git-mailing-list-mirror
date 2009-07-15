From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Correct way of making existing remote repository "bare"
Date: Wed, 15 Jul 2009 16:21:49 +0200
Message-ID: <4A5DE5FD.80304@dirk.my1.cc>
References: <h3khis$3tq$1@ger.gmane.org> <alpine.DEB.1.00.0907151607050.4410@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Graeme Geldenhuys <graemeg@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 15 16:24:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR5Oy-00030R-W0
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 16:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbZGOOXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 10:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755137AbZGOOXp
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 10:23:45 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:54237 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbZGOOXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 10:23:44 -0400
Received: from [84.176.68.208] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MR5Mk-0007YT-7J; Wed, 15 Jul 2009 16:21:50 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <alpine.DEB.1.00.0907151607050.4410@intel-tinevez-2-302>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123312>

Am 15.07.2009 16:08 schrieb Johannes Schindelin:
> Hi,
> 
> On Wed, 15 Jul 2009, Graeme Geldenhuys wrote:
> 
>> Steps I done:
>>
>> * ssh to remote server
>> * git clone --bare -l <path_to_repos> <new_dir>
>> * renamed old repository directory
>> * renamed new repository dir to what old repository used to be.
>>
>> Like I said, this did the tick, but is this the correct way of doing it?
> 
> That's the easiest.  However, I regularly avoid those steps by doing
> 
> 	mv bla/.git bla.git
> 	git --git-dir=bla.git config core.bare true
> 	rm -rf bla
> 
> This requires a bit more familiarity with the Git internals than your 
> solution, though (although it makes sure that the config is unchanged, as 
> well as possibly installed hooks).
> 

Dscho, you boiled down my solution to real git commands. Great. -- Dirk
