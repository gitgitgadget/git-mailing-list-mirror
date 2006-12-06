X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 06 Dec 2006 16:36:47 +0100
Message-ID: <4576E38F.1020404@xs4all.nl>
References: <el6c6o$oa7$1@sea.gmane.org> <200612061551.51603.jnareb@gmail.com> <4576DBA5.4080002@xs4all.nl> <200612061627.40359.jnareb@gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 15:37:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <200612061627.40359.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33476>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grypb-0004K1-Fj for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935753AbWLFPhE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935871AbWLFPhC
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:37:02 -0500
Received: from main.gmane.org ([80.91.229.2]:55377 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S935778AbWLFPhA
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 10:37:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrypI-00012F-52 for git@vger.kernel.org; Wed, 06 Dec 2006 16:36:52 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 06 Dec 2006 16:36:52 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006 16:36:52
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:
> Still I think that at least
> 
>   datarootdir = @datarootdir@
> 
> should be not removed.

yes, agreed.

>>>> +  if test -f $srcdir/$d/Makefile ; then
  [..]
>>>> +    echo creating $d/Makefile
>>>> +    cat << EOF> $d/Makefile

>>> This part IMHO has no sense, and has no place here.
> 
> If you want to create or modify Makefiles, do that. Not generate
> "minimal" Makefiles in every and each subdirectory.

Look more closely at the patch. It only generates Makefiles in 
directories that have makefiles in the source dir. The makefiles are
short because that is the easiest to do.

I'm happy to amend the patch, bUt I can't properly test
it until the perl problem gets sorted out. 

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
