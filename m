X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Thu, 30 Nov 2006 14:13:47 +0100
Organization: At home
Message-ID: <ekmlar$ask$2@sea.gmane.org>
References: <200611301259.32387.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 30 Nov 2006 13:15:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32741>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpll0-0007lA-SL for gcvg-git@gmane.org; Thu, 30 Nov
 2006 14:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936391AbWK3NPO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 08:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936392AbWK3NPO
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 08:15:14 -0500
Received: from main.gmane.org ([80.91.229.2]:4482 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936391AbWK3NPM (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 08:15:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gplkk-0007jb-HC for git@vger.kernel.org; Thu, 30 Nov 2006 14:15:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 14:15:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 14:15:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> Raimund Bauer offered this suggestion (paraphrased):
> 
> "Maybe we could do git-commit -a  _only_ if the index matches HEAD, and
> otherwise keep current behavior?  So people who don't care about the
> index won't get tripped up, and when you do have a dirty index, you get
> told about it?"
> 
> Johannes Schindelin pointed out that this isn't the right thing to do for
> an --amend, so that is checked for.
> 
> Additionally, it's probably not the right thing to do if any files are
> specified with "--only" or "--include", so they turn this behaviour off
> as well.

Could we add suggestion by Andreas Ericsson to print in the "smart commit"
case:

  Nothing to commit but changes in working tree. Assuming 'git commit -a'

or something like that?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

