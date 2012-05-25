From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 12:44:49 -0500
Message-ID: <20120525174448.GB4267@burratino>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <20120525170159.GA4086@burratino>
 <vpqvcjkrwxj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 25 19:44:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyZN-00012C-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211Ab2EYRox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 13:44:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61567 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab2EYRox (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 13:44:53 -0400
Received: by yenm10 with SMTP id m10so554212yen.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xw3Fe8+5ne0tcNGkdytQ9tLqW+maE7rB23yaLF16VD8=;
        b=0WmkFKI/ikCByDxtpXFMal8mU/sZ5lg3nBpyS5ORgVuafh9vwBhud5Xg0QjqP7Rc53
         dJak57FaTKBlGofw4zR7GrOyy7iV74IgvKKCn3zLOsyJiM7Z33JjyoZr6O64wO2yfwG6
         TABvmKf0/LVI8ky+/fNRpUeWJdsBHLDPAJGoJmIqqARdqudnl7gwz2bPB6GuWh7eNXxm
         MeecUXtLp/Geo5/htKp17QV0xJNz+HqUPqqETbEdtRHkWMKXZW/jdrrV69VTwkeMc9Z3
         UsxTzXs6SIjCYdT0RGC5MHoakwavrIJ8pZQpZln72qQhuMG6/iM6fV02QUfQBN0ALkef
         1T0Q==
Received: by 10.50.179.105 with SMTP id df9mr3912586igc.4.1337967892283;
        Fri, 25 May 2012 10:44:52 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k6sm7945992igw.14.2012.05.25.10.44.51
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 10:44:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqvcjkrwxj.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198492>

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> What other hidden files at the root of the user's directory are you
>> talking about?
>
> A typical user configuration (or at least mine ;-) ) can include:
>
> [core]
> 	excludesfile = ~/.gitignore
> 	attributesfile = ~/.gitattributes

Ah, right, this line from .gitconfig: ;-)

	[core] excludesfile=~/.config/gitexcludes

[...]
> Actually, I now remember trying to find a default value some time ago:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/133343
>
> The conclusion essentially boiled down to "let's drop the patch until
> there's a clear consensus on what the default value should be", and
> "don't default to ~/.gitsomething, because it will be painful to migrate
> to a user config directory later".
>
> Once it's official that the configuration is in stg like ~/.config/git/,
> we can start thinking about a default value for core.excludesfile and
> core.attributesfile, in the same directory (note: we're just talking
> about default values here, so users having set the variable explicitely
> won't be affected by the change).

Makes sense to me.

Thanks,
Jonathan
