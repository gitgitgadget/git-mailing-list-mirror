From: Sam Vilain <sam@vilain.net>
Subject: Re: From P4 to Git
Date: Tue, 04 Aug 2009 12:29:48 +1200
Message-ID: <4A7780FC.6090606@vilain.net>
References: <85ljm84lat.fsf@oqube.com> <m3fxcg3473.fsf@localhost.localdomain> <85r5vxbd8e.fsf@oqube.com> <200907311122.43918.jnareb@gmail.com> <81b0412b0907310414x7157fecey947da960ff8be1cc@mail.gmail.com> <4A76967B.7080502@vilain.net> <81b0412b0908030147i34a7440dg982c7a6e7dc51bca@mail.gmail.com> <1249299010.7164.8.camel@maia.lan> <81b0412b0908030650oc39f4a3s7c059e300b65addb@mail.gmail.com> <1249331540.12801.10.camel@maia.lan> <20090803215137.GC3759@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Arnaud Bailly <abailly@oqube.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 02:30:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY7vG-0008HE-Mj
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 02:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbZHDAaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 20:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309AbZHDAaZ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 20:30:25 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:41426 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754095AbZHDAaY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 20:30:24 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 5C03521C3EC; Tue,  4 Aug 2009 12:30:09 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 8DE3221C3A9;
	Tue,  4 Aug 2009 12:30:04 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20090803215137.GC3759@blimp.localdomain>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124738>

Alex Riesen wrote:
>> The "live" parts are never touched - only the write-only files that
>> perforce writes; and the rcs files are read using rcs.
>>     
>
> I always felt Perforce had a touch of pure evil...
>   

Perforce is not really that evil imho. It uses rcs for what it's good at
- storing file revisions. All the metadata it kept in table stores which
could be checkpointed and journalled like a regular database. Simple,
elegant, fast, robust. Overall I'd say it was a well engineered piece of
software which delivered great benefits to its users, far less evil than
CVS or Subversion. Which is funny because Subversion rips off many
concepts from Perforce including the 'branching is just copying' idea.
But they left behind the integration system. Even now svn's merging
support can't even handle merging correctly in the face of branched
branches, or so I hear. That's evil - pretending to have a feature
solved when they haven't even met the standard set by bzr, hg, mtn, git,
etc.

Sam
