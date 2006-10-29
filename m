X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 13:48:41 +0100
Message-ID: <200610291348.41389.jnareb@gmail.com>
References: <200610291122.30852.jnareb@gmail.com> <7viri34a3k.fsf@assigned-by-dhcp.cox.net> <200610291324.42566.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 12:49:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cXekJEiIGkMKXkn2gUt2Y3VmjVG5YKKM33BsJbV8Ek0lbrGChm8Gtbj+PyTZXIZZFYL3ZAlPN2BHj7TYOdQv56cnG8ylInEhIxyZjtFx+6WqPf7rlOLPivQvST3j1lI+k9mcI3YLr8yNyuF9t2nOf4xUUdumykFRW/q/Qg1Z6tQ=
User-Agent: KMail/1.9.3
In-Reply-To: <200610291324.42566.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30431>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeA5t-0006ch-0H for gcvg-git@gmane.org; Sun, 29 Oct
 2006 13:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965172AbWJ2Msu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 07:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWJ2Msu
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 07:48:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:49683 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965172AbWJ2Mst
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 07:48:49 -0500
Received: by ug-out-1314.google.com with SMTP id 32so971995ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 04:48:48 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr2486201ugj; Sun, 29 Oct 2006
 04:48:47 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 54sm1906843ugp.2006.10.29.04.48.47; Sun, 29 Oct
 2006 04:48:47 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>> * there is added "extended diff header", with <path> and <hash>
>>>   hyperlinked (and <hash> shortened to 7 characters), and <mode>
>>>   explained: '<mode>' is extnded to '<mode>/<symbolic mode> (<file type>)'.
>> 
>> It somehow feels that deviating from what "git diff" gives makes
>> it very distracting; I would feel better if "/-rw-r--r-- (file)"
>> were not there.
> 
> Well, the old version had "(<file type>)" in gitweb diff header.
> Not all git/gitweb users are familiar with POSIX numeric modes;
> perhaps changing the style (color for example) of added stuff
> to mark it as added would be enough?

Or we could use the following code:

  <abbr title="100755/-rwxr-xr-x (file)">100755</abbr>

which gives explanation on mouse-over.
-- 
Jakub Narebski
