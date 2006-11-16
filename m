X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git tag: don't complain of empty messages
Date: Thu, 16 Nov 2006 01:38:33 +0100
Organization: At home
Message-ID: <ejgbrq$o5u$1@sea.gmane.org>
References: <ejfc1t$6am$1@sea.gmane.org> <7v64dgo9gj.fsf@assigned-by-dhcp.cox.net> <455BAD80.1080108@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 16 Nov 2006 00:37:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31533>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkVFz-0002Yq-7G for gcvg-git@gmane.org; Thu, 16 Nov
 2006 01:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162118AbWKPAh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 19:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162120AbWKPAh1
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 19:37:27 -0500
Received: from main.gmane.org ([80.91.229.2]:7813 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162118AbWKPAh1 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 19:37:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkVFn-0002XT-Qk for git@vger.kernel.org; Thu, 16 Nov 2006 01:37:20 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 01:37:19 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16 Nov 2006
 01:37:19 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> Junio C Hamano escreveu:
>> I do not have a strong objection against allowing tags without
>> messages, but at the same time I do not see a compelling reason
>> to allow them either.  Care to explain what workflow is helped
>> by an empty tag?
> 
> the tagname usually is enough of a description, but I want the tags to 
> end up in the object DB, eg.:
> 
>    git tag release/2.10.0 HEAD
> 
> now I have to use
> 
>    git tag -m "this really sucks"  release/2.10.0 HEAD

Why not

   git tag -m "release 2.10.0" release/2.10.0 HEAD

This way you would know what tag points to even if you loose it's
reference...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

