From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] apply: Recognize epoch timestamps with : in the timezone
Date: Wed, 29 Sep 2010 16:49:34 -0500
Message-ID: <AANLkTikUoyiWmSkp5sdi1oA2k2fBweqeUj_oBZBEEP3T@mail.gmail.com>
References: <alpine.DEB.2.00.1009291644440.15192@dr-wily.mit.edu>
	<20100929214107.GA4485@capella.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 23:49:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P14Wz-0003lL-8K
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 23:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab0I2Vtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 17:49:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51980 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab0I2Vtf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 17:49:35 -0400
Received: by iwn5 with SMTP id 5so1526082iwn.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=6LCDy450Svr+7p63G6o6ygrsoe+Of8cSE+3USsWb46Q=;
        b=uEGH66ln/puJUvQT7oUmJwmSn8k74qhaggTo7ygBjRknnq0mNhjux/WsgkfdvA6tUz
         cdyGWZwIoNjaHTkAsxiNO4VGrHEOoouxa1ifefYNEi37ulHOsH6TPcTxKSOoWXzFczqf
         acSh7bs4z3vO9aG7SNb/y8WJfw8xi6Rg6BXzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hTo0AD1FVX7E4doWpB3sU7F198wa8loK/ic6KuNYBQgPisJ6f7Gy1P9q6oVIFfk8kE
         SApB+ymyRA1LTtszCxXpxL9YnJHnbLG4MKJgdDmp5Jc0YIT1TzGM52Ax/v/jYLxk3y/r
         EOFQHP4RU953xqe/CoBqeqGOPPpUkYlaaZN84=
Received: by 10.231.146.134 with SMTP id h6mr2434988ibv.170.1285796974588;
 Wed, 29 Sep 2010 14:49:34 -0700 (PDT)
Received: by 10.231.11.65 with HTTP; Wed, 29 Sep 2010 14:49:34 -0700 (PDT)
In-Reply-To: <20100929214107.GA4485@capella.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157611>

Jonathan Nieder wrote:

> Some patches have a timezone formatted like '-08:00' instead of
> '-0800' in their ---/+++ lines (e.g. http://lwn.net/Articles/131729/).
> Take this into account when searching for the start of the timezone

s/timezone/timestamp/

> (which is the end of the filename).

Sorry for the noise.
