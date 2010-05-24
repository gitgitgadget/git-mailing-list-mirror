From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking extra
Date: Mon, 24 May 2010 23:09:57 +0200
Message-ID: <03D36B78-470F-47F8-8553-AF4A1464281F@gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost> <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com> <20100522222746.GA2694@localhost> <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com> <20100523115127.GA20443@localhost> <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com> <20100524094905.GA10811@localhost> <20100524124734.GD3005@dpotapov.dyndns.org> <20100524205612.GA28890@localhost>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon May 24 23:10:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGeuX-0002Ou-PD
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 23:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232Ab0EXVKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 17:10:03 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:62946 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188Ab0EXVKB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 May 2010 17:10:01 -0400
Received: by ewy8 with SMTP id 8so382565ewy.28
        for <git@vger.kernel.org>; Mon, 24 May 2010 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=AWNCDqi/ABiWy4VakvtYGoOdQl3baLcgNuobAgYctBU=;
        b=rB3O31kZhANYQA+XOqEVnOnP7mCWc9AMOv4apnAfQer0Hg5K+W8kVAtVe9PuNU8zfM
         ZTRNBSN4FP4lkq3TA353bLTuUVDksgnuHNbJ5N1XJls1rg8GNAXwZoUTQgL37IsCGQgO
         DUCgSbUxj6RYjA0CL/enLdPd4fofMqiyO9Mf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=CrFNhRRNdL2/lTSQLFYNC2JLrTAn96UjVAwSc54Mau2gCR0iHXgqfsu0P12QGzuRh3
         xyT0g2w7sTF3hxc+QMyylUh7Lowj/YdyUcpIayWTbNs4i6ybgMmO3L5dRA1jbvngYf4v
         K3CvvBREY8eyeXbi2haeumJg8WqoDH98YqRIQ=
Received: by 10.213.29.65 with SMTP id p1mr31111ebc.94.1274735399756;
        Mon, 24 May 2010 14:09:59 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm2080791ewy.13.2010.05.24.14.09.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 14:09:59 -0700 (PDT)
In-Reply-To: <20100524205612.GA28890@localhost>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147650>

On 24. mai 2010, at 22.56, Clemens Buchacher wrote:

> On Mon, May 24, 2010 at 04:47:34PM +0400, Dmitry Potapov wrote:
> 
>> On Mon, May 24, 2010 at 11:49:05AM +0200, Clemens Buchacher wrote:
>> 
>>> With CRLF file in the repository, core.autocrlf=true and
>>> core.eol=lf,
>> 
>> I wonder if this combination should be allowed. core.autocrlf=true
>> always implied that the native EOL is CRLF.
> 
> I just did what the commit message suggested:
> 
>    If core.eol is set explicitly (including setting it to "native"), it
>    will override core.autocrlf so that
> 
>    [core]
>            autocrlf = true
>            eol = lf
> 
>    normalizes all files that look like text, but does not put CRLFs in the
>    working directory.

Right.  While technically true, this is misleading in that it implies that you will get LF line endings on all your files.

I will update the documentation to reflect that core.autocrlf is only useful if you want to work with CRLF line endings in a repository that is not normalized.  I won't be able to do that for a week or so, unfortunately.
-- 
Eyvind
