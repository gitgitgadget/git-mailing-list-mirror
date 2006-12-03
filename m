X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 13:31:45 +0100
Message-ID: <200612031331.45410.jnareb@gmail.com>
References: <20061120215116.GA20736@admingilde.org> <200612030231.05900.jnareb@gmail.com> <200612031322.54748.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 12:31:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=V2VQ7zfvNig/WRYjElMg4v0cKlBEfVy+FZ2lkxasrrgOYSDQ8bHR5gJQQAurSeOrOr4+Kv4k1Xb+pwGBDOJBWw0bswlmDHu5OHh7FGsAjeIoBextox9jezvxXv3hWpQ8bUOZmMdWhrDRSjWT1w1Wi1Nypl5eiFJNs1/JMzGZrew=
User-Agent: KMail/1.9.3
In-Reply-To: <200612031322.54748.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33109>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqqVe-00030S-Ew for gcvg-git@gmane.org; Sun, 03 Dec
 2006 13:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759636AbWLCMbv convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 07:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759640AbWLCMbv
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 07:31:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:26283 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1759631AbWLCMbu
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 07:31:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2753498uga for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 04:31:49 -0800 (PST)
Received: by 10.67.89.5 with SMTP id r5mr10192148ugl.1165149108245; Sun, 03
 Dec 2006 04:31:48 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id k28sm19955150ugd.2006.12.03.04.31.47; Sun, 03 Dec
 2006 04:31:47 -0800 (PST)
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg wrote:
> s=F6ndag 03 december 2006 02:31 skrev Jakub Narebski:
>
>> Actually, rm -rf * is not needed for "git reset --hard" or
>> "git checkout -f" to succeed.
>=20
> True, but git reset --hard isn't always enough and rm -rf * is the go=
od ol'=20
> way of resetting things. Typically this comes from make being upset (=
or too=20
> content) with something.

$ git clean -d -x -q
$ git reset --hard

(or vice versa) then.

Besides, "rm -rf *" should not remove hidden files and hidden directori=
es,
including .git directory. And you should take great care with "rm -rf .=
*"
if it doesn't follow '..'
--=20
Jakub Narebski
