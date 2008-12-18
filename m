From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: Announcement: Git Extensions stable (windows shell extensions)
Date: Thu, 18 Dec 2008 09:36:01 +0100
Message-ID: <bd6139dc0812180036m4c70dea4gfe160a5fff1faf65@mail.gmail.com>
References: <1229540813648-1669264.post@n2.nabble.com>
	 <c115fd3c0812171204ve560583w4c76aac0ac08d8ae@mail.gmail.com>
	 <1976ea660812171757s37e8435cxc4d34ade04635b81@mail.gmail.com>
	 <1229587749729-1672012.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 09:37:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDENq-0002NP-Tu
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 09:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbYLRIgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 03:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbYLRIgF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 03:36:05 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:61368 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbYLRIgC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 03:36:02 -0500
Received: by yx-out-2324.google.com with SMTP id 8so124110yxm.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 00:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=lvExh2NNec/fIvutK0jGUlSelxh3D4JpFPK06TzUJ0I=;
        b=JnxK/oy/LHyGc6lMPFqpERIwtCbgNBGfxBvkQ25i0XL25oBSOTzM0bP6pplzEoGdIj
         p690azCWRTskxxMki6v6ucRvM1WVfQ1w0G+BjuLCLbhLZ+QWjNXOTOkUXl4yW0uuHXUa
         a1+RjhHEE+Kz06LAq7tuEkhGCu7hPGLyXfCas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=auTjtX6hVo2Q2u3LpiFrZV4CvlRKKzy9CbJ7MwBfLSDGAoBiu0My2x+DlAnmtSQepQ
         j2nB6zUuMKBpyMCe2w5IlLvhJ5hQaJJ7+PsR5nRBEJfRzy+CEvJDlXCjnaULWwwQzCYU
         8CmSpeJlxeRc5T4JgPkTnAwmLOr+6d+Rz1wNE=
Received: by 10.150.177.20 with SMTP id z20mr1443644ybe.141.1229589361607;
        Thu, 18 Dec 2008 00:36:01 -0800 (PST)
Received: by 10.151.13.13 with HTTP; Thu, 18 Dec 2008 00:36:01 -0800 (PST)
In-Reply-To: <1229587749729-1672012.post@n2.nabble.com>
Content-Disposition: inline
X-Google-Sender-Auth: e6367f0fe593078e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103447>

On Thu, Dec 18, 2008 at 09:09, Henk <henk_westhuis@hotmail.com> wrote:
> If you have problems during development, please ask, I might allready
> encountered some. Especially when you are starting on the features that need
> userinteraction like push/pull/clone/mergetool. These cannot just be run as
> a command and catching the standard output. In the version of GitExtensions
> I published I just run the commands, but I allready have a prototype build
> in c# combined with some c++ that directly calls some (exported) Git
> functions. Just executing git.exe is the fastest way of creating a gui, but
> its not the best way of doiing things.

Perhaps you could consider contributing to libgit2 for this purpose, I
reckon C# has some way to import C libraries, yes?

-- 
Cheers,

Sverre Rabbelier
