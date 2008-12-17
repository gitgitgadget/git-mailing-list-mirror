From: "Mark Ryden" <markryde@gmail.com>
Subject: Re: white spaces in a patch
Date: Wed, 17 Dec 2008 13:44:01 +0200
Message-ID: <dac45060812170344u368ffd7fx4e86253b4a13ffc7@mail.gmail.com>
References: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com>
	 <7vej07p84i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 12:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCuqH-00036f-KP
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 12:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbYLQLoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 06:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbYLQLoF
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 06:44:05 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:27084 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbYLQLoC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 06:44:02 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2945550rnd.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 03:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QnPIoRqP/DNbSdDFXnujhDQ4iOpKhSjjCM+V9qWRWCM=;
        b=tssVtkNoW8vttOi4UlSJ6tSMp6FPhTvrS0zSgxhQ31kE6tUy9B3sH3BdfUhjwiKEci
         GUQaK+jpyGS5PluCpDv/9wUQoRUT06wrwGx2kltpMM6DBKhwyCzryFFsQ1BfVcW1T3Qn
         3Qxf5nVlpbvbooLHLU3/4jcwScsPhkhINLaxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Vfb8erK2/rW6x3CBeTMusPtwGtDmFsDyrZ9ZDrAKDjmcGW0dcRP8zvJvl8Mxz9DCLV
         k4zGkC3E1eW/UgTNUm4dGOJz9qgv5uVRTO24tc+byZI2yyc/QykradpizrSt959GJ86z
         maBtUJBA84Rj5wInc3KrFedgOpi+xVDHU3yVo=
Received: by 10.90.105.6 with SMTP id d6mr299011agc.22.1229514241539;
        Wed, 17 Dec 2008 03:44:01 -0800 (PST)
Received: by 10.90.26.11 with HTTP; Wed, 17 Dec 2008 03:44:01 -0800 (PST)
In-Reply-To: <7vej07p84i.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103332>

Hello,

I tried:
git apply patch1.txt
patch1.txt:34: trailing whitespace.
				
patch1.txt:53: trailing whitespace.

And
"git diff"  show differences but **does not**
highlight anything.
I tried in tchs and in Bash.

Any ideas ? does "git diff" does  highlight for anyone ?

Rgs,
Mark


On Wed, Dec 17, 2008 at 9:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Mark Ryden" <markryde@gmail.com> writes:
>
>> 1) Is there a way to check whether there are white spaces in this
>> file without running git-apply?
>
> "sed -n -e '/^+.*[      ]$/p' patch.txt" perhaps?
>
>> 2) Is there a way to get some messages about that there are white spaces
>> when creating a git patch?
>
> Doesn't "git diff" highlight whitespace errors?  That way, you can catch
> errors  before you make a commit that has them.
>
