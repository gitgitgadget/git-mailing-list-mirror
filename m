X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 17:24:45 -0800
Message-ID: <f2b55d220611171724u616ac6ft300abd066682ef22@mail.gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	 <455BBCE9.4050503@xs4all.nl>
	 <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	 <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0611161508530.3349@woody.osdl.org>
	 <455CFCBD.8040901@xs4all.nl>
	 <f2b55d220611161734m49136e6fneda5b002eb67618b@mail.gmail.com>
	 <f2b55d220611162242s48dc42d6g4cbfd9173e712ff8@mail.gmail.com>
	 <7v64dev88t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 01:25:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hiurx0I2xGVPC9PgMjaMBxyREF/jhksqwathJ9R2M+aSzi2U6QjGMxzjo4REg4Gc53xS8Zb85QsGgZGQyJ5Ug5usYce0JavvWErk306Oa0QrU/3Gl5gy5nH1j7AMKoemdjOiBWkLEXc3869DujuIV6MaLrOB6ExeygNGSClXhow=
In-Reply-To: <7v64dev88t.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31747>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlEww-0003cG-8D for gcvg-git@gmane.org; Sat, 18 Nov
 2006 02:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756118AbWKRBYr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 20:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756119AbWKRBYr
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 20:24:47 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:18840 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1756118AbWKRBYq
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 20:24:46 -0500
Received: by wx-out-0506.google.com with SMTP id s7so1141536wxc for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 17:24:45 -0800 (PST)
Received: by 10.90.50.1 with SMTP id x1mr2373579agx.1163813085507; Fri, 17
 Nov 2006 17:24:45 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Fri, 17 Nov 2006 17:24:45 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/16/06, Junio C Hamano <junkio@cox.net> wrote:
> "Michael K. Edwards" <medwards.linux@gmail.com> writes:
>
> > Presumably "git branch -D" should inspect everything under
> > .git/remotes to see whether one or more Pull: lines need to be
> > deleted along with the branch.
>
> I am not sure what you mean.  .git/remotes files do not describe
> any relationship between local branches (and that is where one
> of the problem raised in recent thread -- pull does not notice
> on which branch you are on and change its behaviour depending on
> it), so I do not think there is anything gained for "git branch
> -D" by going through them.

.git/remotes/foo does contain Pull: lines which indicate the local
branch onto which to _fetch_ remote changes.  It's the subsequent
_merge_ that doesn't notice which branch you have checked out.

Cheers,
