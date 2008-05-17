From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Re* [PATCH] "not uptodate" changed to "has local changes"
Date: Sat, 17 May 2008 22:29:04 +0200
Message-ID: <bd6139dc0805171329i29b518a2l7b28e7e71756adac@mail.gmail.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
	 <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
	 <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
	 <alpine.DEB.1.00.0805161125320.30431@racer>
	 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
	 <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
	 <alpine.DEB.1.00.0805171102480.30431@racer>
	 <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
	 <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
	 <7v63tcda7e.fsf_-_@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Walter" <stevenrwalter@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 22:30:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxT2U-0005Nn-Dx
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 22:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758286AbYEQU3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755364AbYEQU3G
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 16:29:06 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:61960 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758047AbYEQU3E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 16:29:04 -0400
Received: by wf-out-1314.google.com with SMTP id 27so703945wfd.4
        for <git@vger.kernel.org>; Sat, 17 May 2008 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lNztukWxBzdOodd2tEiXicpkV9tyCGoI5VqqIX4/lyM=;
        b=wBMaS1V7DyjdrPkbAFdPSCx+ZNPrDVslii61AOuUDL13yFiT1rgdA/4AlWlAsbz4Kx9kRv3pSTBRKrt9sbECaiEuJP2QLbc4kVumjNVVuqx+jc/24epoUdCyJbCjxPEZg9Win1diVg9yCDaL7CPebBCmb2p3nKitub53wRMNI7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kuzwflTiXVTVjOnpAt5WJ69Kd8Q2lwvT9uH7fUq5pLOvzSNynQdLT69btHgJSNEemBDD+5STlVlfL30EGbYmPz4QepHDpDTH4oJKIcLaoFiJsJ/mdqzTZASMjPxxT9Cb8BEWJYw3qYbWxjOIJupZC8IchaY2JUOrHW82vc0zXJc=
Received: by 10.143.167.19 with SMTP id u19mr2135765wfo.247.1211056144290;
        Sat, 17 May 2008 13:29:04 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Sat, 17 May 2008 13:29:04 -0700 (PDT)
In-Reply-To: <7v63tcda7e.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82361>

On Sat, May 17, 2008 at 9:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Don't feed the troll by responding to a cheap shot.

Yes, a cheap shot, but I think one trying to make a point.

> The plumbing output is sacred as it is an API.  We _could_ change it if it
> is broken in such a way that it cannot convey necessary information fully,
> but we just do not _reword_ for the sake of rewording.  If somebody does
> not like it, s/he is complaining too late.  S/he should have been here in
> early May 2005 and make the language used by the API closer to what humans
> read.  S/he wasn't here.  Too bad, and it is too late.

Mhh.. I guess I didn't realize how strongly git still is "many
commands that are good at what they do" that together form a coherent
entity.

> If you do not see something wrong with this output, your brain has already
> been rotten with use of git for too long a time.  Nobody asked us to
> "merge" but why are we talking about "Cannot merge"?

Very good point, perhaps we should consider double-checking them all
and improving them for one of the next 1.x releases.

> Try a different approach along this patch instead.
>
>    $ git-checkout pu
>    error: You have local changes to 'Makefile'; cannot switch branches.
>
> There are other places that ask unpack_trees() to n-way merge, detect
> issues _and_ let it issue error message on its own, which people who
> complained in this thread can identify and improve, but I did this as a
> demonstration and replaced only one message.

The patch looks like a step in the right direction, but if there is
interest in improving the error messaging system why not do it right
and make it generic. Instead of each file reinventing the wheel create
a more generic system that uses a configuration file (I think this was
suggested earlier). If we choose something like that, perhaps it would
be nice to add a 'scripting' mode, which provides with a CLI-like
messages instead of the usual human-readable ones (and thus less easy
to parse).

<snip patch>

-- 
Cheers,

Sverre Rabbelier
