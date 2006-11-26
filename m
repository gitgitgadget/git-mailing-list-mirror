X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Some tips for doing a CVS importer
Date: Sun, 26 Nov 2006 12:51:54 -0500
Message-ID: <9e4733910611260951u59599a16xd9ac6d37272f825f@mail.gmail.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
	 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>
	 <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
	 <9e4733910611201753m392b5defpb3eb295a075be789@mail.gmail.com>
	 <456969DA.6090702@gmx.net>
	 <9e4733910611260735g2b18e9d1p51a0dca153282cc7@mail.gmail.com>
	 <4569BCB8.9030809@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 17:52:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qu6PBulRo2qwRKkf0AVihP4W46nKrK4M9CdpIPp+bGtKjhSbvgQVQqERZpU6HJWOj0qB93pwvPQvxzB5Wa/MPXrN8zYQYbzlzbGlsXgDUbqZ09o0yk9vGE9OR9GFUNXcEpFVGxD/T8YlYuyTvBXzv9V5S2NJy5J5kJ+oeYL8i2Y=
In-Reply-To: <4569BCB8.9030809@gmx.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32360>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoOAZ-0005ra-LY for gcvg-git@gmane.org; Sun, 26 Nov
 2006 18:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935313AbWKZRv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 12:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935321AbWKZRv4
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 12:51:56 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:49660 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S935313AbWKZRvz
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 12:51:55 -0500
Received: by py-out-1112.google.com with SMTP id n39so954701pyh for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 09:51:55 -0800 (PST)
Received: by 10.35.62.1 with SMTP id p1mr11133749pyk.1164563514926; Sun, 26
 Nov 2006 09:51:54 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Sun, 26 Nov 2006 09:51:54 -0800 (PST)
To: "Marko Macek" <marko.macek@gmx.net>
Sender: git-owner@vger.kernel.org

On 11/26/06, Marko Macek <marko.macek@gmx.net> wrote:
> Jon Smirl wrote:
>
> > Another note for doing a converter. When combining things into change
> > sets, for git import the comments in the branches should not be mixed
> > between branches and the trunk when detecting change set. Git doesn't
> > allow simultaneous commits to the trunk and branches.
>
> Yup, this is the current problem I'm facing now. Even for CVS->SVN conversion,
> I don't want to see multi-branch commits.

There is a command line option on cvs2svn to isolate the branches. I
got him to add it as part of the attempt at doing git support.

>
> Mark
>


-- 
Jon Smirl
