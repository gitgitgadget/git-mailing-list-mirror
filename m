From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 1/1] Make git archive respect core.autocrlf when creating ...
Date: Thu, 18 Sep 2008 22:53:09 +0200
Message-ID: <bd6139dc0809181353o26fb1ac2h7da63cf7da4bff1a@mail.gmail.com>
References: <1a7cc4db062b7df0dae0f27b29dba66c9d917e59.1221767629.git.charles@hashpling.org>
	 <20080918200120.GB8631@hashpling.org> <48D2B831.8080206@op5.se>
	 <20080918202929.GA9948@hashpling.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Charles Bailey" <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 22:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgQW6-0006eq-Vi
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 22:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbYIRUxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 16:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbYIRUxM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 16:53:12 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:7007 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbYIRUxK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 16:53:10 -0400
Received: by mu-out-0910.google.com with SMTP id g7so65743muf.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=55jK8eG5yt+yAFe8BmYViOZMYvRGIBGWby2zcYB6Xvw=;
        b=wgfBUFWRlLBYQF+qQWvI0FQEnDWosMFQ7w6+DNIBELHGFDDG41aAnoSegLMgX+aZ1p
         MQKY3+E6WnqLQuEMUGgFOxmRbSpTJNNQ8uTZdNoOwGpspHD4GiPYwk/Uf6nS+AbMIYwy
         kyyf8HjeaPRVZFXktl8ihdYBnVl1bO44wWEIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=O5Y/O9edjotXVyLHIKlbAeI+M9oK349bF5nBPsxtNN5yPHmA1fBcqERMLPptVVxGwd
         vNSW/mkUfNZvQ99P7hU2eSiV57QDWECfEs4ODdvJpMdU1n7vBfIobSH3kamelE22aCpg
         QnTX0HReAcumk3qVAmMEAiq7QR099yLfKYEtI=
Received: by 10.187.203.4 with SMTP id f4mr574014faq.1.1221771189064;
        Thu, 18 Sep 2008 13:53:09 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Thu, 18 Sep 2008 13:53:09 -0700 (PDT)
In-Reply-To: <20080918202929.GA9948@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96245>

On Thu, Sep 18, 2008 at 22:29, Charles Bailey <charles@hashpling.org> wrote:
> I thought that the patch (a single commit) didn't really warrant a patch
> series - being a one liner - but I made the test 0 of 1 so that people
> could see the test failure first before deciding whether my proposed
> patch was good or not. Sorry for the confusion.

Shouldn't the tests be part of the patch? ;) To prevent it from being
broken again that is.

-- 
Cheers,

Sverre Rabbelier
