X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Bugreport: core-tutorial example outdated?
Date: Wed, 25 Oct 2006 13:24:08 -0400
Message-ID: <20061025172408.GC26279@fieldses.org>
References: <453F9BA5.3020104@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 17:24:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <453F9BA5.3020104@anagramm.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30081>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcmUA-0002Di-JA for gcvg-git@gmane.org; Wed, 25 Oct
 2006 19:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932271AbWJYRYL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 13:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWJYRYK
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 13:24:10 -0400
Received: from mail.fieldses.org ([66.93.2.214]:39040 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S932271AbWJYRYJ (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 13:24:09 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GcmU4-0000zz-DF; Wed, 25 Oct 2006
 13:24:08 -0400
To: Clemens Koller <clemens.koller@anagramm.de>
Sender: git-owner@vger.kernel.org

On Wed, Oct 25, 2006 at 07:15:17PM +0200, Clemens Koller wrote:
> Hi there!
> 
> I just studied
> http://www.kernel.org/pub/software/scm/git/docs/core-tutorial.html
> to get more into the details of git. But the following commands:
> 
> $ git-cat-file -t 557db03de997c86a4a028e1ebd3a1ceb225be238
> $ git-cat-file "blob" 557db03
> 
> just bring up a
> 
> fatal: Not a valid object name 557db03de
> 
> I guess the documentation is slightly outdated and might need a fix.

Works for me.  The precise names there depend on the files you create
being byte-for-byte identical to the ones created by the echo commands
in the tutorial.  If yours aren't identical, then you should just use
the names that the previous ls command instead.

