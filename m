X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Sat, 2 Dec 2006 08:48:33 +0100
Message-ID: <e5bfff550612012348g4c6bc53bqbc0ff8633ea1a51a@mail.gmail.com>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <456EBBE7.8030404@op5.se>
	 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
	 <20061130164046.GB17715@thunk.org>
	 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
	 <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
	 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
	 <456F4E38.50001@codeweavers.com> <eknj33$q2r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 07:49:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CCjToo8OaT9QX491AV/GZwEXe5PiWCKZnfbPt4alHuwHShJ26yEP47ongQZtbAP/HKcuumRMjQonBqbOymRCEhnYz4hPgy9z2d906QmSrNBYhigFpRy++NQiwJHyhUpNcGAiDmPVDd6ozAvUGRnu289HTEhd4bVqxKU2TfrBopg=
In-Reply-To: <eknj33$q2r$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33002>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqPcJ-0005MU-FL for gcvg-git@gmane.org; Sat, 02 Dec
 2006 08:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161343AbWLBHsf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 02:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161383AbWLBHsf
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 02:48:35 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:9358 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1161343AbWLBHsf
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 02:48:35 -0500
Received: by py-out-1112.google.com with SMTP id a29so1941343pyi for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 23:48:33 -0800 (PST)
Received: by 10.35.94.7 with SMTP id w7mr10278346pyl.1165045713594; Fri, 01
 Dec 2006 23:48:33 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Fri, 1 Dec 2006 23:48:33 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

>
> Index is accessible, just like committed contents. The fact that gitk, qgit,
> git-gui doesn't display state of index is their limitation.
> --

Actually qgit let's you see state index for each file when committing
with qgit commit dialog.

Indeed you can also choose to update only the index state of a file
without committing, ie without create a new tree object.

Internally, the index state of each file is known and tracked. No
other interface is provided, as example a diff, just because I found
it confusing and of little concrete help.

Of course if knowning the index state became important to perform some
concrete and quite common operation I could add whatever GUI would
suite.

Suggestions are welcomed ;-)

