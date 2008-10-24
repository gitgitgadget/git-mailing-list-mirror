From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit (v2): the git-based single file content tracker
Date: Fri, 24 Oct 2008 13:01:48 +0200
Message-ID: <cb7bb73a0810240401q57e40b9dj46c35f90681cfa3d@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <gdqbta$rhe$1@ger.gmane.org>
	 <m34p32i83f.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 13:03:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtKRb-0007s7-Hs
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 13:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbYJXLBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 07:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbYJXLBu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 07:01:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:42732 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYJXLBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 07:01:49 -0400
Received: by wx-out-0506.google.com with SMTP id h27so362381wxd.4
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 04:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eD709qS8zJeKKenx6QmlBsnG6GkvSblb2oEY8WwTqzs=;
        b=iIAKCv4WQpvcj06zpxMYz4XVmu1CiY8hafF02BLysTkV3zirPoKoKP0Vzqy4BQ0jso
         f32wQIzneIbm7tQh28bJyTiQdg+G3Haow73iDJkQWJL/2Isv7Ad3JERc5exWLbBgQVea
         ehtRluXQX9CbU7fuDXlqpDaCdyl2Pwaq0aBCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tyEX8ySXcikI3CPNeC3tbIZ0OiTWRA5rJYLJQY6o1qP5DNpN6iuxDJKJmNHmALUYTk
         xw4M4gcq6f+urjvgV2KQVzlSPTkFw4kxMj8m4dwcIfYJVa1RRW8jSD51DZBeCLP1EvLz
         fa47ff67xWTYPh07om0IMokNLnjBm6ogfQylY=
Received: by 10.151.14.5 with SMTP id r5mr5647521ybi.122.1224846108570;
        Fri, 24 Oct 2008 04:01:48 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Fri, 24 Oct 2008 04:01:48 -0700 (PDT)
In-Reply-To: <m34p32i83f.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 24, 2008 at 12:43 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> The reworked Zit ( git://git.oblomov.eu/zit ) works by creating
>> .file.git/ to track file's history. .file.git/info/excludes is
>> initialized to the very strong '*' pattern to ensure that things such
>> as git status etc only consider the actually tracked file.
> [...]
>
> Could you add it to Git Wiki page:
>  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
>
> I think that the project is interesting enough to be added there
> even if it is still in beta, or even alpha, stage.

Ah, good idea. Done, in Version Control Interface layers section

-- 
Giuseppe "Oblomov" Bilotta
