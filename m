From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH] "git diff <tree>{3,}": do not reverse order of arguments
Date: Sat, 11 Oct 2008 14:53:12 +0200
Message-ID: <237967ef0810110553r662df370ud1ec34de402bfe1c@mail.gmail.com>
References: <1223690175.2828.26.camel@mattlaptop2.local>
	 <7vwsgfjrp6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Matt McCutchen" <matt@mattmccutchen.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 14:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kodza-00029N-ML
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 14:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbYJKMxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 08:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbYJKMxO
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 08:53:14 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:3548 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbYJKMxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 08:53:14 -0400
Received: by ey-out-2122.google.com with SMTP id 6so367691eyi.37
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oERuV4AwBeti6qHhoHGWw9qw9TNn71a7snhzRMSlKWQ=;
        b=pT6F4Zb7Xu0Iu1bdtZXjcieDeTCixHCQx7y6QvC7Qbv5N34hndEBHFG1kYkJGAPa4d
         kBq1F22okuIWlBoXhmjJq4uSKt9axv/0FV0ge7apdpawM9YewnBtmr3n9CUtR8IH1qj9
         KKgNb27CbRjIQBcHtlt4u0GOibUAeiryvVjfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nghydJJPuvKnA3z9P7O4J+D71a6PHX5SLsE+4hkQQ0akEOKRUIJKpGTQVQcSROUWmb
         iG2ebSm65zEhM8OOlBO4UvTelIX/H4xWrPv2yUGsLaSdqZvzizr7SdwS9RvYYxh9j+Kh
         FD44ifeQhk34aP8wUkzpjhTm1hpYZrEIX7b6o=
Received: by 10.210.139.15 with SMTP id m15mr2003753ebd.190.1223729592192;
        Sat, 11 Oct 2008 05:53:12 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Sat, 11 Oct 2008 05:53:12 -0700 (PDT)
In-Reply-To: <7vwsgfjrp6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97978>

2008/10/11 Junio C Hamano <gitster@pobox.com>:
> Perhaps the thinko was caused by discrepancy between the way internal
> revision parser handles A..B and the way git-rev-parse parses it.  While
> the internal revision parser parses it into "A ^B", rev-parse gives them
> in reverse order, i.e. "B ^A" (which is not going to change).  In any
> case, thanks for spotting this.

Ehm, do you mean the internal parses it into "A ^B" and rev-parse gives "^B A"?

-- 
Mikael Magnusson
