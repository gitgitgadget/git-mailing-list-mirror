X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 19:40:38 +0000
Message-ID: <200611281940.40139.andyparkins@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <ekhtnt$rkk$1@sea.gmane.org> <456C89E7.8080404@ableton.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 19:44:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qhhJO1xGdpdD+vzIeQc9AmuEp0ZQfBX2TvQdZRgXYNA1wS5Z2wvbY4UzgW2AsCMqLfGw6IdpiEq4a5wZA5ciNQQOvi1Zm5Jx+Cczo+9ckj5BUlRI5ciSy0m7Ol8qL07QnxIIpi8MNg8DN9+YCrV59YMN4eXd1h2AbLh3+Q1QLVA=
User-Agent: KMail/1.9.5
In-Reply-To: <456C89E7.8080404@ableton.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32568>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp8rc-00022J-K0 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 20:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936074AbWK1Tn0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 14:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936071AbWK1Tn0
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 14:43:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:59610 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936074AbWK1TnZ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 14:43:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1576238uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 11:43:23 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr2175854ugg.1164743003004; Tue, 28
 Nov 2006 11:43:23 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id e34sm20964045ugd.2006.11.28.11.43.21; Tue, 28 Nov
 2006 11:43:22 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006, November 28 19:11, Nicholas Allen wrote:

> This can't be fail safe though. I would prefer to also have the option
> to be able to *explicitly* tell the RCS that a file was renamed and not
> have it try to detect from the content  which is bound to have corner
> cases that fail. When I know I renamed a file why can't I explicitly

You want to tell git about a rename that will never fail to be detected?  No 
problem.

$ git mv oldname newname
$ git commit

The corner cases you speak about are when you rename and edit.

For me, I prefer that to be detected as at least the detection algorithm can 
be tuned - there is no fixing it if the VCS was forced to consider it a 
rename.

When I started using git I was worried about the lack of a rename, but now I 
realise that it's not needed - it's pointless.  The VCS is snapshotting 
moments in time, that's it.  Then by making cleverer and cleverer 
interpreters of those snapshots you have the potential to do stuff that is 
far more useful than "just" rename recording.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
