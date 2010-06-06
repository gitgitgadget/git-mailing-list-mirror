From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Sun, 6 Jun 2010 18:55:54 +0200
Message-ID: <20100606165554.GB10104@localhost>
References: <20100605110930.GA10526@localhost>
 <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
 <20100605135811.GA14862@localhost>
 <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
 <20100606161805.GA6239@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 06 18:56:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLJ8q-0000YD-Lg
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 18:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab0FFQ4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 12:56:00 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:16212 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837Ab0FFQz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 12:55:59 -0400
Received: by ey-out-2122.google.com with SMTP id 25so169189eya.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=qqfi+RlYpRKn/7Zh/33IeIJS9Z4rpyCixSmqDS6va5c=;
        b=jjGk/D7kOsYoEkcTaHl0WBy5Os6SNaBpqFaSZ7Hy4x6IDuX2b7WiF6w8mrmPFAzz+5
         jFtCFSkofrVlX7G6yHRSGfSL8oUBb5TOUVL8h2Aim+O/P9SsNz66DKn5b2h7c8jwTZIg
         CMyEJFl3wuL9TUoXDbUKSrlJK2hCeDulI9Z8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=iz25+UkdqE6Tqm4DfOjwB60EcY0+eEy5b+P+7w6uLgVxbrHr/uH9lkkaL17x2H7Zue
         uuya6z/N3zF+pUL99ZvGgH8ObW1m/iIeNYmuTkggpVQbZHtO/QN/N++6D4oYmsEd2Si6
         n1TgCFJahMRaHUApyv4HS7ABJyzbwJMrF4AWA=
Received: by 10.213.9.67 with SMTP id k3mr317314ebk.78.1275843358243;
        Sun, 06 Jun 2010 09:55:58 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 16sm2087252ewy.11.2010.06.06.09.55.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 09:55:57 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OLJ8c-0002im-Li; Sun, 06 Jun 2010 18:55:54 +0200
Content-Disposition: inline
In-Reply-To: <20100606161805.GA6239@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148526>

On Sun, Jun 06, 2010 at 12:18:05PM -0400, Jeff King wrote:

> Moreover, the burden for arguing against it is a little higher. It is no
> longer "I think this is a bad idea" but "I think this is a bad idea, and
> it is so bad that it is worth changing behavior that users may have
> become accustomed to".

I argue that people are more likely to be surprised and confused by
this feature rather than being accustomed to it already. I am also
waiting to hear from someone who actively uses this feature.
