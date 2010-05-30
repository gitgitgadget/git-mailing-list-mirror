From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v2 6/6] gettext: Add a skeleton po/is.po
Date: Sun, 30 May 2010 16:39:32 -0500
Message-ID: <20100530213932.GA477@progeny.tock>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
 <1275252857-21593-7-git-send-email-avarab@gmail.com>
 <20100530212912.GA422@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 23:39:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIqED-0006it-Tv
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 23:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0E3Vix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 17:38:53 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:62804 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab0E3Viw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 17:38:52 -0400
Received: by ywh9 with SMTP id 9so2059752ywh.17
        for <git@vger.kernel.org>; Sun, 30 May 2010 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n9Znv6ZxEU7fl5nah/8ESFo3GeMMu5ZswzIwn+O4Cqk=;
        b=kGoq6nk7YNlHO3NSpxcgdFNXsTaihF/uSaiYTjsD4g7AUqwdy9vHFT4Adls2XwGyiR
         VZVLzt7xgZ9+hVn6jvsC7eClP5Z12SBqrnM/Oob4KaX/zd8l/NB9kKqX8FO37WF9/0CS
         wKlf6dQwkRyVqd31FG94IrOpSOP0OXflZ1ug8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Xllwqdt6N3D+OpisrEPhPUR1vMW3maFfnTxgWpIcZNf+HlHzwE/W8FcmbdkPyU/z5V
         0vLOMPeYDGkY7dXgWe26nYAlNAva4rDXzjrd2AgNzXprOwx1hYfTsiDtcbTudVLlutRn
         W0kQolow+HSdngnGbUUOvkbD+u9B3QVtZQ6Yo=
Received: by 10.231.186.161 with SMTP id cs33mr4595988ibb.65.1275255531351;
        Sun, 30 May 2010 14:38:51 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm22897918ibf.19.2010.05.30.14.38.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 14:38:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100530212912.GA422@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148025>

Jonathan Nieder wrote:

>   gettext 'You asked me to pull without telling me which branch you
> want to OP_TYPE OP_PREP, and 'branch.CURR_BRANCH.merge' in
> your configuration file does not tell me, either. Please
> try again (e.g., 'git pull <repository> <refspec>').
> See git-pull(1) for details.
> ' |
>   sed "
> 	s/OP_TYPE/$op_type/g
> 	s/OP_PREP/$op_prep/g
> 	s/CURR_BRANCH/$curr_branch/g
>   "

Apparently this is what "gettext -e"/eval_gettext is for.  Sorry for the
noise.

Jonathan
