X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 14:13:35 +0200
Message-ID: <200610261413.36445.jnareb@gmail.com>
References: <20061022185350.GW75501@over-yonder.net> <ehq78n$ec7$1@sea.gmane.org> <4540A1FE.4050300@ableton.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 12:13:55 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j1RohnivYNOGZ55JVuBC6U05nQDA+Oio1CdSjo08MlVyXF2Gjv9mEcMn74+aPk390iOjFcgZfYHpdkOgpL4fM6TH9QTx1QMSCXCS7wrKJwLWqXN19k3sdfbJB1ePQBDKObqS8poSaST8rZskuf993vfKTtoXfR16ZtEtsdxKXbc=
User-Agent: KMail/1.9.3
In-Reply-To: <4540A1FE.4050300@ableton.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30200>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd46d-0003AH-Bu for gcvg-git@gmane.org; Thu, 26 Oct
 2006 14:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423351AbWJZMNA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 08:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423340AbWJZMNA
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 08:13:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:4162 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423353AbWJZMM7
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 08:12:59 -0400
Received: by ug-out-1314.google.com with SMTP id 32so343478ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 05:12:58 -0700 (PDT)
Received: by 10.66.243.4 with SMTP id q4mr2702812ugh; Thu, 26 Oct 2006
 05:12:57 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id y7sm166085ugc.2006.10.26.05.12.57; Thu, 26 Oct
 2006 05:12:57 -0700 (PDT)
To: Nicholas Allen <allen@ableton.com>
Sender: git-owner@vger.kernel.org

Nicholas Allen wrote:
> Jakub Narebski wrote:
>> 
>> 4. Supports Renames. I could agree with "Somewhat" because of not yet
>> implemented --follow option to git-rev-list (and therefore all porcelain).
>> Perhaps it would be closer to truth to leave the marker (background color)
>> as for "Somewhat" and write "N/A" with note that Git has contents and
>> pathname based heuristic detection of renames, or just put "Detect" or
>> "Detection" here.
>> 
>> I would certainly change description of what means that SCM doesn't "Support
>> Renames" or has it implemented partially. Current explanation relies
>> heavily on _implementation_. The correct wording of current definition
>> would be that SCM doesn't support renames if history of a file "as visible
>> to SCM" is broken into before rename and after rename part, and that SCM
>> support it partially if you can track history of renamed file from
>> post-rename name but there is left in void history of pre-rename file.
>> But with this definition Git _does_ "Supports Renames".
> 
> I would have thought that supports renames would also involve flagging a 
> conflict when merging a file that has been renamed on 2 separate 
> branches. ie 2 branches rename the file to different names and then one 
> branch is merged into the other. In this situation, the user should be 
> told of a rename conflict. Bzr supports this as far as I know. Not sure 
> about git though as I have never used it.

If I remember correctly Git usually resolves such conflict. If it cannot
resolve it, it tells user of rename conflict (add/add conflict or rename/add
conflict).

Unfortunately Git tutorial part 3 on merges is not yer written.
-- 
Jakub Narebski
