From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Wed, 17 Sep 2008 23:43:06 +0700
Message-ID: <fcaeb9bf0809170943k43e5b4adre80856d2b78cac99@mail.gmail.com>
References: <48cdde2837b2d_12d73fc6eb2c355c27876@app02.zenbe.com.tmail>
	 <200809152205.15388.jnareb@gmail.com>
	 <fcaeb9bf0809160521o24fd26e4l40f1798228d51712@mail.gmail.com>
	 <200809171107.35826.jnareb@gmail.com>
	 <fcaeb9bf0809170649w418f4af5x3055c04994c694dc@mail.gmail.com>
	 <48D13128.3000509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 18:44:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg08b-0005MX-BB
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 18:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbYIQQnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 12:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbYIQQnK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 12:43:10 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:58002 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbYIQQnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 12:43:09 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1464291eyi.37
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kFYbKPMrhZdVWbawXKUXxFSwpDS6wacYGFwfaq93hT0=;
        b=DT2tcBMgi65dYlJN07QmOdP8/Ar+vL6AHXrE5MOsNgfBty8657zCY92rVL/RcWc50K
         CB7+80M5QzI85Jxmpr7NqtxvUTWARp1HLVPb7UZmmhrRwETNdg2CY42Ib/qNNqlz0qqH
         zJpBjl8yVJRO8XeBKJY6fjb87Ih6FdIGKJXok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lixACq+bYwwkzSHXNZ1sI4AhgTAZ+fmhGCCkklR5mdZDhotbyj3h0KjJfM78TN61EV
         68UfLn//sPRbXmmKIGM5l0ez2qL70B4LKlTba24RTdMeulAALDbSEpAXE10PRya1BvE4
         qUIWHMwuc8tBGQeShJjTnZ47T591zYb66hv2g=
Received: by 10.86.29.8 with SMTP id c8mr1204037fgc.23.1221669786838;
        Wed, 17 Sep 2008 09:43:06 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Wed, 17 Sep 2008 09:43:06 -0700 (PDT)
In-Reply-To: <48D13128.3000509@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96128>

On 9/17/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
> The still un-answered question was: In a full checkout, i.e. in a
>  repository where the narrow/sparse checkout feature has never been used so
>  far, is
>
>    $ git checkout --add-path=foo
>
>  a no-op, or is it equivalent to
>
>    $ git checkout --path=foo

no-op.
-- 
Duy
