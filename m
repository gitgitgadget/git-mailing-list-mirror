From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: git tag's history
Date: Mon, 26 Jul 2010 14:36:07 +0100
Message-ID: <1280151367.8229.28.camel@wpalmer.simply-domain>
References: <AANLkTinCTcnr=tyC2+C4u5L0p_mXxTCMfSBm_JzqqMDW@mail.gmail.com>
	 <AANLkTikTqJVbohquiNmW0BvP0bXsVFyMw0H4qF2FbhiH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mahesh Vaidya <forvaidya@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 15:36:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdNqv-00082W-2T
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 15:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab0GZNgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 09:36:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57552 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab0GZNgM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 09:36:12 -0400
Received: by wyf19 with SMTP id 19so2087284wyf.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=PSQ7/PWaUs7bDnY8/Bg3V4G/agjtQqYUdHOzupVuRFI=;
        b=d5IuMLDbbPVGwKqPhZow57VynjD5nbWzOl47/BMxGl9pon39QmnpIX7k60g0Fvv0jb
         vcgxo0SK3AE+SVZrV3g0FYcGJjJDN7iELTvJbmFGlnvoNlQEU78+bbQca9zvp1rX1Z/A
         GN/z++qk+5JPW4fVmmz0kM3K+qt+CYvuoySxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=IofxNI2jIMz0fGgcntClLgSRA/IAuCpjfVnNY1PTBlCWUHPgByj4VXVOe28WKPjU5f
         4BWqjv6L0BGlBLVwVpgk7yVX7kn0SczrxNdBfyXCQCHZUpXkkFhdXis+MQZsMtg6QAcP
         3kzUdvpMmupdV8gi/mOalG+pYorb/lVNDsm98=
Received: by 10.227.72.139 with SMTP id m11mr7398734wbj.30.1280151370689;
        Mon, 26 Jul 2010 06:36:10 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id v16sm1925461weq.32.2010.07.26.06.36.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 06:36:09 -0700 (PDT)
In-Reply-To: <AANLkTikTqJVbohquiNmW0BvP0bXsVFyMw0H4qF2FbhiH@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151835>

On Mon, 2010-07-26 at 02:36 -0700, David Aguilar wrote:
> He won't be able to push the tag unless he forcibly deletes your tag first.
> 
> Tags do not have history.  This is a non-technical problem.  If s/he's
> deleting your tags, it's a social problem.
> 

What about enabling the reflog on the shared bare repository?
Tags get changed. That's a fact. It's a necessity, no matter what the
theoretical model says. Sometimes there's a reason to replace a tag, and
when that happens there is sometimes a reason to hang on to the old
value. Pretending "it's a social issue" ignores reality, not the least
important aspect of which is "social issues happen. How do we avoid
losing information in a sane, scalable manner?"

Just an example of a tag which could stand to be updated, take a look
at: refs/tags/junio-gpg-pub  There's at least one thing in there which
is out of date.
