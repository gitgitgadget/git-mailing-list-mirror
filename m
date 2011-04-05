From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Re* git commit fails under some circumstances
Date: Tue, 05 Apr 2011 09:23:24 +0100
Message-ID: <1301991804.2320.13.camel@wpalmer.simply-domain>
References: <AANLkTikHRM10p9e8XCzuiih7cYtQRG7Az2Qn5qtPzhZJ@mail.gmail.com>
	 <7vhbagh3aw.fsf@alter.siamese.dyndns.org>
	 <1301991295.2320.11.camel@wpalmer.simply-domain>
	 <7v8vvp5cxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Laszlo Papp <djszapi@archlinux.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 10:23:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q71Y1-0005co-DW
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 10:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab1DEIXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 04:23:31 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34519 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab1DEIXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 04:23:30 -0400
Received: by wwa36 with SMTP id 36so161337wwa.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=DmrE/fd0CzlLIePCZkn/Xa8FQixaDEw5yYACsblh2Cg=;
        b=kmB2SPOlhmFRmPxbKlSQyRyZvssNiZimCw7h4Mp3CsFKOCaTglsKkTJRN7UcdW1bIK
         4Q9D/PYxotSRM7gryxTrArEafIEU2duFfBiaeS8bowJAsF/yjLSmzMtReUN6A4cY702w
         MJkTVHqCnMIA67baxA9LT9LUXl4eORapi4H1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=eMJ8j09/o1nEJ5x+9Ox7l7tM8Lgy6Idd7VfM3v9XkNWuVQTasY3HolgGaoFD2KJtpG
         OH9GwLRqQDJe5HutSpsFvfVxB/wrpyoCDvgnmBwe4HFaFvy1AxPea7EXCDN5kili6wB9
         6pX7wt7a+LBJ+C5kk94tM/JKYqldyO3pcyQL0=
Received: by 10.227.199.68 with SMTP id er4mr8184140wbb.47.1301991808649;
        Tue, 05 Apr 2011 01:23:28 -0700 (PDT)
Received: from [192.168.2.128] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id y12sm3391349wby.8.2011.04.05.01.23.26
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 01:23:27 -0700 (PDT)
In-Reply-To: <7v8vvp5cxn.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170877>

On Tue, 2011-04-05 at 01:18 -0700, Junio C Hamano wrote:
> Will Palmer <wmpalmer@gmail.com> writes:
> 
> > The alternative, "git add everything else, then use git diff --cached" I
> > believe is unsuitable
> 
> It sounds as if you are looking for "git diff HEAD" to me...
> 

Quite possible another case of "the mindset of someone used to using the
index, and so always wanting to reference it, clashing with the mindset
of someone who never uses the index, and so doesn't even consider it".
Quite possible this is indeed the solution that was needed.
