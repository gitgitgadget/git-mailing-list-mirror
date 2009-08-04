From: John Tapsell <johnflux@gmail.com>
Subject: Re: Diffing M$-Word
Date: Tue, 4 Aug 2009 20:10:31 +0300
Message-ID: <43d8ce650908041010w1ffa3040m4b783fc0d347818e@mail.gmail.com>
References: <4A70AE1F.7070004@idmcomp.com>
	 <36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com>
	 <4A71F2F1.4060605@idmcomp.com> <20090801111227.GA26029@gmail.com>
	 <4A7841BF.5060308@idmcomp.com> <4A7869BD.5010209@lhanke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dr. Lars Hanke" <lars@lhanke.de>
X-From: git-owner@vger.kernel.org Tue Aug 04 19:10:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYNX6-0007Eg-8T
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 19:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933096AbZHDRKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 13:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933087AbZHDRKb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 13:10:31 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:56447 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933095AbZHDRKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 13:10:30 -0400
Received: by gxk9 with SMTP id 9so7033424gxk.13
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VSCUheHVIAL7H+7rkoep56veK4TP18lBTvsnuO2Eo0c=;
        b=mD1jUuT/YXxUT/V8rImgG8k1jiR/McpiiF+Z1PETiG3KvikqDf+czjB4YkQfxHaWl3
         tDjXoDonPGC1ZPRAzpBf1HuNmfA6+pOq4ACdnmKoIQVqVLd9FiK1Vp/qppzFbs4UIkY0
         kchlvAASGPVsC29FpuzijvsrbANGsfyGVqGq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XxGjbCe7QKoKKLLJCk1AzncP7E6SGQPdbt5tPZ1pKZmuswTnS/cEn5/ZX5xL9O0i1a
         /yX6pf/PVx2qbyM27Pj1NWQ6+Hd1iGLU4iUI1mGlAoDp5AKm1gAuLPhEixDExUuvCn8w
         /RJUT5qq+CHwfyKo4+JXk4LzT3MwErDOVaaMk=
Received: by 10.151.148.16 with SMTP id a16mr13465626ybo.245.1249405831199; 
	Tue, 04 Aug 2009 10:10:31 -0700 (PDT)
In-Reply-To: <4A7869BD.5010209@lhanke.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124797>

2009/8/4 Dr. Lars Hanke <lars@lhanke.de>:
> At work I have to write a lot of reports using M$-Word and found that git is
> capable of managing these in an easy and meaningful way. However, diffing of
> course does not work. I checked the web for solutions, but somehow, I did
> not hit the correct search pattern.

With the openoffice format, .odt, the file is just a zip file that you
can unzip either manually or with a commit hook (and rezip with a
checkout hook).

I think Microsoft's format .docx could do something similar.

That sort of diff will help git do it's job properly (e.g. you can
then see when a particular image has changed etc), but not useful for
a human to view.

I think a way to specify a difftool based on extension would certainly
be useful.  Then distros could provide default useful difftools (for
comparing images, etc)

John
