From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 19:55:02 -0400
Message-ID: <4EAF3556.3000001@garzik.org>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike> <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com> <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com> <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com> <4EAF1F40.3030907@zytor.com> <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com> <4EAF2245.90308@zytor.com> <7vzkggok6u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Nov 01 00:55:21 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RL1hJ-0004ui-24
	for glk-linux-kernel-3@lo.gmane.org; Tue, 01 Nov 2011 00:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab1JaXzL (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 31 Oct 2011 19:55:11 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37464 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab1JaXzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2011 19:55:09 -0400
Received: by vcge1 with SMTP id e1so5300916vcg.19
        for <multiple recipients>; Mon, 31 Oct 2011 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TmbqT+qXQNVcYDwpRjNs4iE4CcdGYSGrJzBtNYJwFzU=;
        b=ub7ZYlGJRU7KNqKXY0P+haN3UMRLaU4cZQ3ftbvLlKTLOB7vd8ickkjlG/7Zs3Udy2
         unov6eGNHiyzHujDAsTpgyOtaMAA6jwSgM4QG5uZ0Xpcc8LRXkYAFen6fgOiFXvlhwnA
         yKRRXg8OB8lW/IlqJOGWpQynWG37AbAx8njuE=
Received: by 10.52.32.73 with SMTP id g9mr5856469vdi.125.1320105308328;
        Mon, 31 Oct 2011 16:55:08 -0700 (PDT)
Received: from bd.yyz.us (99-43-178-25.lightspeed.rlghnc.sbcglobal.net. [99.43.178.25])
        by mx.google.com with ESMTPS id gw4sm12131006vdb.10.2011.10.31.16.55.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 16:55:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7vzkggok6u.fsf@alter.siamese.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184546>

On 10/31/2011 06:44 PM, Junio C Hamano wrote:
> "H. Peter Anvin"<hpa@zytor.com>  writes:
>
>> On 10/31/2011 03:30 PM, Linus Torvalds wrote:
>>>
>>> But if you do the normal "git pull git://git.kernel.org/name/of/repo"
>>> - which is how things happen as a result of a pull request - you won't
>>> get tags at all - you have to ask for them by name or use "--tags" to
>>> get them all.
>>>
>>
>> Didn't realize that... I guess I'm too used to named remotes.
>>
>> If so, just using a tag should be fine, no?
>
> So nobody is worried about this (quoting from my earlier message)?
>
>     On the other hand, the consumers of "Linus kernel" may want to say that
>     they trust your tree and your tags because they can verify them with your
>     GPG signature, but also they can independently verify the lieutenants'
>     trees you pulled from are genuine.
>
> A signed emphemeral tag is usable as means to verify authenticity in a
> hop-by-hop fashion, but that does not leave a permanent trail that can be
> used for auditing.

The main worry is Linus ($human_who_pulls) gets 
cryptographically-verified data at the time he pulls.  Once Linus 
republishes his tree (git push), there will be few, if any, wanting to 
verify Jeff Garzik's signature.

So no, I don't see that as a _driving_ need in the kernel's case.

And IMO the kernel will be a mix of signed and unsigned content for a 
while, possibly forever.


And Linus wrote:
> [ Example gpg-signed small block that the attached patch adds to the
> pull request: ]
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Commit be3fa9125e708348c7baf04ebe9507a72a9d1800
> from git.kernel.org/pub/git
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.18 (GNU/Linux)
>
> iQEcBAEBAgAGBQJOrsILAAoJEHm+PkMAQRiGxZcH/31e0RrBitXUPKxHJajD58yh
> SIEe/7i6E2RUSFva3KybEuFslcR8p8DYzDQTPLejStvnkO8v0lXu9s9R53tvjLMF
> aaQXLOgrOC2RqvzP4F27O972h32YpLBkwIdWQGAhYcUOdKYDZ9RfgEgtdJwSYuL+
> oJ7TjLrtkcILaFmr9nYZC+0Fh7z+84R8kR53v0iBHJQOFfssuMjUWCoj9aEY12t+
> pywXuVk2FsuYvhniCAcyU6Y1K9aXaf6w5iOY2hx/ysXtUBnv92F7lcathxQkvgjO
> fA7/TXEcummOv5KQFc9vckd5Z1gN2ync5jhfnmlT2uiobE6mNdCbOVlCOpsKQkU=
> =l5PG
> -----END PGP SIGNATURE-----


This is my preference for kernel pull requests at the moment.  That has 
one advantage over Junio's "git pull --require-signature" and signed 
commits, notably, the URL is signed.

But in general signed commits would be nice, too.  pull-generated merge 
requests would need to be signed, potentially introducing an additional 
interactive step (GPG passphrase request) into an automated process.

	Jeff
