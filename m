X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: Re: Moving a directory into another fails
Date: Mon, 4 Dec 2006 19:19:58 +0100
Message-ID: <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
	 <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
	 <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
	 <20060728014350.GI13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 18:20:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NgLeKd9yUcqo2w/YDP9qBdxZ7ounC/pNzg96k2VNetrg+a/mFxUBWR195ZjZmUv9JnVSzTCZOtttRGbyHWKkWCYH8Fv5fyOkw1AtWJ+D/e/zl3vDb3EHC6S+Y5y3dlxHhRhdWegAF3cdoj2uPw+kHQvUHFXe1V4U1eYL/w1nbaI=
In-Reply-To: <20060728014350.GI13776@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33213>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrIQZ-0003L2-Uo for gcvg-git@gmane.org; Mon, 04 Dec
 2006 19:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937223AbWLDSU3 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 13:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937229AbWLDSU2
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 13:20:28 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:42840 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937223AbWLDSU2 convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 13:20:28 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1663353wra for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 10:20:23 -0800 (PST)
Received: by 10.90.69.8 with SMTP id r8mr8444499aga.1165256398921; Mon, 04
 Dec 2006 10:19:58 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Mon, 4 Dec 2006 10:19:58 -0800 (PST)
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hi Folks,

2006/7/28, Petr Baudis <pasky@suse.cz>:
> > mv: cannot stat `"gitweb/test/M\\303\\244rchen"': No such file or d=
irectory
since when is this file in the official git.git tree?

Its quite problematic when used on HFS+ because it uses UTF-16 internal=
ly IMHO.

Git always thinks there is a new file in my git.git clone.

--- snip ---
dreamind@paris:~/src/git% git status
# Untracked files:
#   (use "git add" to add to commit)
#
#       gitweb/test/Ma=CCrchen
nothing to commit
--- snap ---

bye

dreamind

--=20
       http://www.dreamind.de/
