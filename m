From: "Klas Lindberg" <klas.lindberg@gmail.com>
Subject: Re: git-fetch remote tag to local branch fails
Date: Tue, 24 Jun 2008 17:36:56 +0200
Message-ID: <33f4f4d70806240836q7522192eybdfe7983293c4c6a@mail.gmail.com>
References: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>
	 <8aa486160806240638o221b01d2i2f46cc8f0f3760a3@mail.gmail.com>
	 <33f4f4d70806240701o1c00cef2g688a188970964b0f@mail.gmail.com>
	 <8aa486160806240727r6fc6de6doec8300700293a3a7@mail.gmail.com>
	 <33f4f4d70806240831q14caacddp66645e1bcfb6d14b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 17:37:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBAaj-0005mc-Fa
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 17:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbYFXPhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 11:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755766AbYFXPhA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 11:37:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:12694 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbYFXPg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 11:36:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1197514fgg.17
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=k+wFU+q267K9dtBnABC7qBWJY0l154eFQ5VOsUTOUfg=;
        b=OgOcxVaUFRszLC5PrQIejAi85ncMEIkovebtjF3U2fx6y2114kmMZVPsPdvKklyspf
         6BJtEmyAFt7FbH/b/9NXd9+1kgW5VMo4v+03AMAgwe05H5bM+BKSCBrJqoDQpkS/MK0g
         Du7YHMDWO0UfK2CAKkNU4OXvu9Xc+ILJWXbik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kjrjrvxzkBBQg4gTIYbUQuko6j2puXjRXPBs/9hJhQJG5/Jhc0vtImMDEDE1vPmb3J
         Cr/SXz6eJROg9q/8ChMkmtBVPU7QbrzoowpMxAWs9mkyZTd2BYz9iv9KpO5P10kWnA7X
         iQS5H4EBZh45P4ZWqGoIe4Q0KS+itU3j61q5M=
Received: by 10.86.73.7 with SMTP id v7mr9105503fga.37.1214321816339;
        Tue, 24 Jun 2008 08:36:56 -0700 (PDT)
Received: by 10.86.68.16 with HTTP; Tue, 24 Jun 2008 08:36:56 -0700 (PDT)
In-Reply-To: <33f4f4d70806240831q14caacddp66645e1bcfb6d14b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86075>

> I'm not sure what you mean. I asked it to update local branch "b"
> against remote tag "foo_tag" and it did just that. I find it
> inconsistent that pull can do this, but fetch can't.

I'm sorry. That was plain wrong. It doesn't update the branch from the
remote tag when I pull.

Oh well...
