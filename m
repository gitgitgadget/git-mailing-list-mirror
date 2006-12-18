X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 18 Dec 2006 09:17:44 +0000
Message-ID: <200612180917.46214.andyparkins@gmail.com>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <200612172341.27709.andyparkins@gmail.com> <7vac1l1v8e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 09:18:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Oy/Pm3KNCDBs/MwFO+UVSuurP+SMEuxFSuazisqIZfldqquKesqIa8S5TXPb2K4G3LQ5spLa3khj4E6xd27jMDpSi7QeWnVtCssL0iuJikO2aMaJBFLPlSL3RS3WuPG8Vx59rEEo9kTOUDuLkOVDEfGuBcxjQLKBzSGhk3QYQfk=
User-Agent: KMail/1.9.5
In-Reply-To: <7vac1l1v8e.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34731>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwEdL-0004AZ-UR for gcvg-git@gmane.org; Mon, 18 Dec
 2006 10:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753593AbWLRJSE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 04:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbWLRJSE
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 04:18:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:36152 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753593AbWLRJSC (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec
 2006 04:18:02 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1444722uga for
 <git@vger.kernel.org>; Mon, 18 Dec 2006 01:18:00 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr4719367ugm.1166433470322; Mon, 18
 Dec 2006 01:17:50 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id b23sm8837255ugd.2006.12.18.01.17.49; Mon, 18 Dec 2006 01:17:49 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Monday 2006 December 18 08:09, Junio C Hamano wrote:

> By definition each reflog entry says "it was pointing at this
> object before, and it was changed by this user to point at that
> object at this time and the reason for the change was this".

I'm daft.  I've realised, pruning doesn't remove the ref, it removes one of 
the hashes in the reflog.  I withdraw my comment.

I'd imagined it' as the opposite of a creation.

000000 abcdef  branch created
abcdef 000000  branch deleted

Which is fine, except that isn't what prune is doing at all.

> I personally do not think recording "at this point these things
> were pruned" makes _any_ sense whatsoever --- if you care about

I think you're right. :-)


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
