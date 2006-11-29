X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --bool and --int to the OPTIONS section
Date: Wed, 29 Nov 2006 11:09:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611291107130.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vd5772unw.fsf@assigned-by-dhcp.cox.net> <200611290825.40953.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 10:09:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200611290825.40953.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32628>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpMNw-00033K-8k for gcvg-git@gmane.org; Wed, 29 Nov
 2006 11:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966654AbWK2KJp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 05:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966656AbWK2KJp
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 05:09:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:62954 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S966654AbWK2KJo (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 05:09:44 -0500
Received: (qmail invoked by alias); 29 Nov 2006 10:09:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 29 Nov 2006 11:09:42 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Andy Parkins wrote:

> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---

You might want to use a more-to-the-point subject, and move this into the 
commit message:

> I did look for just such an option, but didn't find it because it wasn't 
> in the OPTIONS list of the git-repo-config man page.  If there is an 
> OPTIONS section it should include all options, otherwise it's no use as 
> a quick reference.

And this belongs into another mail:

> Your template commit message is an excellent idea, but I don't like the idea 
> of simply hard coding sign off line into it; it means that there are then two 
> locations in the .git tree that I'd have to edit to change my name. 
> [...]

But to answer your concern: you would do this as a hook, which is a script 
in which you do not put your name directly. Rather, this script gets the 
current author name by calling either git-var or git-repo-config.

Ciao,
Dscho
