From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Suggestions to make git easier to understand
Date: Thu, 11 Aug 2011 18:08:08 -0500
Message-ID: <20110811230807.GA5608@elie.gateway.2wire.net>
References: <CAGK7Mr5T4-DBK7rXeH-1=SNu5HBOEkLBW=CAh5Lhf7oHKjFAiw@mail.gmail.com>
 <20110811221627.GA32005@elie.gateway.2wire.net>
 <7vmxffpo8e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>, git@vger.kernel.org,
	Rafael Magana <raf.magana@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 01:09:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QreNN-0000wt-9X
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 01:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654Ab1HKXIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 19:08:22 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:34217 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab1HKXIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 19:08:21 -0400
Received: by iye16 with SMTP id 16so324354iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 16:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=578/TfANLD1fKeh2xPS+/ZqWnoWpjIjRpYT/1PG+xd0=;
        b=du/JWyLg8nrex+TWRTop9MimwQ7prajf1wIG3wPg85bU3Osx8PQbEdsZ2+67TZ/5yF
         WieTXOZfeQb/qF3nrv8dDm09Sb/mgD6YCzGNprXL7QG1NYYXF7DJ01IUm01dO6G99Rai
         Cb79wS3EHpueQypSfy7Svm6YMVdbFm6jtikZk=
Received: by 10.42.145.69 with SMTP id e5mr166074icv.432.1313104101187;
        Thu, 11 Aug 2011 16:08:21 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-30.dsl.chcgil.sbcglobal.net [68.255.106.30])
        by mx.google.com with ESMTPS id t14sm1821428ibj.47.2011.08.11.16.08.18
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 16:08:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmxffpo8e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179151>

Junio C Hamano wrote:

> I do not think "ls-files --contents" makes things any better, though.
> Until a new user encounters a conflicted state, it might look like that
> the primary point of "ls-files -s" is to show the object names, but it
> also is important that it shows the stage numbers.

Yes, sloppy of me.  I should have said "the intent of these
suggestions seems reasonable, and I believe that with minimal tweaking
they would all lead to good things".

In the case of "ls-files -s", I suspect what would be most useful is
a new porcelain "git ls --merge", building on Duy's work[*].

[*] http://thread.gmane.org/gmane.comp.version-control.git/166405/focus=166415
