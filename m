From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git locate
Date: Tue, 19 Jan 2010 18:14:46 -0800 (PST)
Message-ID: <m3zl49bk0o.fsf@localhost.localdomain>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
	<alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 20 03:15:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXQ5v-0001tm-E9
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 03:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790Ab0ATCOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 21:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994Ab0ATCOu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 21:14:50 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35017 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0ATCOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 21:14:49 -0500
Received: by bwz19 with SMTP id 19so3454871bwz.28
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 18:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=IV9kYMrLqH5Excca1Yj11MayOIaDm0GZxNsb7WnFsUQ=;
        b=EeFK4BlrVfU4dCtvb6s0g3OwCMdimn4L2tIrW7vRe3mrkUb/MKQgZ1wFrSavcyeac6
         yAAmStLq4rD5inSZ+HYKxbuizTt0yI2khLaPbc/h6Xv9KWeNgPDXPLFEdqLRkMTMIVsX
         1SvyfRaXvCrru+sHhhNRfHw9TRXMbD72NIKrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HUZI9ryp6Mty5PZfHTEgTgD4f/pRieqVpU1Q+1PsjWt7nT/rC5IohQ6Z9+FmHubc1+
         Yts/vNlMkZNnryglPXI0AQisCUjakJaEgCrnnf6fN7/gN9k0NxuCOBwBn8mOBQVlFEdW
         TwyIJpbMsu7fvr3JuvsKXo9JGwCLVmuIrdpRU=
Received: by 10.204.4.87 with SMTP id 23mr3068160bkq.62.1263953688180;
        Tue, 19 Jan 2010 18:14:48 -0800 (PST)
Received: from localhost.localdomain (abvz142.neoplus.adsl.tpnet.pl [83.8.223.142])
        by mx.google.com with ESMTPS id 14sm1522666bwz.13.2010.01.19.18.14.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Jan 2010 18:14:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0K2EHgG022800;
	Wed, 20 Jan 2010 03:14:22 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0K2E0Yh022793;
	Wed, 20 Jan 2010 03:14:00 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137516>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 20 Jan 2010, John Tapsell wrote:
> 
> >   Could we add a:  git locate <filename>       or git find <filename>
> 
> How about "git ls-files \*<filename>"?

Or "git ls-files '*filename'...

... but how to make an (git) alias for this?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
