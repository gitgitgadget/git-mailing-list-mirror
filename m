From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Shrink the git binary a bit by avoiding unnecessary inline functions
Date: Mon, 23 Jun 2008 07:26:04 +0200
Message-ID: <46d6db660806222226k73a2e66kd83c5d28b957c61d@mail.gmail.com>
References: <alpine.LFD.1.10.0806221159140.2926@woody.linux-foundation.org>
	 <46d6db660806221432m6a6e2f3egf78faa1510f8d643@mail.gmail.com>
	 <46d6db660806221801j7207e6b0sdf91c2243fad5349@mail.gmail.com>
	 <alpine.LFD.1.10.0806222150180.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 07:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAeaV-0007rE-0A
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 07:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbYFWF0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 01:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbYFWF0H
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 01:26:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:12423 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbYFWF0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 01:26:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6869652rvb.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 22:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UYYH/UbDfxkJtlgQptWpr8K/5/1/Gg3sZhg99lFa3QM=;
        b=OxGpGj+EahAW0Ayzuqnizoxb/SyHnNyi0kr/nApk5jvzKZ5paNfYHqrhJMiekAZbnH
         0/xd6RyvWmjmrmb0RloqX1h5SKQvrp68dVguQ1HCFqtL29Gvt7EV0J1RoXzfLYsdpXvQ
         VACvwM8GPoJR+SzU/QbRBF3yP1sshHxqhNABw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mTBNFLHnlBlH73RUkTvVMg6uwGcfj+YdPD6jLO2uh/yfJ1z0wcQDbiRL+7LquIIzT+
         VieaCZ+Np17H5N9eK473SjLyh3dLB66GxZNRP5uVfM7QtwqiD2O64YBsEErrm7AllbOo
         fmcx06fOU0y52NQfCfFTZ3NLYvSn42rA11seU=
Received: by 10.141.115.6 with SMTP id s6mr12082168rvm.51.1214198764296;
        Sun, 22 Jun 2008 22:26:04 -0700 (PDT)
Received: by 10.115.16.17 with HTTP; Sun, 22 Jun 2008 22:26:04 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806222150180.2926@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85835>

On Mon, Jun 23, 2008 at 6:54 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> gcc version 4.3.0 20080428 (Red Hat 4.3.0-8) (GCC)
>
> Also notice that this is x86-64, maybe you're 32-bit?

it is an AMD 64, but the ubuntu and detaolb are indeed 32 bits distros.

>
> You also have much smaller size difference (616606 -> 591554 is just over
> 16kB), but if my version of gcc bloats things up more, then I'm not
> surprised that the difference is bigger too.
>

I guess I should compare results between compiler versions too...

Thanks for the explainations.

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
