X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 13:34:36 -0800 (PST)
Message-ID: <850923.44762.qm@web31812.mail.mud.yahoo.com>
References: <200610300905.04454.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 21:35:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Yzb8zekj5BuwB8YRuuxsarWkum6i/Rg5Zcx9p8rM3ORI+uyuNuhxkQ0z+dl2tnfLb4qMkE/2uTkm5RmxXkk/GtuT6PeZT89xh0B8uqXBju2SIAzVwUnviN0asi3D4HVGddzoKz6EjlSOKA/Fksag2w/4/DM9k/8qOPEmqvTTvW0=  ;
X-YMail-OSG: iSdfd7AVM1nX2HCKCQE3h9DYEdRSP9btgtAKhAkDawxZGs_6jDegyeS5b1YPsnbIjcew.UBW3FxLODnlJqvuk0mEBQYR2tcI8EfU75xDSQxqVoh4wpkzKetxDc0sT03Bzjv3kRaa_4M-
In-Reply-To: <200610300905.04454.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30528>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeemJ-0004Qe-C3 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161514AbWJ3Vej (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161515AbWJ3Vej
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:34:39 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:29058 "HELO
 web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1161514AbWJ3Vei (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006
 16:34:38 -0500
Received: (qmail 44765 invoked by uid 60001); 30 Oct 2006 21:34:36 -0000
Received: from [64.215.88.90] by web31812.mail.mud.yahoo.com via HTTP; Mon,
 30 Oct 2006 13:34:36 PST
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> > Wouldn't this be confusing with the other fine lines?
> > I personally don't like this chunk separation.  Chunk separation
> > already exists as is and we view it all the time elsewhere.
> 
> But not always the program displaying diff can display such line
> separating chunks, for example on text terminal it can't.

What I meant is that since I stare at diffs exactly on text terminals,
my eyes have found other ways to discern chunk blocks.

> But if you think that the dotted 1px #ffbbff line is too intrusive,
> we can remove it (and perhaps increase vertical space a few pixels).
> I'd like to have more opinions first.

No, I just think that it should be as close as possible to what
we see now and what we see on text terminals -- no extra vertical
space please.  Between the two evils, I'd prefer the thin "dotted" line.

> BTW. you can easily override it in your CSS file.

Why should we allow something to go into gitweb and disrupt the current
default behavior only so that people have to change their own css file
to keep current default behaviour.  Please don't shove this down our
throats.  Please?

   Luben
