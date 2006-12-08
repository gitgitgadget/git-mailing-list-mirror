X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Problem compiling: that perl thing again
Date: Fri, 8 Dec 2006 12:36:28 -0800 (PST)
Message-ID: <805469.91804.qm@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 8 Dec 2006 20:37:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=T7fKDM2suZ7KDdJIwu9ZjIPYArBb2fF80WhNUuvM6dpJwvwPwX/LC44tVnV4Q4c2pV/APPDdZj1ip41bD2n17GLNn/uwdZUIoJ9ZpxlksXuC3NEgL8gaEZpu8BUo/V4YJ9w5cAwaDEUaVYVbz1ZjAJ2+tgfg0oWxgsuI7XouJOs=;
X-YMail-OSG: tSWsKR4VM1mxpVbtALl2_GLTaoU_nu2hbngjDv1hn9SHjFWZik1Q7d.LU_wxerwp.lhfOwglCQf8lcI54lsZyi0rZ7zYhsVcBUZLIztWygWCeRdaaBO3Sivl_X5eYQ_yDJa1n9PLHb16kEo-
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33738>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsmSe-0001aU-Fk for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947219AbWLHUga (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 15:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947217AbWLHUga
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:36:30 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:44587 "HELO
 web31805.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S1947219AbWLHUg3 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 15:36:29 -0500
Received: (qmail 92113 invoked by uid 60001); 8 Dec 2006 20:36:28 -0000
Received: from [64.215.88.90] by web31805.mail.mud.yahoo.com via HTTP; Fri,
 08 Dec 2006 12:36:28 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Over the last 2 months each time I pull, check out next and compile,
I'm seeing _some_ kind of problem with compiling the perl section
of git.  Sometimes git-reset --hard, or a fresh checkout, or git-clean
resolve the situation.  But not this time.

Here is what I see now:
$ make
...
make -C perl PERL_PATH='/usr/bin/perl' prefix='/home/luben' all
make[1]: Entering directory `/home/luben/projects/git-next/perl'
Makefile out-of-date with respect to Makefile.PL
/usr/lib64/perl5/5.8.6/x86_64-linux-thread-multi/Config.pm
/usr/lib64/perl5/5.8.6/x86_64-linux-thread-multi/CORE/config.h
Cleaning current config before rebuilding Makefile...
mv: cannot stat `perl.mak': No such file or directory
make[1]: *** [perl.mak] Error 1
make[1]: *** Waiting for unfinished jobs....
make[1]: *** Waiting for unfinished jobs....
make[1]: *** Waiting for unfinished jobs....
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory `/home/luben/projects/git-next/perl'
make: *** [all] Error 2
$ git-rev-list --max-count=1 HEAD
e1e8377415c8754c3773c09b78baaffa89d6fa9e

So, where is "perl.mak"?

   Luben
