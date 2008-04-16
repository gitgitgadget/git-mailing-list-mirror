From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Wed, 16 Apr 2008 17:02:20 -0400
Message-ID: <32541b130804161402u736f4c02wa1c2b977d64e98ec@mail.gmail.com>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
	 <20080416200107.GG3133@dpotapov.dyndns.org>
	 <46a038f90804161356o7518ec72j3bfb4e9fe4e48852@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Nigel Magnay" <nigel.magnay@gmail.com>, git <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 23:15:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmEt2-00042d-HS
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 23:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761801AbYDPVI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 17:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760896AbYDPVI7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 17:08:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:6897 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758080AbYDPVI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 17:08:58 -0400
Received: by nf-out-0910.google.com with SMTP id g13so815230nfb.21
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 14:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=03Sq7FCf3k8eZjezpDAmFlX1tIxeAbuij+A/iPErGCk=;
        b=rtAvYEng94DVzokW5nzUQvJZuiyzv/MBss4ejy1bjH2uS4tJS8ST466qSSWmzNRbYHrslUGaAdZgma1zd2gFQ8/iD+pZRCwISE+Maw5xgC9w1+5870r68HmjTywocFSe9bsBK2yqiyb7ssJzeCi4e5/U8HKFdBHmwF40ZUbHLAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jlDQYxHqM/SBCNGkABmDwqeqtLBdmaReGSWmNMAGiIUiufZkbn6M1X2mgcA2It4XpZtA4KD/DOprC2xnVxGyfuku/n57HF4bFl6aazky6ooJq9ZjkjI9DwVHfg6S16IAbbFB9VbMN0hQsigLm29r5Rs/rOj4lqcfOL1Bd1GCR3s=
Received: by 10.82.127.15 with SMTP id z15mr751496buc.41.1208379740610;
        Wed, 16 Apr 2008 14:02:20 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 16 Apr 2008 14:02:20 -0700 (PDT)
In-Reply-To: <46a038f90804161356o7518ec72j3bfb4e9fe4e48852@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79753>

On 4/16/08, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On Wed, Apr 16, 2008 at 3:01 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> >  If you do not want problems, you should use core.autocrlf=true
> >  on Windows.
>
> If you are making the above statements in generally about git, I
>  disagree. I have used msysgit a lot with unix-newlines projects, and
>  it works fantastic. I am careful to work with newline-smart editors
>  but any half-decent editor will cope. The general hint is: avoid any
>  content-mangling options if possible, and git will do the right thing.

Various Windows IDEs (notably Delphi... and notepad :)) get confused
by non-CRLF files and either do random things to the file, fail to
compile, or "helpfully" change all the line endings back to CRLF.  I
agree that any program that does any such thing is braindead, but
unfortunately, some people are stuck with such programs.

Avery
