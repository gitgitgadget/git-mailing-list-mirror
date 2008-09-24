From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Git submodule enhancements
Date: Wed, 24 Sep 2008 11:46:09 +0200
Message-ID: <8c5c35580809240246p1aede11n31cb693d7393b6ee@mail.gmail.com>
References: <200809241100.30758.p_christ@hol.gr>
	 <8c5c35580809240213v5198d2abh489915dc1133c75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "P. Christeas" <p_christ@hol.gr>
X-From: git-owner@vger.kernel.org Wed Sep 24 11:47:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiQxs-00074U-5I
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 11:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbYIXJqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 05:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbYIXJqL
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 05:46:11 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:46614 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbYIXJqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 05:46:09 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1852173waf.23
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=n8ljEhB0rrXEn1tIOESGqrRW3Uw2rG54070XrkKaB4c=;
        b=AusC0ha1ETeK0MC41KmdsG+gQLv6KKaPZJxKrL/2f8Mxm50jf8rt/FYF9aTqcUZDcg
         bBmMoX5qHIgu7ZCMM1224MVdjvretqxOtkqjP1oOOHKYWipe9FqT5qQ4MGFdlHo70jkB
         iOpFoQZvHCMBYDRdHki5yWabSjFCCLC0zNbGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=L+eVHP/LyYnxvIwVsKulOSnkl6JdHoYGZcnK+qdF0tijuinVYt8NTW0Z4gGw/oo5j1
         7YdoYthX7qLZRXV40JLYvPdh0511/MrLb9uSeEZ57V29o+ejLUXIUPLRD7Q4G2HmLcsh
         yvoBtD4XVcZFjxO8X3/LlOQxhkGd8mPzehSaM=
Received: by 10.114.15.1 with SMTP id 1mr7752253wao.184.1222249569242;
        Wed, 24 Sep 2008 02:46:09 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Wed, 24 Sep 2008 02:46:09 -0700 (PDT)
In-Reply-To: <8c5c35580809240213v5198d2abh489915dc1133c75@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96626>

On Wed, Sep 24, 2008 at 11:13 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Wed, Sep 24, 2008 at 10:00 AM, P. Christeas <p_christ@hol.gr> wrote:
> Subject: [PATCH] Git submodule archive: create series of archives, for
> each module

Btw: why doesn't

  $ git submodule foreach 'git archive HEAD > somewhere/$path.tar'

work for you?


--
larsh
