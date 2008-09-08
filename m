From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Alternates and push
Date: Sun, 7 Sep 2008 20:41:37 -0400
Message-ID: <20080908004137.GB8161@mit.edu>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com> <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org> <20080907234118.GA8161@mit.edu> <7vd4jfjyiq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 02:42:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcUq9-0001O6-5d
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 02:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbYIHAlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 20:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbYIHAlm
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 20:41:42 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48787 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750823AbYIHAll (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 20:41:41 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m880fdMK012274;
	Sun, 7 Sep 2008 20:41:39 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m880fblS002951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 7 Sep 2008 20:41:38 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KcUoz-0003Vk-Mr; Sun, 07 Sep 2008 20:41:37 -0400
Content-Disposition: inline
In-Reply-To: <7vd4jfjyiq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95202>

On Sun, Sep 07, 2008 at 05:02:05PM -0700, Junio C Hamano wrote:
> 
> I think you just reiterated what I said in "we could instead", and I think
> we are in agreement.
> 

Sorry, I misunderstood what you were saying.  I thought you were
proposing that if $D/refs didn't exist, then if alternates pointed at
$D/objects, git would reject using it.  But that makes no sense, which
is why I didn't understand why you proposed it.  (Turns out I
misunderstood you.  :-)

> The arguments to make are "Junio is worrying too much; depending on the
> other repository's ref is no worse than depending on the objects the other
> repository uses, and here is a proof that it is not just 'not a big deal'
> but 'no problem at all'", "I've polled the userbase and there is no
> existing configuration that will be broken by this change", and "I have
> this configuration that will be broken by above change, don't do it".

So the only configuration I can think of that would be broken by this
is where $D/refs exists, but is insane.  (i.e., such that git fsck for
$D would result in errors).  That seems pretty unlikely...

   	 	   	     	  	       - Ted
