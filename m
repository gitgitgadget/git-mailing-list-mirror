From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why does git-mergetool use /dev/tty?
Date: Mon, 23 Aug 2010 20:53:37 -0500
Message-ID: <20100824015337.GC17406@burratino>
References: <3D6C7B12-FA06-4EAD-9781-5CA74FE23057@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Charles Bailey <charles@hashpling.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 03:55:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnijV-0002l1-Uv
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 03:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab0HXBzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 21:55:21 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62827 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab0HXBzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 21:55:19 -0400
Received: by qwh6 with SMTP id 6so5657643qwh.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 18:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9ALr73FDL3s8IgIVQScD/G3qtyED2Vi1FPzkC2wF/wg=;
        b=KTC2lIXA2weWGifh11cV8Buw8Mqyl4OiaKz9SevctlA7t3meJPr5sGz0PG09OHHers
         hrFS7QniOiMfuoJJSv5z57OF1j5z4jg6ef08JwMgoVWReCsWIqOxkMCzm7B0jT9Ql833
         x0q1FZv7n3zuUH/+Zz1c3lGr8YrRHvXah9QWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PoKoGI9zqwL9dsxLFGQADrIboDcA0Oixoi8gqq+mLYgxJTNIKBC0epmfM0V1h29JNj
         eVKLx+n4kicSefSu+yYH6Pe336jhL/ujGB1rOwr/CER7v9EdQ0ILJU9o1Ft7rWC9Cph5
         aChRpsgVhwZzy9AI778pU2yO2uar6NbIlXVGc=
Received: by 10.224.19.200 with SMTP id c8mr3937253qab.309.1282614918362;
        Mon, 23 Aug 2010 18:55:18 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r36sm7866508qcs.3.2010.08.23.18.55.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 18:55:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3D6C7B12-FA06-4EAD-9781-5CA74FE23057@gernhardtsoftware.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154276>

Brian Gernhardt wrote:

> Why does git-mergetool ignore the provided STDIN and STDOUT when not given a path to merge?

See af314714 (mergetool: Remove explicit references to /dev/tty,
2010-08-20) in pu.

Hope that helps,
Jonathan
