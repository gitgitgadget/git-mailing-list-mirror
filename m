X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Thu, 30 Nov 2006 14:41:51 +0100
Organization: At home
Message-ID: <ekmmvf$hsr$1@sea.gmane.org>
References: <ekmlar$ask$2@sea.gmane.org> <200611301324.04993.andyparkins@gmail.com> <fcaeb9bf0611300532x77c7fc8aq2ba77ff57b81cc05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 30 Nov 2006 13:40:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32744>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpm9R-0006Je-9J for gcvg-git@gmane.org; Thu, 30 Nov
 2006 14:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936322AbWK3Nka (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 08:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936359AbWK3Nka
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 08:40:30 -0500
Received: from main.gmane.org ([80.91.229.2]:57255 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936322AbWK3Nk3 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 08:40:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gpm9C-0006Fc-BV for git@vger.kernel.org; Thu, 30 Nov 2006 14:40:18 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 14:40:18 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 14:40:18 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nguyen Thai Ngoc Duy wrote:

>> +# Clever commit - if this commit would do nothing, then make it an "all"
>> +# commit
>> +if [ -z "$(git-diff-index --cached --name-only HEAD)" \
>> +       -a -z "$amend" -a -z "$only" -a -z "$also" ]; then
>> +       echo "Nothing to commit but changes in working tree. Assuming 'git commit -a'"
> 
> This is hardly seen as the editor will immediately pop up. Better
> pause a second or put it in commit template (I'd prefer the latter).

Well, if it is VISUAL editor, you would see this. But adding this
to template is certainly good idea.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

