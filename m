X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Using sha1 of commit for id of gitweb Atom feed entry
Date: Mon, 4 Dec 2006 00:48:39 +0100
Message-ID: <200612040048.39768.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 23:48:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uFADGGTIGbHRnqhfPpDTyKCmeV7PrcQddejDlB3TOYpFyY9cPeFGLBIeMHhyreh4f7KIGaaDf5l0QJDVGzM3IV8u18kuTEfWr0fU3/pOH6LdX4o2LAMwGIb9rLh3xxNW3SObYYV8n7gRLMyMrHLp6yP2deo0IgJOu05lNjqYNgA=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33154>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr14i-0003xl-KW for gcvg-git@gmane.org; Mon, 04 Dec
 2006 00:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759976AbWLCXsl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 18:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759977AbWLCXsl
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 18:48:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:37735 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1759976AbWLCXsk
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 18:48:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2852884uga for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 15:48:39 -0800 (PST)
Received: by 10.66.232.9 with SMTP id e9mr11073292ugh.1165189719135; Sun, 03
 Dec 2006 15:48:39 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 28sm26968261ugc.2006.12.03.15.48.38; Sun, 03 Dec
 2006 15:48:38 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

To all using Atom version of gitweb feeds: perhaps instead of using
appropriate "commit" view gitweb URL as if of gitweb Atom feed entry,
use sha1 of commit? We could create a new (unofficial for now) scheme:

  git:<sha1 of a commit>

or we can try to use tag URI scheme
 * "How to make a good ID in Atom"
   http://diveintomark.org/archives/2004/05/28/howto-atom-id
 * "Tag URI"
   http://www.taguri.org/
 * RFC 4151 - The 'tag' URI Scheme

With tag URI we need:
 1.) Identity by domain name or email address. We can use 
     (can we, Pasky?) use git.or.cz domain, or git@vger.kernel.org
     email address
 2.) Pick a date. We can use here epoch start date of 1970,
     date of 1.0 git release of 2005-12-21, or date of creating git
     mailing list of 2005, 2005-04 or 2005-04-10.

So for example the id for an entry which currently has id of
  http://repo.or.cz/w/git.git?a=commit;h=278fcd7debf19c1efee18b32f8867becb18d1a22
would have either
  git:278fcd7debf19c1efee18b32f8867becb18d1a22
or (one of the choices)
  tag:git@vger.kernel.org,2005:278fcd7debf19c1efee18b32f8867becb18d1a22

What do you think about it?

P.S. Or we could register URN... ;-)
-- 
Jakub Narebski
