From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] teach the new "@{-1} syntax to "git branch"
Date: Sat, 14 Feb 2009 02:11:41 -0500
Message-ID: <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 08:13:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYEi7-0002yd-5N
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 08:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbZBNHLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 02:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbZBNHLn
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 02:11:43 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:11709 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbZBNHLm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 02:11:42 -0500
Received: by rv-out-0506.google.com with SMTP id g37so947071rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 23:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n52DtIrSaOfi/s9YyXcQ4R1Gnc9X4sAnDSy8wM+SZko=;
        b=XuqM06ICTS83hTxfkuMj8SfUTpGeBIFSHiENegooX/35S9tUPLSbCohrf83wEG1x5N
         FckYRST4Qa470tkmOfxPJJERNy3CWPpx1/sBvTwvyHxBLE30WZtSDLMhNwmHafZROZez
         QPYyV5zhyo9vytJuUee/vPXH3GVPUyO8cRcMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QvZL/Ek5+roOwJBZRpYnU6m+B8PYet3RYk29haq7G/haOHsJP8yDu1tocCxAHIkvuD
         C1sxJf2hAwJj6mJ464Xdo8wWofGMci7C+sfEaPcpKSNPZdUA8UpUakHT4OPVBMv+ddKD
         ++SOZUKGta7wQgfUuukz/kNvP4TXxTa0OvNiM=
Received: by 10.141.62.9 with SMTP id p9mr1531784rvk.218.1234595501843; Fri, 
	13 Feb 2009 23:11:41 -0800 (PST)
In-Reply-To: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109836>

On Sat, Feb 14, 2009 at 2:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This teaches the new "@{-1} syntax to refer to the previous branch to "git
> branch".  After looking at somebody's faulty patch series on a topic
> branch too long, if you decide it is not worth merging, you can just say:
>
>    $ git checkout master
>    $ git branch -D @{-1}
>
> to get rid of it without having to type the name of the topic you now hate
> so much for wasting a lot of your time.

I hope I'm not the person who motivated this new syntax. :-)

j.
