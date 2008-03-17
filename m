From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.10
Date: Mon, 17 Mar 2008 02:45:11 -0700 (PDT)
Message-ID: <m3r6e9wup2.fsf@localhost.localdomain>
References: <20080317020304.GA19249@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Mar 17 10:46:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbBun-0002g4-3Z
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 10:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbYCQJpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 05:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbYCQJpQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 05:45:16 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:64410 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbYCQJpO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 05:45:14 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1731137fkr.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=S/4lkdSVxrB9rBKTJnj1fFmMFfZ/XjbtqUIwSYxAsCY=;
        b=Pta2+amz1yKbnn8wwPxrBTZ6r2lhbESSTqo23yTsR7YhfZxo/Km3aCyocF46RK4VYxq6yxRlWeNg1rVXhVCimsnff1s+rtAn8DczF9VJgmzwxP8Ww4YNaT72lzyhaPDADswNog8hCD3OkQLfSQCL5+iQoXObY+FiJY5MvZ1+aZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=mKLk84DDLaH7I2Ufg8NFO3n70R+Ru3oEq+Eid6OdcBDNLm+b2OAqFjU1yUFnvmYflDI7z4h5xM3vXzzqAOmVrKi/51ckh/diYEWpNf+9P5+ni6+rAaSAvwA5K2rnoO8dPgAJANn4wirjrfvUmUtMT0LX/Z3gLIuyRxXakwvkQqs=
Received: by 10.78.203.15 with SMTP id a15mr40434738hug.57.1205747112942;
        Mon, 17 Mar 2008 02:45:12 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.232.138])
        by mx.google.com with ESMTPS id u26sm26169216mug.17.2008.03.17.02.45.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Mar 2008 02:45:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2H9j2pu009241;
	Mon, 17 Mar 2008 10:45:05 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2H9iwrJ009237;
	Mon, 17 Mar 2008 10:44:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080317020304.GA19249@diku.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77422>

Jonas Fonseca <fonseca@diku.dk> writes:

> A new version of tig is available! It brings many documentation
> improvements, bug fixes, and some much needed updates to work better
> with git (e.g. by using --no-color and avoiding to use git-diff).

It seems like 'g', toggle revision graph visualization, doesn't work.
Checked with
  $ tig log --pretty=oneline --abbrev=8 --abbrev-commit

> On startup, tig will now attempt to first read a system-wide configuration
> file before loading the user specific configuration file. Cherry picking
> from inside tig has been generalized, making it possible to wire
> external commands, which can access information about the current
> commit, to a keybinding.

By thw ay, in tig(1), in the "FILES" section, there is 

       /home/fonseca/etc/tigrc
           System wide configuration file.

Is it a bug in code, or just in documentation.

tig was installed using:

 $ rpmbuild -tb tig-0.10.tar.gz
 # rpm -Uhv tig-0.10-0.i386.rpm

-- 
Jakub Narebski
Poland
ShadeHawk on #git
