From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: MSVC build broken (on cygwin)
Date: Fri, 2 Oct 2009 10:23:19 +0200
Message-ID: <81b0412b0910020123j13c74497w874e301c38cddec9@mail.gmail.com>
References: <4AC4E2C2.6030509@ramsay1.demon.co.uk> <4AC5B4AE.5070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 10:23:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtdQH-0007KA-I8
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 10:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbZJBIXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 04:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbZJBIXR
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 04:23:17 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:51379 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbZJBIXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 04:23:16 -0400
Received: by fxm27 with SMTP id 27so786486fxm.17
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SKH5/UdxJDf+eaG4ZqAPCU5Rni6V9Th73FR2z6WQyQo=;
        b=qR+PSDfUK2gsx5yjsdxWlsN6OGcwldJrdOpRIvVcvn4Uu14ilDXwHgNkLCWADl6zEk
         jLauNGFjTpEKhWtBaVTPoP7WWyPQJqU+eIXhNBrUum/UTkz7jkkFLOd4ILsktFoOw8sM
         62TrWIV422kbwIrUiY28kNSEUcxqDxDD6+wDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tRGK8AO5OdmrBu4Zn2rZwzO5Cl++zQveZknAn5kD/E2wnXyaPyHgCu22erWIvgN7+o
         8r3qGwgNb5t8BdBPz50W8hP0w4lmF1XRdCk7nzccjodXmKC2jHHG9HXRsZZ/zlNw2Nl+
         nKcDeKpOVFZhoNqNj4ZJpb/Ne7DAIUTXNi5xo=
Received: by 10.204.34.3 with SMTP id j3mr962307bkd.23.1254471799041; Fri, 02 
	Oct 2009 01:23:19 -0700 (PDT)
In-Reply-To: <4AC5B4AE.5070307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129430>

MSVC (all versions) define a compiler specific _MSC_VER, if that's of any use.
