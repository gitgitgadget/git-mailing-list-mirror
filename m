From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: future of git-gui as subsytem or submodule
Date: Mon, 14 Feb 2011 16:17:38 -0600
Message-ID: <20110214221738.GA24265@elie>
References: <20110213125324.GA31986@book.hvoigt.net>
 <7v39nruk9j.fsf@alter.siamese.dyndns.org>
 <20110214220318.GD50815@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 23:17:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6jv-0000Na-Mk
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 23:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab1BNWRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 17:17:47 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48091 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1BNWRp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 17:17:45 -0500
Received: by wwa36 with SMTP id 36so5432554wwa.1
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 14:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jPnJ+Ss3m6XOMNFWewpM1+owb2+fi7iao+SE4Eu2jZ0=;
        b=s3Cs9DxP5tzYNaznJZrYKnkyjJb5xCBz18gZQJxqVROXJbUXPwDhauZqblhvj9rnVU
         yGuYkW0WDVmn9iF4EiVzBS/mk1LwKvZNpXvbb+T1Tm/r/kOIuHkLUCcbYmfBh9pUBU30
         TKZrsgmuB5XMyS3UlmOIWE114BnvSkSYIrL6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eFyjoYHCXxuGqY8sKEyEHzdOUkU5NWKIHXu0FLutVfU4Uj4yjrzBWRZ3bAnA3xqmgG
         E/g7Lo1lZJ7UOpBmdpp4YVgl6FzNDgTfPL1LFo7NStaTjxlMaK6o8hYevmlu0nWuaIPc
         gzYjE4I4V43uT4duX90taEcEyOSC20Ec9hz5A=
Received: by 10.216.160.84 with SMTP id t62mr3511706wek.69.1297721864479;
        Mon, 14 Feb 2011 14:17:44 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.sbcglobal.net [69.209.51.217])
        by mx.google.com with ESMTPS id r80sm1059871wei.15.2011.02.14.14.17.42
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 14:17:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110214220318.GD50815@book.hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166784>

Hi,

Two quick thoughts.

Heiko Voigt wrote:
> On Sun, Feb 13, 2011 at 11:51:04PM -0800, Junio C Hamano wrote:

>>  2. Just like the Linux kernel project, we can make each subsystem with
>>     separate maintainers just different repositories of the same git
>>     project with their own focus.  We already do this for git-svn (which I
[...]
> Another plus, if we extend that model to gitk, is that both could start
> sharing code between each other (maybe relocate to the same directory).

I think historically Paul has tried to maintain compatibility with
older git versions in gitk, to allow it to be used as a separate
project.

A dream would be for gitk and hgk to share code, but I'm not sure
anyone has even tried a proof-of-concept for that.
