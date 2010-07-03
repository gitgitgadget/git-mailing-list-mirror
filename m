From: David Bainbridge <david.bainbridge@gmail.com>
Subject: Re: SVN migration
Date: Sat, 3 Jul 2010 13:37:57 +0200
Message-ID: <AANLkTimtGoNQe2-nA_Qn_qsZP2Iley9x6TU3Ht28Eg4t@mail.gmail.com>
References: <4C1957EF.6070504@gnatter.net>
	<4C25D783.4070602@gnatter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: William Hall <will@gnatter.net>
X-From: git-owner@vger.kernel.org Sat Jul 03 13:38:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV12v-0007xy-CH
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 13:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661Ab0GCLiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 07:38:00 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:53152 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab0GCLh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 07:37:59 -0400
Received: by pxi14 with SMTP id 14so1143468pxi.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7zWjXsnE4uIy7B9nJC97P0kQD/Ob/pozEX2F9y88/bg=;
        b=X6yfGr0GAfYUzK8EiB9M5oJFh4GJItgr9N36GehoYWQAUbpgqxIbqhRRURpczV2Fe3
         XJEyYTRfPf5Bdq0nCM9EhQrTuHGDMyr5XFBL1UMhqe9ABUGIM91vl4KcQkdr3ibZdZHV
         K84Z7xd+aewDEuf/9HcrHIvWbrkcCGmS/ztig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jneJJuDBEIVHcawTMEw5Qjvj3U4/P3IIR65e63aiFmuHXuVaOI6B4Dw8r70G7c70vM
         woBQgPzAYay3cP729tIJZjOPeWETnBxfdzzpM57lDG6mxZNKHuZP1AY1qK4B0XBTSFy8
         uesUdE4GP6qv6fqdzOApRdyEuOT6n5H1NiUuw=
Received: by 10.142.141.20 with SMTP id o20mr319689wfd.203.1278157077427; Sat, 
	03 Jul 2010 04:37:57 -0700 (PDT)
Received: by 10.142.70.11 with HTTP; Sat, 3 Jul 2010 04:37:57 -0700 (PDT)
In-Reply-To: <4C25D783.4070602@gnatter.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150188>

Hi William,

I have been following this thread with interest so I thought that I
would just throw in my thoughts!

While maintaining synchronization with Git is part of what is needed I
suspect that this will not entirely convince the management of your
company that Git is the way forward.

They probably see Svn as a safe repository ... The company's assets
(intellectual property) are on a central server that is backed up, and
the contents of that repository can be audited and so on. They may be
thinking about things like SOX compliance too.

So if you want them to accept Git as a replacement for svn then you
need to understand and address these concerns. This means that you
will have to have a conversation with them. To a large extent this a
people thing ... technical solutions won't necessary convince them.
They are running a company based on the knowledge and information they
own - and they want to make sure that it doesn't get lost, stolen,
corrupted, or whatever. And they are accountable to the shareholders
for this.

Also, you say that they have been using Svn for donkey's years, so
from a corporate perspective it probably does what they want and need.
Otherwise THEY would have decided to change it.

I am in a similar situation and while developers clearly want to use
gIt, the motivation from a corporate perspective is less clear and can
be perceived as introducing risk. So we are looking at the wya in
which repositories are set up, the topology of git repository
networks, use of Gitosis. Gitolite and Gitorious, and so on, to
provide some security in the corporate environment.

Every company will have a different view of this so there is no
'right' answer. A lot depends on the type of product you produce and
how long it will need to be supported. If you have products that need
to be supported for 10 years or more then promoting a tool that is 5
years old may also raise some eyebrows! You need to have the answers
ready :-)

Get it right and you will be seen as a hero who understands the
business. Get it wrong and you will consigned to the religious nerd
category who just wants to promote his favourite tool ... which I
would hope is not the case :-)

Good luck with this ... you are not alone!

Dave Bainbridge
