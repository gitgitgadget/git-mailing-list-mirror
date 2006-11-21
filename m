X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Some tips for doing a CVS importer
Date: Mon, 20 Nov 2006 20:40:40 -0500
Message-ID: <9e4733910611201740i348302e6r84c3c27dc27e5954@mail.gmail.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
	 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>
	 <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
	 <87vel9y5x6.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 01:40:57 +0000 (UTC)
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A1C4qs5X5c7/gHlRU6pAcVa0KjtWtfJGgjKDxp/U+TddLPSPJmK8zGEZvhOeEoi3RnkxrhrvhVvPlD2D3ozaLnprkGKCK4+7BBveWNJZn3bGgkSmQ1FHHgzxmwC8YBQfxqkTbNJtqtaoA9rlo4fbKI37UnRlNl6LvL9Hi4yJy04=
In-Reply-To: <87vel9y5x6.wl%cworth@cworth.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31968>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmKcz-0004nC-38 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 02:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030646AbWKUBkn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 20:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWKUBkn
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 20:40:43 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:27512 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1030646AbWKUBkl
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 20:40:41 -0500
Received: by wx-out-0506.google.com with SMTP id s7so1994135wxc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 17:40:41 -0800 (PST)
Received: by 10.90.90.3 with SMTP id n3mr1834328agb.1164073241061; Mon, 20
 Nov 2006 17:40:41 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Mon, 20 Nov 2006 17:40:40 -0800 (PST)
To: "Carl Worth" <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On 11/20/06, Carl Worth <cworth@cworth.org> wrote:
> On Tue, 21 Nov 2006 13:29:20 +1300, "Martin Langhoff" wrote:
> > I see - thanks for the pointer. Sorry to hear others in the Moz
> > project weren't so keen on hearing about alternatives to SVN. Long
> > term only something like GIT seems viable for such a large project (in
> > terms of community, branches/subprojects and codebase).
> ...
> > Eventually the Moz crowd will outgrow SVN - perhaps we should be
> > parsing the SVN dump format instead ;-)
>
> From what I understand, mozilla is currently using CVS and is looking
> to replace that. The remaining options being considered are bzr and
> hg, (git having been discarded due to the lack of a "native" win32

brendan said SVN is likely for the main Mozilla repo and monotone for
the new Mozilla 2 work. No native win32 caused git to be immediately
discarded.

> client---the cygwin stuff is apparently not considered viable for
> whatever reason).
>
> -Carl
>
>
>


-- 
Jon Smirl
