From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v4] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 16:03:41 +0200
Message-ID: <cb7bb73a0808220703k46c747d3u2e5970da5fafa2be@mail.gmail.com>
References: <200808221256.21805.jnareb@gmail.com>
	 <200808221501.54908.jnareb@gmail.com>
	 <cb7bb73a0808220620m10245693pabe49993e91cff3d@mail.gmail.com>
	 <200808221542.13227.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 16:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWXG4-0007s1-H1
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 16:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbYHVODs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 10:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbYHVODr
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 10:03:47 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:45303 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYHVODr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 10:03:47 -0400
Received: by gxk9 with SMTP id 9so1148898gxk.13
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ddFBB3ynQVw+4IZsqVFgNLbK7hXa456oTiBTIxQoc/k=;
        b=FrwuVZ74KPk2T2DNSbF0WuU96eDzxcbNP4C+Fup8bE5L3IycDyzZIR5aqKVD/D3ymo
         4DQu5Lhyv6aZZ1qNwv2JOy0cqAQQMqEmX/U2s6ABJZhfoaXqIOmUhFZmRMNitjxWMdxy
         GCkCFgCZC4xghJHdMX9M7Wec92ZBfVEjj7kaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=k768om47eAL93vhf0b9PdMU+cy+0oE5lRummmpEA6X3W6GabAKDM2vGtwYv306/eQa
         lvVOHs2yUwF2DcVuVvsh6cgZSx5DZ8nJq+aH2x5pEvgxMVuTixttuTGpEV85RbakRwUH
         7DabO75uqcVrYxNsUIZU6KleZ3XqjF3MhxYHI=
Received: by 10.150.133.18 with SMTP id g18mr1884180ybd.137.1219413826154;
        Fri, 22 Aug 2008 07:03:46 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Fri, 22 Aug 2008 07:03:41 -0700 (PDT)
In-Reply-To: <200808221542.13227.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93300>

On Fri, Aug 22, 2008 at 3:42 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> This might be good idea, but for the two following reasons: a) it makes
> code more complicated, b) it is inconsistent, because ref type would
> be saved in refname then stripped in format_ref_marker, while indirection
> would be saved in git_get_references; consistent would be
> ["tags", "v1.5.0", 1].

Ah, I'll keep that in mind for future enhancements.

> Thanks for your work on improving gitweb.

My pleasure, I actually have a long list of patches in store and I
hope to be able to push them through for the next release :)


-- 
Giuseppe "Oblomov" Bilotta
