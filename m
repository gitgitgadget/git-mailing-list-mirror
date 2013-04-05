From: Jan Larres <jan@majutsushi.net>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Fri, 5 Apr 2013 12:04:21 +0000 (UTC)
Message-ID: <slrnkltff7.mdl.jan@majutsushi.net>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
 <CACsJy8B9s0=EFUazrb9MhDJiou_dSzx6kezFCET+w+jUdBMv=A@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 21:15:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOYW3-0002aY-RG
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 21:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765900Ab3DFTLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 15:11:01 -0400
Received: from plane.gmane.org ([80.91.229.3]:52225 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765499Ab3DFTLB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 15:11:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UOYF2-0002oh-DM
	for git@vger.kernel.org; Sat, 06 Apr 2013 20:53:32 +0200
Received: from 101.98.187.16 ([101.98.187.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 20:53:32 +0200
Received: from jan by 101.98.187.16 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 20:53:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 101.98.187.16
User-Agent: slrn/pre1.0.0-18 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220270>

Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Mar 30, 2013 at 8:45 PM, Jan Larres <jan@majutsushi.net> wrote:
>> I would expect the last command to also report 'set'. I've also tried
>> other patterns like 'foo/' and 'foo*', but it didn't make any
>> difference.
>
> Try "foo/**". You need 1.8.2 though.

That indeed works exactly the way I would like! Thanks a lot!

Jan
