From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: fix wrong base URL when non-root DirectoryIndex
Date: Fri, 13 Feb 2009 08:36:54 +0100
Message-ID: <cb7bb73a0902122336k1726698ftef85fd4ea0e25085@mail.gmail.com>
References: <1234473072-9901-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902122303.37499.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 08:38:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXscx-00075k-0p
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 08:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbZBMHg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 02:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbZBMHg5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 02:36:57 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:16963 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbZBMHg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 02:36:56 -0500
Received: by ey-out-2122.google.com with SMTP id 25so128058eya.37
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 23:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4cQw4qLpwEA86BB54Cl4nCwwYlL6WWrDz1FpDvrzZVM=;
        b=ez8oxo6tWwMgU0dXBLi5oAxun+19jSP6by6OdBymEAGxVFnlStHq5dp7NIAu1BECDk
         WNN5mhr6qVot2vilQAt/P0xFtznngNSgwDSnR01LkzzL9WFf8tMXDATaoLM7wAb9f2Nk
         owYuz5UIk9XmbyObbMsPSjv32OvMh5spQq7Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LGdb0MxRgnykpz6ZUw/IN4W4+JWDpHXZSEUUPi414hWzxWIhTrpYZB6qf29yT2IOWA
         0mZGUfJUbOBwlPkS7PYbxjrndbq7mD33vY1HY2QF/r4PMBMM1mp+5zNyOu4k2W8KDI0e
         YD0ZjdiGYLCTH30y/TP0vxinZ4jjAFI32kzcY=
Received: by 10.210.127.13 with SMTP id z13mr1396864ebc.92.1234510614602; Thu, 
	12 Feb 2009 23:36:54 -0800 (PST)
In-Reply-To: <200902122303.37499.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109720>

On Thu, Feb 12, 2009 at 11:03 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 12 Feb 2009, Giuseppe Bilotta wrote:
>
>> From: Giuseppe Bilotta <oblomov@rbot.ratry.ru>
>
> Why different email? Was it intended, or was it an accident, and
> authorship of this patch should be to
>
>        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I created this patch on a different computer and forgot to set the
authorship as usual. I'll resend.

> Very good. The only thing I wonder about is if we should add this info
> also to gitweb/README, or if it is good as it is now.

I think there is no need to adjust the README, as in fact this fix is
needed to make sure that the instructions in README are correct even
for subpaths.

> Signoff?

Will add that too.

-- 
Giuseppe "Oblomov" Bilotta
