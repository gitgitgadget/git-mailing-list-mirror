X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core.
 Call with explicit path.
Date: Fri, 08 Dec 2006 21:50:26 +0100
Message-ID: <4579D012.6020605@xs4all.nl>
References: <elc6g3$v1m$1@sea.gmane.org> <fcaeb9bf0612081111h53699ecbr5fb72e17526993d5@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 20:50:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82-171-213-190.dsl.ip.tiscali.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <fcaeb9bf0612081111h53699ecbr5fb72e17526993d5@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33743>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsmg3-0003Bj-VE for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947191AbWLHUuh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 15:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947217AbWLHUuh
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:50:37 -0500
Received: from main.gmane.org ([80.91.229.2]:49861 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1947191AbWLHUug
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 15:50:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gsmfs-0006GE-4F for git@vger.kernel.org; Fri, 08 Dec 2006 21:50:28 +0100
Received: from 82-171-213-190.dsl.ip.tiscali.nl ([82.171.213.190]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 21:50:28 +0100
Received: from hanwen by 82-171-213-190.dsl.ip.tiscali.nl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 21:50:28 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nguyen Thai Ngoc Duy escreveu:
> On 12/9/06, Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
>>
>> git-sh-setup isn't a 'normal' binary, in that it should be called by
>> bash only and not run in a subshell. Therefore, it should not be
>> installed
>> in a executable directory, but rather in $prefix/share/git-core/
> 
> Executables should not go to $prefix/share I think. Maybe $prefix/libexec?

Yes, correct. Will change.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
