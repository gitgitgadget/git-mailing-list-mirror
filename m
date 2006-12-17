X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 17 Dec 2006 23:41:25 +0000
Message-ID: <200612172341.27709.andyparkins@gmail.com>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 23:44:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=i54iKhHg1fDWitw/HPJYFs4QOMQZdITTf+2vNfbd3/QSDrlrvfqZshbuucW1G9rn/XYaAyNUlinB/3Y8N7uu5zN+1/QsENsAHwH0P43ZueMIU+RqvHpL61HymM7jSdCL+vrwtgMvDAtWo543sv2hJpbx7X0N8KVfhFTP2mupwhs=
User-Agent: KMail/1.9.5
In-Reply-To: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34714>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw5g2-0005VR-3W for gcvg-git@gmane.org; Mon, 18 Dec
 2006 00:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753240AbWLQXoP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 18:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbWLQXoP
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 18:44:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:7821 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753240AbWLQXoO (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec
 2006 18:44:14 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1353048uga for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 15:44:13 -0800 (PST)
Received: by 10.66.232.11 with SMTP id e11mr5294887ugh.1166399053192; Sun, 17
 Dec 2006 15:44:13 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id k28sm8240554ugd.2006.12.17.15.44.12; Sun, 17 Dec
 2006 15:44:12 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 2006, December 16 23:10, Junio C Hamano wrote:

>    * revisions recorded in the reflog can be pruned out,
>      rendering some entries in reflog useless.

Can I suggest that it should be fine to prune reflog entries but that the act 
of pruning be a log entry itself?

Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
