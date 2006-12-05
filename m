X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 05 Dec 2006 12:11:04 +0100
Organization: At home
Message-ID: <el3k0a$i62$2@sea.gmane.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <20061205090125.GA2428@cepheus> <45754AFE.1070207@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 5 Dec 2006 11:14:40 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33339>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrYFy-0006O1-Nn for gcvg-git@gmane.org; Tue, 05 Dec
 2006 12:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967459AbWLELL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 06:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968174AbWLELKs
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 06:10:48 -0500
Received: from main.gmane.org ([80.91.229.2]:42164 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968124AbWLELKG
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 06:10:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GrYBW-0007JL-E7 for git@vger.kernel.org; Tue, 05 Dec 2006 12:10:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 12:10:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 05 Dec 2006
 12:10:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andreas Ericsson wrote:

> Uwe Kleine-Koenig wrote:
>
>> Andreas Ericsson wrote:
>>> The only problem I'm seeing atm is that the supermodule somehow has to 
>>> mark whatever commits it's using from the submodule inside the submodule 
>>> repo so that they effectively become un-prunable, otherwise the 
>>> supermodule may some day find itself with a history that it can't restore.
>>>
>> One could circumvent that by creating a separate repo for the submodule
>> at checkout time and pull the needed objects in the supermodule's odb
>> when commiting the supermodule.  This way prune in the submodule cannot
>> do any harm, because in it's odb are no objects that are important for
>> the supermodule.
> 
> Yes, but then you'd lose history connectivity (I'm assuming you'd only 
> pull in the tree and blob objects from the submodule, and prefix the 
> tree-entrys with whatever directory you're storing the submodul in).

I thought that Uwe meant pulling (getting) _all_ the needed objects from
submodule object repository into supermodule object repository: commits,
trees and blobs, full history.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

