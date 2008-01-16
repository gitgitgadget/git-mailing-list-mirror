From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 14:21:45 +0100
Message-ID: <36ca99e90801160521v4851bdf8n72e69d69f6344013@mail.gmail.com>
References: <478D79BD.7060006@talkingspider.com>
	 <alpine.LNX.1.00.0801152305050.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 14:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF8Df-0003dc-Kc
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 14:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbYAPNVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 08:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbYAPNVr
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 08:21:47 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:60216 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbYAPNVq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 08:21:46 -0500
Received: by py-out-1112.google.com with SMTP id u52so382519pyb.10
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 05:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NFn/xGfh94ug6QaFhO1ej6eNSLiqUMKdgbHDRu5gwig=;
        b=IM+okS0jTVyX50n0HTMcOseuWZzSmLrlTNqJRZhGzX9KA53I5tAQp3PBDy2NjfabMMbDXYUlKjecio7kMluwepzqgO6m7C/F5ZE+zvGBoMeDfgTGv7qRDux448c0q8OfxPMutw6YyDbuJPFhvAvY1gcmBecYwVB+LPLv+rzmLR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SGm+rky8HD9JTX3UmFDwpwdEq9x77nrEUycpQtEefSi6gwFPAVuXMVBqHRrlpingtEO6c6W7Vh7TwqfcsBBQl0bNXGhyQfeHx0oZDadnzflM5438eClYdJ5p+W+xc/QX1D+pw5/8UTucMXnmY0zpQdk8f6u6NWThJiSsES03Ig8=
Received: by 10.35.33.5 with SMTP id l5mr867449pyj.30.1200489705268;
        Wed, 16 Jan 2008 05:21:45 -0800 (PST)
Received: by 10.35.37.3 with HTTP; Wed, 16 Jan 2008 05:21:45 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0801152305050.13593@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70665>

On Jan 16, 2008 5:13 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 15 Jan 2008, Mike wrote:
>
> > How do I make the repository dir live somewhere else, the hell away from my
> > code? Thanks
>
> export GIT_DIR=/somewhere-else.git
>
> Note that this only really works if you've only got one repository;
> there's no good way to have the repository information outside of the
> working directory and still have which repository you're using depend on
> which directory you're working in.
This project may solve this problem:

http://swapoff.org/OnDir

Bert

>
>         -Daniel
