From: greened@obbligato.org
Subject: Re: [PATCH 2/8] Add --unannotate
Date: Tue, 22 Jan 2013 02:44:12 -0600
Message-ID: <878v7lfvz7.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-3-git-send-email-greened@obbligato.org>
	<7v623ga8vs.fsf@alter.siamese.dyndns.org>
	<87sj6kfsbz.fsf@waller.obbligato.org>
	<CABVa4NhK3FR-NsTq6Vt6yrgneQmMxF5ANmN6pF8k3fHeOLd0JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:45:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxZTt-0003qG-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 09:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab3AVIoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 03:44:55 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:37836 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754329Ab3AVIoy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 03:44:54 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TxZTS-0002eq-5K; Tue, 22 Jan 2013 02:44:54 -0600
In-Reply-To: <CABVa4NhK3FR-NsTq6Vt6yrgneQmMxF5ANmN6pF8k3fHeOLd0JA@mail.gmail.com>
	(James Nylen's message of "Thu, 17 Jan 2013 16:07:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  James Nylen <jnylen@gmail.com> writes: > I just now saw these
    emails. I'm having a hard time thinking of any > good use case other than:
    > > - add "fancylib" as a subtree of "myprog" > - commit to myprog repo:
   "fancylib: don't crash as much" > - split these commits back out to fancylib's
    main repo, and remove > the "fancylib: " prefix [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214223>

James Nylen <jnylen@gmail.com> writes:

> I just now saw these emails.  I'm having a hard time thinking of any
> good use case other than:
>
>  - add "fancylib" as a subtree of "myprog"
>  - commit to myprog repo: "fancylib: don't crash as much"
>  - split these commits back out to fancylib's main repo, and remove
> the "fancylib: " prefix

That does seem to me to be the common case, at least.

> You could potentially have something like "Don't crash as much
> (fancylib)" but that's awkward.  What might you want to do with a
> pattern-based rewrite that doesn't involve removing a prefix when
> splitting commits?

I'm not really sure.  I've never used --annotate in my own work.

> In fact, I don't see the use of the original --annotate option at all,
> since it causes more detailed commit messages in the smaller of the
> two repositories.

I'll have to look back through Avery's logs and see if I can puzzle out
why this was added.  If it's not useful, perhaps we can remove it before
migrating to mainline.

Junio, is there a policy for backward-compatability in contrib?  I hope
that since that directory is for stuff not yet in mainline, there is
some room to massage the user interface.

                            -David
