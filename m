From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/2] gitweb: Add an option to show size of blobs in the tree view
Date: Thu, 2 Aug 2007 12:47:07 +0200
Message-ID: <200708021247.08612.jnareb@gmail.com>
References: <1185880790812-git-send-email-jnareb@gmail.com> <200708020158.50343.jnareb@gmail.com> <7vtzri1pfi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 20:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGfL0-0006a5-Rn
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 20:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbXHBSXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 14:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756084AbXHBSXs
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 14:23:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:7321 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbXHBSXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 14:23:47 -0400
Received: by nf-out-0910.google.com with SMTP id g13so158485nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 11:23:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CKVKUwAT668NdygfqrXFFxdfvxnjVfCwLBNr1mDEaLqMcfJXVGoiTxll59gNyIEz2GSl/C6rrk/aKKw6isiFiGfArhOeDL6G6yMLfV6EuwopnZ+gPkunvewX1+7Qul+2m3Y01Aj2b6JUhSv5H6GtE/+IBvsKe/cOv6u7574u5UI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qYuIsMFqqY47GbSEy4s2LwkelcLtM8qPRmNfhf7ERwuieXdvgYiV6//xN37hW4AdfHpcr5LIsqo6NGAwN71cqLwKJFuNkHfHsb7KTfClvuXx9qYUpAYNs9+AshAIIauDROlyIra6tM73vYyMS3Z9+sXpJTJ9CljwvAcRiyyNanM=
Received: by 10.86.71.1 with SMTP id t1mr1581740fga.1186079026043;
        Thu, 02 Aug 2007 11:23:46 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id o11sm4546704fkf.2007.08.02.11.23.42
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 11:23:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtzri1pfi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54584>

Junio C Hamano wrote:

> Personally, this late in the game, I would be more interested in
> resolving the File::Find() stuff, which has been a real issue in
> the field, than the compressed transfer one.

I posted my tentative Ack, haven't I?

I guess that your solution is good, and doesn't have any drawbacks,
besides perhaps a tiny little bit of lost performance. So I think
that you should just commit this...


As to the new stuff: I think I postpone large changes, like blob
size in tree view, or links to no merges and first parent 
log/shortlog/history view, or list form of two pipelines we have in 
gitweb, or HTML cleanup, etc. after the v1.5.3 release.

-- 
Jakub Narebski
Poland
