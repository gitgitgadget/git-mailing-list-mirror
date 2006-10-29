X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: master and origin
Date: Sun, 29 Oct 2006 14:58:55 -0800 (PST)
Message-ID: <137435.85891.qm@web31809.mail.mud.yahoo.com>
References: <4d8e3fd30610291253s2d8000dfx942e0fa20e0057f6@mail.gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 29 Oct 2006 22:59:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=JTU80sYvuwi3cMH+xzgLEziCxTlQQgn71BnJ84R/g723hDx8g/oFpIB740CZ8Gn4NFCrsAHgGxODEt4UgIlp7Yj69NgKrwKSE1dZzTflKxyxsvdhzz75NUd8x8saf79GBpuoK0VRAX22qUB17/qBBgGL63MW3BmzQ9TYTZxfwcU=  ;
X-YMail-OSG: DIOOkQEVM1kcpySPK7OoJVyWzV.oIApPO7M9aShzL510CBiH.aYGwyNKYzMlXxRUJj9gPu7tIuMj9DOUjYwihor9fD.zKKc7w.40lgEtwqMXi9DP3F6ssOxJj4ZM6wb_0Ciaf16d20UFAQg-
In-Reply-To: <4d8e3fd30610291253s2d8000dfx942e0fa20e0057f6@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30471>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeJcJ-0005HI-Ai for gcvg-git@gmane.org; Sun, 29 Oct
 2006 23:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030414AbWJ2W64 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 17:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWJ2W64
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 17:58:56 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:47487 "HELO
 web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1030414AbWJ2W64 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006
 17:58:56 -0500
Received: (qmail 89415 invoked by uid 60001); 29 Oct 2006 22:58:55 -0000
Received: from [71.80.233.118] by web31809.mail.mud.yahoo.com via HTTP; Sun,
 29 Oct 2006 14:58:55 PST
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Git Mailing List
 <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

--- Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> Hi all,
> I went trough the docs I found on the web but I still don't fully
> understand why if I clone a remote repository my local copy has two
> branches, origin (that is always a exact copy of the remote
> repository) and master which is... what? The branch supposed to be
> used for local development?
> 
> I'm used to just checkout to a new branch, do my own development and
> then diff against origin so I'm missing why I see the master branch.
> 
> I'm sure I'm missing something very fundamental but I cannot figure
> out what is it :-)

Read the documentation of git-fetch and especially the second
"Note" therein.

   Luben
