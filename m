X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface
 to the index
Date: Sat, 02 Dec 2006 15:51:01 +0100
Message-ID: <457192D5.8090209@xs4all.nl>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home> <7vpsb36yem.fsf@assigned-by-dhcp.cox.net> <87veku3i0j.wl%cworth@cworth.org> <7vlklq20n5.fsf@assigned-by-dhcp.cox.net> <ekrjc9$8uc$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 14:51:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <ekrjc9$8uc$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33025>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqWCs-0003qz-IF for gcvg-git@gmane.org; Sat, 02 Dec
 2006 15:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162450AbWLBOvH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 09:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162458AbWLBOvH
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 09:51:07 -0500
Received: from main.gmane.org ([80.91.229.2]:40853 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162450AbWLBOvE (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 09:51:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqWCl-0003p1-8N for git@vger.kernel.org; Sat, 02 Dec 2006 15:51:03 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Sat, 02 Dec 2006 15:51:03 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006 15:51:03
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:
> Junio C Hamano wrote:
> 
>> By the way, aren't people disturbed that "git rm" does not
>> default to "-f" -- I rarely use the command myself but that
>> makes it feel even more awkward that "git rm foo" does not
>> remove the file "foo".
> 
> But _only_ if file is unmodified. I think that "git rm" meaning
> "remove this file from version control, but not from working area"
> is a good thing; if you want to remove file, just /usr/bin/rm it.

In my workflow,  I regularly get bitten by this: 

I do 

  git checkout devel
  git rm src/foo.cc
  git commit src/foo.cc    # or whatever -a -i --difficult option is necessary

  git checkout stable

     ...barf: trying to overwrite untracked src/foo.cc file..


I think for the default to remove from the working area is better. 

FWIW, I consider it annoyance with CVS as well 

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
