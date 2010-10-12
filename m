From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Automating svn<->git gateway
Date: Tue, 12 Oct 2010 12:54:54 -0700 (PDT)
Message-ID: <m3eibv6vah.fsf@localhost.localdomain>
References: <20101011193007.GA30870@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Oct 12 21:55:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5kwH-0008Kf-8i
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 21:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821Ab0JLTzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 15:55:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51827 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251Ab0JLTzA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 15:55:00 -0400
Received: by bwz15 with SMTP id 15so2689063bwz.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=LsmnRDvK428dwgaRgJXfxteJa7t1rTA/xardBAb3x2A=;
        b=L7YW6g+H+NVqikAD6SDyeKKIO0rzOmnYwEl83omOl71KdZLMAbKQWwtR9VW/FBAuMN
         BJzMrlUFVz5/uuHvrm8/J8NUtGAYy93XoRO1jwChf8uzKkNoWHko4CtaUZjXQtvkUVut
         1Pez9F8IqoJUipRo6PLMZ+6vxmZ73/XaZwJw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HMGhC4waOB19eBD5b7tNj44j2VkoTOhBwrrq79IRg27JY5nXvaA5CzbKg7jVrrjzdW
         ghAqOhpMRVxff0MkJv7QZpVthLcAxtLowadn3OH34tOJ4VSOXzSpOOOrKHFfLNZPnPd7
         lyMr5x2PigpeK9NGuwOrTolP+KKWFV2zyt+l8=
Received: by 10.204.68.136 with SMTP id v8mr6340642bki.88.1286913295460;
        Tue, 12 Oct 2010 12:54:55 -0700 (PDT)
Received: from localhost.localdomain (abve214.neoplus.adsl.tpnet.pl [83.8.202.214])
        by mx.google.com with ESMTPS id d27sm7376778bku.22.2010.10.12.12.54.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 12:54:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9CJtM6h003735;
	Tue, 12 Oct 2010 21:55:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9CJt2Xw003727;
	Tue, 12 Oct 2010 21:55:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101011193007.GA30870@efreet.light.src>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158874>

Jan Hudec <bulb@ucw.cz> writes:

> I want to set up a gateway between subversion and git, which would keep the
> master synchonized with subversion trunk, both ways, and allow working with
> any additional branches independent of subversion. For users it should behave
> as any other shared git repository accessed by push and pull. And it needs to
> be automatic.
> 
> Did anybody try to set up something like this?

It is a pity that "Native SVN support in git" project at Google Summer of
Code 2010 (https://git.wiki.kernel.org/index.php/SoC2010Projects) turned
out to be too much for one summer; though people are working on it.  It
would be perfect for this situation.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
