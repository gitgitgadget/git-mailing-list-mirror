X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Stefano Spinucci" <virgo977virgo@gmail.com>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Mon, 18 Dec 2006 02:36:24 +0100
Message-ID: <906f26060612171736pab766b7t15a36d4d3fc7e85f@mail.gmail.com>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
	 <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
	 <0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de>
	 <Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com>
	 <906f26060612170633h50e3e974h3b84f1829e546278@mail.gmail.com>
	 <17797.35177.550000.996862@lapjr.intranet.kiel.bmiag.de>
	 <Pine.LNX.4.63.0612172027400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 01:36:39 +0000 (UTC)
Cc: "Juergen Ruehle" <j.ruehle@bmiag.de>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Florian v. Savigny" <lorian@fsavigny.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sc01EZwdt7lq9l42u5bYZ496zIiW+uFdk04DafPlFW/dnLdfn1vt9Wa2rJ6PjFl0FvBKaq6a9noX1zVpS+BewFPQ5fiB2D44BHLDUX04xPwKkksm+TZ8h7yFzeVrUt5OoGbwYw50AQDx00qX/n7U8ikiKrtrz7mltY7uFMFy3eY=
In-Reply-To: <Pine.LNX.4.63.0612172027400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34715>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw7Qc-0002dZ-Kc for gcvg-git@gmane.org; Mon, 18 Dec
 2006 02:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751285AbWLRBg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 20:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWLRBg0
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 20:36:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:22682 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751285AbWLRBgZ (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec
 2006 20:36:25 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1796576nfa for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 17:36:24 -0800 (PST)
Received: by 10.48.204.7 with SMTP id b7mr4203575nfg.1166405784494; Sun, 17
 Dec 2006 17:36:24 -0800 (PST)
Received: by 10.49.14.13 with HTTP; Sun, 17 Dec 2006 17:36:24 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> ...
> I am sure that there are more problems with it. BTW the problem stems from
> Windows having _no_ equivalent to fork().
> ...

I recompiled git with NO_MMAP and used it successfully, then I added a
note in the wiki
page http://git.or.cz/gitwiki/WindowsInstall on how to compile git to
work on a FAT32
filesystem.

Now, two questions...

if you are sure that there are more problems with using MMAP, shouldn't NO_MMAP
be commented better in the Makefile and in INSTALL, pointing out to
use it always on
cygwin ???

finally on cygwin there is a precompiled git package (v 1.4.4.1);
however, I found if it was
compiled *with* MMAP support... should I write to the cygwin-apps list
asking for a
different compilation (with NO_MMAP), or for the majority of the users
the standard
compilation is a better choice ???

bye

---
