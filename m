X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] "master" should be treated no differently from any other
     branch
Date: Thu, 14 Dec 2006 16:59:05 +0100
Message-ID: <458174C9.2050401@xs4all.nl>
References: <200612141519.44294.andyparkins@gmail.com> <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de> <4581721B.4050102@xs4all.nl>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 15:59:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4581721B.4050102@xs4all.nl>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34358>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gusz8-00025t-D0 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932829AbWLNP67 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932839AbWLNP67
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:58:59 -0500
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:4945 "EHLO
 smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932829AbWLNP66 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 10:58:58 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kBEFwtb7047266 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Thu, 14 Dec 2006 16:58:55 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys escreveu:
> Johannes Schindelin escreveu:
>> Hi,
>>
>> On Thu, 14 Dec 2006, Andy Parkins wrote:
>>
>>> "master" shouldn't get special treatment; making different log messages 
>>> based on the name of the branch is bad form.  What if a user likes 
>>> "my/master" or "my/head" as their master branch?
>> I do not agree. There is usually a principal branch, where you collect the 
>> topics, and you do want to treat that special. As for the name: better 
>> have a convention here than configurability. You would not want "git" to 
>> be called "guitar" for some users, just because they happen to like that 
>> name more, either, right?
> 
> Disagree: I have two principal branches, master and stable/2.10.  I don't see
> why the latter should get different commit messages.

Note that this also confused my codeveloper (who is rather enamoured bzr), who
was wondering what the other branch was in case of 

  Merge branch 'master' of ssh+git://git.sv.gnu.org/srv/git/lilypond


Wouldn't it be better to mention the id of the local repository too? 

  Merge branch 'master' of ssh+git://git.sv.gnu.org/srv/git/lilypond into 
  'master' of 'hanwen@xs4all.nl'

this would give more information when these commit messages get pushed to 
someone else.

-- 
