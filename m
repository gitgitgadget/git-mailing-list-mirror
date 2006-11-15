X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 11:15:23 +0100
Message-ID: <8aa486160611150215n64bb01e6o49aeaf243ad8f817@mail.gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	 <87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz>
	 <87d57pu4qa.wl%cworth@cworth.org>
	 <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net>
	 <20061115040852.GL7201@pasky.or.cz>
	 <7vd57ps51c.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0611142342160.2591@xanadu.home>
	 <ejeotu$vrj$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 10:15:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GiQhLVbGaVG331vKiO3xBqLrAlgdIy8Rq3NJ3k8PMnMxSwPEEhOVR94nHCj21aXARsCu8dr3dr04uSJffg9AKM7fEhyfMci8Td3xqZ2lIxc3+3K5RDll4suB0WF9QrabHIPwYBuc2ykqBE1c3UNpndAjZCb3Uq8dgzMbHadQIe8=
In-Reply-To: <ejeotu$vrj$3@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31431>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkHnl-0008LN-1U for gcvg-git@gmane.org; Wed, 15 Nov
 2006 11:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966111AbWKOKPZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 05:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966738AbWKOKPZ
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 05:15:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:37995 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S966111AbWKOKPY
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 05:15:24 -0500
Received: by wx-out-0506.google.com with SMTP id s7so191348wxc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 02:15:24 -0800 (PST)
Received: by 10.70.35.1 with SMTP id i1mr2751000wxi.1163585724025; Wed, 15
 Nov 2006 02:15:24 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Wed, 15 Nov 2006 02:15:23 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 11/15/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Nicolas Pitre wrote:
>
> > On Tue, 14 Nov 2006, Junio C Hamano wrote:
> >
> >> Yes.  The current "merge" started its life as Linus's porcelain
> >> (we did not have fetch and pull infrastructure back then) but
> >> quickly has become just a helper for pull to produce a merge
> >> commit.  If anybody thinks its UI is good as a general end-user
> >> level command, there is a need for "head examination".
> >
> > If you mean "git merge" it sure needs to be brought forward.  It can't
> > be clearer than:
> >
> >       git-merge the_other_branch
> >
> > or
> >
> >       git-merge git://repo.com/time_machine.git
> >
> > to instantaneously understand what is going on.
>
> You mean
>
>       git merge git://repo.com/time_machine.git#branch
>
> don't you (perhaps with 'master' as default branch)?

perhaps with remote 'HEAD' as default branch?

