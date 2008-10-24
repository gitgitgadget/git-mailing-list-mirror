From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 22:13:31 +0200
Message-ID: <cb7bb73a0810241313o341febccgbea1cd59b25b9cc4@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch>
	 <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>
	 <m38wsei8ne.fsf@localhost.localdomain>
	 <7vabct3l1e.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0810241159290.27333@asgard.lang.hm>
	 <cb7bb73a0810241242y7467f6fexcca4b7cd768e7992@mail.gmail.com>
	 <alpine.DEB.1.10.0810241244170.27333@asgard.lang.hm>
	 <cb7bb73a0810241251w4c2486a0x4684a25b364ebbbb@mail.gmail.com>
	 <alpine.DEB.1.10.0810241254330.27333@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Oct 24 22:14:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtT3Y-0007Ho-PY
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 22:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbYJXUNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 16:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbYJXUNg
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 16:13:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:2070 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbYJXUNf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 16:13:35 -0400
Received: by wx-out-0506.google.com with SMTP id h27so501506wxd.4
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3xH0U2IqAgHfZy/kKQkl6QsLXwU9BWpH/++ggsD60q8=;
        b=E4n7eiv6I8mPNnQIOJY8uLzGAkJaJ7BQuwQyslNdPVVVmHsvU56zATpDYR/bGTUoCJ
         /WsnkfUArYvb1FrQYcN6VQmSlMdVSHEP2AFhvOVEEDtoGo3r6GEtW5Ci0UIWQcQG+5W2
         gDXFuOWeGKWWmtO2jbAtaTXo6qL47EqrTbtjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZdtDXGIyUDfSTDlI3UVxz7miwHt0du0vbgZzolZlYI8O4Ugg41LXIvdvR8ei2x28hu
         /ckS1A5H+CuqI4t6oEtGRwYviQ2QCReuT3zYZn2INe9u4JPf5CJidBdRU2qKSTnGyiz5
         tsQuu4Wz18R2eYEKrk4AomRpL3/PA+Tnn6kHE=
Received: by 10.150.219.16 with SMTP id r16mr6470346ybg.150.1224879211561;
        Fri, 24 Oct 2008 13:13:31 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Fri, 24 Oct 2008 13:13:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0810241254330.27333@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99062>

On Fri, Oct 24, 2008 at 9:54 PM,  <david@lang.hm> wrote:
> On Fri, 24 Oct 2008, Giuseppe Bilotta wrote:
>> Zit does
>>                echo "*" > $GIT_DIR/info/exclude
>> and yes it sucks to use a whole block for a file that only contains
>> one character. Suggestions welcome.
>
> can this be configured in the config file?

Yes, the file pointed at by the config key core.excludesfile is read
too, so we could have it point at $GIT_DIR/zitexclude, which would
allow us to spare a block. The most space saving would be achieved by
a core.excludepattern or similar key, which would allow us to get rid
of the exclude file altogether.

-- 
Giuseppe "Oblomov" Bilotta
