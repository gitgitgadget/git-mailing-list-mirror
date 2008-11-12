From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 12 Nov 2008 10:39:21 -0500
Message-ID: <32541b130811120739t95455d8n9b8056a8033491c3@mail.gmail.com>
References: <20081029164253.GA3172@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20081029171122.GA12167@sigill.intra.peff.net>
	 <20081102123519.GA21251@atjola.homenet>
	 <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
	 <20081103071420.GD10772@coredump.intra.peff.net>
	 <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
	 <20081112083353.GB3817@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0811121205100.30769@pacific.mpi-cbg.de>
	 <20081112110629.GA20473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
	"David Symonds" <dsymonds@gmail.com>, git@vger.kernel.org,
	"Stephan Beyer" <s-beyer@gmx.net>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 16:40:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Hpf-0006hu-27
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 16:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbYKLPjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 10:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYKLPjX
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 10:39:23 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:56839 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbYKLPjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 10:39:22 -0500
Received: by yw-out-2324.google.com with SMTP id 9so205812ywe.1
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 07:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vXJanToSqwB9LktIWfcxV/FI8t1NUhGaznLlf6+iGfQ=;
        b=Qb2TDrphh1hUIekKm3Pf7vGOaJuqukDT5FQfNgg7ntcV1ydexUFfubF4K7IX6ZJ0B6
         j4EQbq2cizSDbzNlSmeA8kNc/iBeCCTmEoqB68uzezdYegNthaYVo1ZxP0/4d654zLEQ
         urp9SbF+w8ZJ9HlkI0OeGTb8nMAMjuIhEYOFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=G1c+2m0SqPs9/w6y6K6kChUlT/hdVqDumGZUxjHjkr+poSNtLgqcMBoUfGsu77/8rI
         e90L1aOdRzSvvWzz/NKtsfCr7J4ivG5kaj96SD9jEWShv4RqhKI6+SM0JJ1i9JDnqSGh
         14kN+rvyTnObfvVzjMnHT2iwp8YLg00bZjVf0=
Received: by 10.150.12.10 with SMTP id 10mr283787ybl.202.1226504361351;
        Wed, 12 Nov 2008 07:39:21 -0800 (PST)
Received: by 10.150.98.19 with HTTP; Wed, 12 Nov 2008 07:39:21 -0800 (PST)
In-Reply-To: <20081112110629.GA20473@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100758>

On Wed, Nov 12, 2008 at 6:06 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 12, 2008 at 12:10:57PM +0100, Johannes Schindelin wrote:
>
>> Just in case anybody thought about creating tree objects on the fly and
>> use their SHA-1s: that won't fly, as you can have unmerged entries in the
>> index.  So STAGED.. is a _fundamentally_ different thing from HEAD^..
>
> I thought about that at first, too, but the working tree is even more
> painful. You would have to hash every changed file on the filesystem to
> create the tree object.

Is that so bad?  You have to read all those files anyway in order to do a diff.

Avery
