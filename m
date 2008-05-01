From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 22:09:46 +0530
Message-ID: <2e24e5b90805010939g182de387i59722605ff93d72e@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ittay Dror" <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Thu May 01 18:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrbpq-0003We-8Z
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 18:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759806AbYEAQju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 12:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760949AbYEAQju
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 12:39:50 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:8860 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759741AbYEAQjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 12:39:48 -0400
Received: by ti-out-0910.google.com with SMTP id b6so198836tic.23
        for <git@vger.kernel.org>; Thu, 01 May 2008 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VerRIF3hB7WJF3BEHn+1FQB2WzKmSDfHx+yjXvf2iJY=;
        b=kRi0wfaor61QjMe01YaUQxPc9AXGgJ9zPC44i7bRt6rrddm4+zHIYg27xZ4DZkzAD0BeWRBShXI66tCBewRQiKbyzuQt9LPUB7L3PEh2veN3p78HiuFmwYtUJhBtiBrSa8BBgtdRMwyKtBTb9cc+RYT62saDmMi7QHjZlTjMlEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c5KAzvc8HMOeCGj7V7+rlOk0hGL9+kDPaVcOuTBh7k7CrHqeFxaHj+xzrflhyZpt08eHcn1G3cRI06Zc+/uWpP+IKd1wiwC2sF7NjkGIo16Kgk/jkzbdqvUuMX1SaHEPYA4Z7NccCHj+gbrpgpFU6MFQdY6JNRguJPPVd4SU+Go=
Received: by 10.110.42.13 with SMTP id p13mr207427tip.31.1209659986176;
        Thu, 01 May 2008 09:39:46 -0700 (PDT)
Received: by 10.110.52.10 with HTTP; Thu, 1 May 2008 09:39:46 -0700 (PDT)
In-Reply-To: <4819D98E.1040004@tikalk.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80928>

On Thu, May 1, 2008 at 8:24 PM, Ittay Dror <ittayd@tikalk.com> wrote:
> Also, would anyone like to comment on:
> http://www.markshuttleworth.com/archives/123 (Renaming is the killer app of
> distributed version control <http://www.markshuttleworth.com/archives/123>)?

someone already did, albeit in just discussion form rather than
examples, in a comment on that same page:

http://www.markshuttleworth.com/archives/123#comment-118655
