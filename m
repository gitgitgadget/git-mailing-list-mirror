X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Some tips for doing a CVS importer
Date: Tue, 21 Nov 2006 13:29:20 +1300
Message-ID: <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
	 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 00:29:29 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eP8fj3CvZHxA5DsJeLv3xB5Az4MgEShi2Uwu82Gxyn7RL1kx1ArQjfG5i8kWZU6x8huhxBb3+CTuBQ2OO9JWtL+8VkzLLGeT06oBXKGJcplHMQ0wubcINKNY5fCzlEbdD4iSEagjyBxk1HK1beYjpidmCNMIvRSHJq/VL/eKipY=
In-Reply-To: <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31964>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmJVu-0006ho-9I for gcvg-git@gmane.org; Tue, 21 Nov
 2006 01:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030572AbWKUA3X (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 19:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030577AbWKUA3X
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 19:29:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:52928 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1030572AbWKUA3W
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 19:29:22 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2521896nfa for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 16:29:21 -0800 (PST)
Received: by 10.49.12.4 with SMTP id p4mr170188nfi.1164068960816; Mon, 20 Nov
 2006 16:29:20 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Mon, 20 Nov 2006 16:29:20 -0800 (PST)
To: "Jon Smirl" <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/21/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > I gather this means that the cvs2svn track hasn't been as productive
> > as expected. Any remaining/unsolvable issues with it? I have been
> > chronically busy on my e-learning projects, but don't discard coming
> > back to this when I have some time.
>
> Look in this thread
> [Fwd: Re: What's in git.git]
>
> There is a message in there that explains a problem that the cvs2svn
> people aren't going to fix and it kills git.

I see - thanks for the pointer. Sorry to hear others in the Moz
project weren't so keen on hearing about alternatives to SVN. Long
term only something like GIT seems viable for such a large project (in
terms of community, branches/subprojects and codebase).

Two remaining questions
 - Where can I get your latest code? :-)
 - I gather the moz cvs repo has some cases that require getting the
symbol resolution right. Could this be performed as an extra pass /
task?

Eventually the Moz crowd will outgrow SVN - perhaps we should be
parsing the SVN dump format instead ;-)

cheers,


