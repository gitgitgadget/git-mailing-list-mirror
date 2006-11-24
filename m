X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 24 Nov 2006 13:41:29 +0100
Organization: At home
Message-ID: <ek6p6j$r6p$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>	<87hcx1u934.wl%cworth@cworth.org>	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>	<455BBCE9.4050503@xs4all.nl>	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>	<455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net> <455C618A.7080309@xs4all.nl> <ejkd6g$vog$1@sea.gmane.org> <4566E512.4010405@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 24 Nov 2006 12:40:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32215>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnaLh-0007jv-5d for gcvg-git@gmane.org; Fri, 24 Nov
 2006 13:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934501AbWKXMkF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 07:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934506AbWKXMkF
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 07:40:05 -0500
Received: from main.gmane.org ([80.91.229.2]:2442 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934501AbWKXMkD (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 07:40:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnaLS-0007gs-QD for git@vger.kernel.org; Fri, 24 Nov 2006 13:39:54 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 13:39:54 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 13:39:54 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> Jakub Narebski escreveu:
> 
>>>   - --pretty option with wholly uninformative options full, medium, 
>>> short, raw.  It's not even documented what each option does.
>> 
>> And 'oneline' and undocumented 'email'. True, git lacks documentation (and
>> this one of main complaints in git survey).
> 
> The recently posted patch documenting is an improvement, but why not
> add an option so you can do
> 
>   --format 'committer %c\nauthor %a\n'
>   
> this catches all combinations, and is easier for scripting.
> 
> Right now, I have some scripts that have to munge log output with
> regular expressions to strip out the "author:"  prefixes.

If we ever implemented this, I'd rather to separate what is now of format
parsing in git-for-each-ref (although I'd like to make it more like rpm's
--query-format argument, with %-n{header}, %[array] etc.) into separate
module, and reuse it for git-log and friends --pretty/--format handling.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

