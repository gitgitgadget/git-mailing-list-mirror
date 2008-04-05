From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Updating submodules
Date: Sat, 5 Apr 2008 19:01:26 -0400
Message-ID: <32541b130804051601w4f7976cawde47a70e04790511@mail.gmail.com>
References: <810a540e0804051546o250bd3e7mf7a20d8f1cc6dcfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pat Maddox" <pergesu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 01:02:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiHOm-0004NO-7D
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 01:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbYDEXB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 19:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbYDEXB2
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 19:01:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:52288 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbYDEXB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 19:01:28 -0400
Received: by fg-out-1718.google.com with SMTP id l27so708959fgb.17
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wQgy3FGTQuO+FRnGY3Xm7BUwFfjnM/c2Zh6xB6KeDcA=;
        b=n8sqsogOzaVBl1vj9QBlqfG0zxHP8s3sNn1p4PCtSOyuFYnIk8aHDpV/AxBbjTbt53K2lSJg8YAT/BTrCDd8N0A5pHT2iIrsXmWnWwOxZkLezueEP3lJhpHl21DpUfSuRJh3zF8oWYko4/wRiJxhbCxoECl8abPjaWuuIqFw04M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BNXey1EjOwRf23hlklJag0pCpfdAr3Fn5UuSq9Lk7r82TCNNPv1q//5/Jliy3fTjU+KXeIKon5fWqdEZu97ncuGQfia29GpA0BxnU3EV8tPfKiG9haQqn7QXL1vHL2WkeP/WO+oLCz5jI18xZBy3T/bKIhYsBiADLSDeWhgbIZ0=
Received: by 10.82.126.5 with SMTP id y5mr1450030buc.86.1207436486411;
        Sat, 05 Apr 2008 16:01:26 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Sat, 5 Apr 2008 16:01:26 -0700 (PDT)
In-Reply-To: <810a540e0804051546o250bd3e7mf7a20d8f1cc6dcfc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78865>

On 4/5/08, Pat Maddox <pergesu@gmail.com> wrote:
> Do I need to cd into each submodule dir and fetch/rebase?  git
>  submodule update doesn't seem to do anything, though I would assume
>  it's used to update the submodules...

"git submodule update" updates each submodule to the version that was
checked into the supermodule.  It doesn't do anything like fetch,
rebase, or pull.

Avery
