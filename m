X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Mon, 04 Dec 2006 19:05:04 +0100
Organization: At home
Message-ID: <el1nsi$vat$1@sea.gmane.org>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com> <20061204173318.GG940MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 4 Dec 2006 18:03:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33210>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrIAG-0000c6-4D for gcvg-git@gmane.org; Mon, 04 Dec
 2006 19:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936571AbWLDSDb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 13:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936574AbWLDSDb
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 13:03:31 -0500
Received: from main.gmane.org ([80.91.229.2]:47792 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936571AbWLDSDa
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 13:03:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrI9s-0002Xm-0W for git@vger.kernel.org; Mon, 04 Dec 2006 19:03:16 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 19:03:16 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 19:03:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sven Verdoolaege wrote:

> On Fri, Dec 01, 2006 at 02:23:14PM +0300, Alexey Dobriyan wrote:
>> Has anyone thought about aggregating this into git-update-index or
>> somewhere?
>> 
>>    git-update-index -C1,3    #chunks 1, 3
>>    git commit
>>    git-update-index -C1,3    # chunks 2,5 in original numbering
>>    git commit
>> 
>> Relying on diff(1) definition of chunks is sorta hacky, though... I admit 
>> it.
> 
> Paul Mackerras modified his dirdiff tool to do something like this.
> I have a couple of patches on top of his version from way back at
> http://www.liacs.nl/~sverdool/gitweb.cgi?p=dirdiff.git;a=summary
> 
> I don't know if he has continued working on this.

If this has support for git, could you add it to GitWiki:
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
And perhaps also update related page
  http://git.or.cz/gitwiki/InterfacesFrontendsAndToolsWishlist

Thanks in advance.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

