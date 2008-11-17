From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 17 Nov 2008 14:03:00 +0300
Message-ID: <85647ef50811170303i17049994n356c384693502685@mail.gmail.com>
References: <1226776980-9674-1-git-send-email-tuncer.ayaz@gmail.com>
	 <4ac8254d0811170237o78060cb3k4a64dceaa3a475d0@mail.gmail.com>
	 <7vy6ziy69h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 12:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21u3-0006I2-GR
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 12:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbYKQLDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 06:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbYKQLDF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 06:03:05 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:31503 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbYKQLDD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 06:03:03 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2847670fkq.5
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 03:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hWtHhusJNiEiquq5oG2e2qyvJG4lC2bjMRzWE11fbbg=;
        b=XvRdbVLEp8cZO4PmnkazOmy9Lc3WD6A9j0M+hU4LQg9ZhWjySN2dSKw0fPpYTU4oDr
         +YhTkHpYYG8GWtKiY/dMcuz3GlFyBF/lgyNsxy7Kr2TVrxAGxKM+vMQJekAJbmpXAKTb
         EBg3S1/ChqGSQtMwjwRWIRKrteNLCCTfi07SE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hiDz09NI5PcqDoMxs8JTCKZK7xO9keHKV6gHo4r55vCmVFsBBiO9B9yq8mUFZ9G624
         QglWa8ouFZeqFdw2J2YiZyFVEzAiS8PbvrXYMDlnzwD1dckSAn4hflMVO13mRyeEEmA2
         juc11hbOpT4zEkCH9NgxOt+0SKt3edWrovrEI=
Received: by 10.181.238.16 with SMTP id p16mr946116bkr.213.1226919780224;
        Mon, 17 Nov 2008 03:03:00 -0800 (PST)
Received: by 10.180.230.10 with HTTP; Mon, 17 Nov 2008 03:03:00 -0800 (PST)
In-Reply-To: <7vy6ziy69h.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101219>

On Mon, Nov 17, 2008 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>
>> I think you need to have something like the following applied on top of
>> what's in pu to be able to use "pull -v -v -v" and be able to count the
>> occurrences via parse-options.c. What do you think?
>
I'm just interested why not just optional level argument to verbosity
like --verbose=2 or -v2?

Regards,
Constantine
