From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git am with MIME
Date: Thu, 21 Aug 2008 09:31:31 +0200
Message-ID: <81b0412b0808210031l1caec384x8e085acafd413784@mail.gmail.com>
References: <48AAEBB6.9070306@gmail.com>
	 <20080819170731.GA2424@coredump.intra.peff.net>
	 <20080820195734.GE16626@blimp.local>
	 <loom.20080821T033231-805@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 09:32:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW4et-0000Vz-8Y
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 09:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbYHUHbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 03:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755144AbYHUHbe
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 03:31:34 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:34232 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbYHUHbc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 03:31:32 -0400
Received: by wa-out-1112.google.com with SMTP id j37so211323waf.23
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 00:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VoGcHIwkSZ7NyeX4tSSN2xhgW8h94zUMVuk4BgxFJ9c=;
        b=oWGqU3NmZr6xcCKDSrzaeYD7sPdft9+b9VF/RbOjAcNNLEfgSa/4hmcq1VDXTTPUOk
         4obtnZmpGVH77ZaXzEhJBPh0NUuo/785Ysl5R4kf3Mvy8B4y0Cy+IrVBUnNuQkbJa/Oe
         8EFX++lCfrpZL0T3oNz7IdRbjdZtit9WziYu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dACKbGbXoJU2cac/4h8J6UQyyaTrE9a7JoD3FPR8p0SGfz1Yig9iTTNcvgUZPap9K3
         w2GdoVaWGtbQTfPCcFnMsVjUhFWAosuyeaKzaL/fakAulaaorVkzMAZg0C/hz6LrBR4G
         XQAv7s+ZBG43eCDrRLjG/+Hj+pZGHPMnPKXHo=
Received: by 10.114.161.11 with SMTP id j11mr1089517wae.105.1219303891754;
        Thu, 21 Aug 2008 00:31:31 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Thu, 21 Aug 2008 00:31:31 -0700 (PDT)
In-Reply-To: <loom.20080821T033231-805@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93116>

2008/8/21 Eric Raible <raible@gmail.com>:
> Alex Riesen <raa.lkml <at> gmail.com> writes:
>> (Some people'll kill me for that :)
>
> And why shouldn't they when:
>
>        strbuf_remove(&f, at - f.buf, el + (at[el] != 0));
>
> is infinitely better in every possible way? ;)

Because that's just as ugly as "?:", brackets and all
