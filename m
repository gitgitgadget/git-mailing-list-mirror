From: Timothy Harper <timcharper@gmail.com>
Subject: Re: mac osx
Date: Wed, 21 Sep 2011 12:09:39 -0600
Message-ID: <2BD212E4-8862-47C1-9D1E-7771B61933B9@gmail.com>
References: <loom.20110921T002437-246@post.gmane.org> <CAFcyEtiexmE0WMif-eGHe5xMoYv7-8mdXos1qbQBH3g04z0sAg@mail.gmail.com> <CAGdFq_h0VqbZ5W3QVwoQWT63znhpePDFCRE+-n1TqPNztREwkA@mail.gmail.com> <F4C226A7-768D-4913-A6C1-12411FBA212C@gmail.com> <CAP2yMaJz3-iX11vhbrTVasFD1zdwsdiDFKU7z7=an8pBoORk8w@mail.gmail.com> <3509B3CD-8E7E-4097-B7F1-F092E5CF08F5@gmail.com> <CAP2yMaLCu6epGkFOEOsfPgmUodCiBYRePLtewEmny1Z3W5D=QA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Kyle Neath <kneath@gmail.com>,
	tom smitts <tomsmitts@ymail.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 20:09:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6REu-0003W0-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 20:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab1IUSJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 14:09:40 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:39023 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab1IUSJk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 14:09:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp57.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 993E3F85FC;
	Wed, 21 Sep 2011 14:09:39 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp57.relay.iad1a.emailsrvr.com (Authenticated sender: tim-AT-leadtune.com) with ESMTPSA id 2B644F8330;
	Wed, 21 Sep 2011 14:09:38 -0400 (EDT)
In-Reply-To: <CAP2yMaLCu6epGkFOEOsfPgmUodCiBYRePLtewEmny1Z3W5D=QA@mail.gmail.com>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181855>


On Sep 21, 2011, at 12:01, Scott Chacon wrote:

> Hey,
> 
> On Wed, Sep 21, 2011 at 10:49 AM, Timothy Harper <timcharper@gmail.com> wrote:
>> Ever since installing OS X Lion and Xcode 4.1 it seems I have lost the ability to build targeting Leopard (see /Developer/SDKs/), and haven't looked in to a work around. I have only built packages targeting the Snow Leopard.
>> 
>> I see two possible resolutions:
>> 
>> A) Tag builds as 32-bit and 64-bit. At git-scm.com (and github), link to the list that only shows 32-bit builds. For 99.9% (pulled-out-of-butt) of people using the installer, this will be just fine. For people who care about 64 bit, if they are motivated they can build own or find it.
>> 
>> B) Switch to universal architecture and cause everyone to suffer an addition 30% or so wait while downloading the installer.
>> 
>> What do y'all vote for?
> 
> I vote for Universal builds.  I don't think anyone downloading a DMG
> will care between 6M and 9M - it's still smaller than most YouTube
> videos.  Then I can just have people choose their OS version and
> auto-download whatever the latest build is.

Ok, consider it done :). Going forward I will release Universal 32-bit / 64-bit.
> 
> Also, fwiw, though this is the first you may have heard about it, I've
> personally had probably 5 or 6 people approach me at conferences and
> trainings and complain about it - or email me as the maintainer of the
> git-scm page to complain.  I probably should have brought it up
> sooner, but I've just been so happy you've been doing the builds at
> all, I didn't want to complain :)
> 
> Scott

Tim