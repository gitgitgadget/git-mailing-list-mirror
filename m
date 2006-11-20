X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Mon, 20 Nov 2006 21:02:21 +0100
Organization: At home
Message-ID: <ejt1hi$niu$1@sea.gmane.org>
References: <junkio@cox.net> <200611201944.kAKJiCAw014973@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 20 Nov 2006 20:01:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31934>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmFKZ-0003Ia-GX for gcvg-git@gmane.org; Mon, 20 Nov
 2006 21:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966620AbWKTUBL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 15:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966603AbWKTUBK
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 15:01:10 -0500
Received: from main.gmane.org ([80.91.229.2]:63400 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966610AbWKTUBJ (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 15:01:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmFK5-0003BC-62 for git@vger.kernel.org; Mon, 20 Nov 2006 21:00:57 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 21:00:57 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 20 Nov 2006
 21:00:57 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Horst H. von Brand wrote:
> Junio C Hamano <junkio@cox.net> wrote:
>> Junio C Hamano <junkio@cox.net> writes:
>>> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
>>>
>>>> [hanwen@haring y]$ git pull ../x
>>>> fatal: Needed a single revision
>>>> Pulling into a black hole?
>> 
>> Having said all that, I happen to think that this particular
>> case of pulling into void could deserve to be special cased to
>> pretend it is a fast forward (after all, nothingness is an
>> ancestor of anything), if only to make new people's first
>> experience more pleasant.
> 
> If you make pushing into an empty repository work also, you fix the case of
> "create an empty repo for somebody, let them fill it up remotely later".

That was only the _pull_ which didn't work in empty repo.
Fetch and push worked (and work) just fine with empty repo.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

