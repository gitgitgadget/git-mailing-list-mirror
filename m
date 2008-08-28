From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Fetch via http and proxy which requires authentication
Date: Thu, 28 Aug 2008 12:13:08 +0200
Message-ID: <4d8e3fd30808280313i70f572cfh9c14fbc2adbf5cea@mail.gmail.com>
References: <4d8e3fd30808272300g58d92dd8pd877d72805bc29c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 12:14:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYeW8-0008Uo-9A
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 12:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbYH1KNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 06:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYH1KNL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 06:13:11 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:63233 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbYH1KNK (ORCPT <rfc822;Git@vger.kernel.org>);
	Thu, 28 Aug 2008 06:13:10 -0400
Received: by wa-out-1112.google.com with SMTP id j37so145366waf.23
        for <Git@vger.kernel.org>; Thu, 28 Aug 2008 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5Q6WZ0+RnA84oobvuXO5L6qJUXuUaBYzjQ6O93bWUKE=;
        b=cKBIsfjelwXItFuWrpk/XdpqqDEOKs6JFjo1BtVFDLf3swOyBYuIwZqpmgAmhrhAgA
         0DGVGHDdS/FhY3xQuSWFd+NTODJecxvCVjBajTRbDcphmufptdPVXEkjC+l4aFQapAzi
         zM2tZhMMLhyFxXfc1C2uRnoYHkpFuH842us44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=syFCEGFGHEKHjZipXLi2GSiMtEVCSqVHv9occoyEnjN4R4U0XkVhT6m1NRnQuQD7GN
         +fN3AcZRq9ZUBOOz0UQsLMPlC76NQl/FcE5eSWSDB97IoB3Q2Z7zRBHyK3LEP01OvzxV
         RKsteOm4kjh5KApMAcq2aWsKdcXH8S0O5Lmk8=
Received: by 10.114.178.13 with SMTP id a13mr1049174waf.182.1219918388955;
        Thu, 28 Aug 2008 03:13:08 -0700 (PDT)
Received: by 10.114.135.2 with HTTP; Thu, 28 Aug 2008 03:13:08 -0700 (PDT)
In-Reply-To: <4d8e3fd30808272300g58d92dd8pd877d72805bc29c0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 28, 2008 at 8:00 AM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
> Hi all,
> i'm looking for a way to use git behind a corporate proxy which
> requires authentication.
> i just need to be able to fetch/pull via http.
> i'm using git on a win xp box.
> Any hint?

Yes, google for  http_proxy ;-)

export http_proxy=http://host:port
git clone http://username:password@giturl


Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
