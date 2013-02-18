From: greened@obbligato.org
Subject: Re: [PATCH 1/4] contrib/subtree: Store subtree sources in .gitsubtree and use for push/pull
Date: Mon, 18 Feb 2013 14:20:36 -0600
Message-ID: <87bobh4bmz.fsf@waller.obbligato.org>
References: <CALeLG_kuXdF_F4ScRLPLm5h5cV_9p=EZYrWdjoWBrO99WFyi2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:21:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7XDo-0003pI-LB
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab3BRUVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:21:32 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:45232 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753991Ab3BRUVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:21:31 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U7XFC-0008QF-Sw; Mon, 18 Feb 2013 14:23:27 -0600
In-Reply-To: <CALeLG_kuXdF_F4ScRLPLm5h5cV_9p=EZYrWdjoWBrO99WFyi2Q@mail.gmail.com>
	(Paul Campbell's message of "Tue, 12 Feb 2013 23:21:34 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Paul Campbell <pcampbell@kemitix.net> writes: > Subsequent
    git subtree push/pull operations now default to the values > stored in .gitsubtree,
    unless overridden from the command line. > > The .gitsubtree file should
   be tracked as part of the repo as it > describes where parts of the tree came
    from and can be used to update > to/from that source. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216514>

Paul Campbell <pcampbell@kemitix.net> writes:

> Subsequent git subtree push/pull operations now default to the values
> stored in .gitsubtree, unless overridden from the command line.
>
> The .gitsubtree file should be tracked as part of the repo as it
> describes where parts of the tree came from and can be used to update
> to/from that source.

I agree with the basic idea but have some questions about the
implementation.

Is there precedent of git commands storing information in hidden files
and requiring those files to be added to the repository and tracked?  It
seems like a bit of a kludge.

Could we use notes or something for this?

I'm not necessarily against the patches, I just want to make sure we
don't go down a road that won't be acceptable later on.

                           -David
