From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree Ready #2
Date: Wed, 15 Feb 2012 22:07:16 -0600
Message-ID: <87ty2ro1zf.fsf@smith.obbligato.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
	<8739acra5j.fsf@smith.obbligato.org>
	<20120215050855.GB29902@sigill.intra.peff.net>
	<87sjicpsr1.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 16 05:10:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxsfl-0005qD-Uz
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 05:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556Ab2BPEJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 23:09:45 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48508 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751241Ab2BPEJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 23:09:44 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1RxsfA-0001qJ-6K; Wed, 15 Feb 2012 22:09:48 -0600
In-Reply-To: <87sjicpsr1.fsf@smith.obbligato.org> (David A. Greene's message
	of "Tue, 14 Feb 2012 23:31:30 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  greened@obbligato.org (David A. Greene) writes: >> But more
    important than the physical layout is the maintenance plan >> going forward.
    Is Avery going to keep maintaining git-subtree, and we >> will just occasionally
    pull? Are you maintaining it? Where will patches >> go? To a github repo?
    To git@vger? > > I am still waiting to hear from Avery on that. I will ping
    him again. > My intention is to certainly participate in maintenance. I use
    > git-subtree daily so it's in my interest to keep it working. [...] 
 Content a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190873>

greened@obbligato.org (David A. Greene) writes:

>> But more important than the physical layout is the maintenance plan
>> going forward.  Is Avery going to keep maintaining git-subtree, and we
>> will just occasionally pull? Are you maintaining it? Where will patches
>> go? To a github repo? To git@vger?
>
> I am still waiting to hear from Avery on that.  I will ping him again.
> My intention is to certainly participate in maintenance.  I use
> git-subtree daily so it's in my interest to keep it working.

I've attached Avery's response below.  The short summary is that he
thinks maintaining it in the vger git repository is the way to go and
that he's fine moving patches to/from GitHub as necessary.

So again, I will certainly be part of the maintenance team.  There are a
few other people currently helping out with maintenance and I will help
Avery to get the word out about the switch as he requires.

                            -Dave

--8<-----------------------------------------------------------------------

Thanks for putting work into this.  You can feel free to cc: me on any
git-list discussions if you want.

I haven't done any significant amount of git-subtree maintenance lately,
but even if I did, since it's only one file it should be easy to put
move patches between github and git whenever we want.  I would suggest
that just maintaining it as part of git is the best way to go, since
having diverging versions doesn't really help anyone.

I'm sure the potential benefit of putting git-subtree in the contrib/
directory is that we could then use git-subtree to maintain the
git-subtree git subtree, which is a fun wordplay, but perhaps
ironically, as a single rarely-changing file, git-subtree is probably
not the right tool for these purposes :)

Have fun,

Avery
