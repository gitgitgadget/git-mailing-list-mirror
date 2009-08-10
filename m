From: Thomas Koch <thomas@koch.ro>
Subject: Re: [Feature Request] git export
Date: Mon, 10 Aug 2009 18:41:00 +0200
Message-ID: <200908101841.00522.thomas@koch.ro>
References: <200908101822.59940.thomas@koch.ro> <c115fd3c0908100927v4d9e4a87we4502e91d3789138@mail.gmail.com>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 18:41:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXvw-0005KJ-5c
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625AbZHJQlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755584AbZHJQlF
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:41:05 -0400
Received: from koch.ro ([93.90.184.107]:60729 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754990AbZHJQlE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 12:41:04 -0400
Received: from 84-72-56-244.dclient.hispeed.ch ([84.72.56.244] helo=jona.localnet)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1MaXvg-0006Xa-QV; Mon, 10 Aug 2009 18:41:00 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.29-1-amd64; KDE/4.3.0; x86_64; ; )
In-Reply-To: <c115fd3c0908100927v4d9e4a87we4502e91d3789138@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125484>

Hi Tim,

thanks for your explanation. Still I don't get how to do it with git checkout-
index. The man page says "Just read the desired tree into the index", but I 
don't know what is meant by this.

> Hey Thomas,
>
> On Mon, Aug 10, 2009 at 12:22 PM, Thomas Koch<thomas@koch.ro> wrote:
> > could you please provide a simple solution to save a tree object into an
> > arbitrary location?
>
> This has been requested a few times and I have no idea what the
> development status of it is.  Most people seem to recommend just
> making an alias around git checkout-index.
>
> > I found some hints, that it would be possible by missusing either git
> > checkout-index or git-archive, but I think that it shouldn't require that
> > much GIT FU to do such a simple thing.
>
> It's not really a misuse, as the [man page
> itself](http://www.kernel.org/pub/software/scm/git/docs/git-checkout-index.
>html) recommends using checkout-index as a way to export an entire tree.
> Until someone decides that it's worth making the porcelain command (like
> you perhaps) then I think you can just stick with checkout-index knowing
> you're not abusing anything.
Thomas Koch, http://www.koch.ro
