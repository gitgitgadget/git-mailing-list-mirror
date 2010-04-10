From: Simon <turner25@gmail.com>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 17:24:35 -0400
Message-ID: <p2u5f14cf5e1004101424q2d6a871fs2466988f7a4202fe@mail.gmail.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
	 <l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com>
	 <20100410193039.GA28768@thyrsus.com>
	 <h2t51dd1af81004101239pe340cc54lcbb1a5b3702ec091@mail.gmail.com>
Reply-To: turner25@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: esr@thyrsus.com, Eric Raymond <esr@snark.thyrsus.com>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 23:24:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0iAU-0002Nq-4I
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 23:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab0DJVYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 17:24:36 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60866 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab0DJVYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 17:24:36 -0400
Received: by gwj19 with SMTP id 19so359920gwj.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type;
        bh=tgf/gD+1P8rS5+iGc3WiS1n3dUjKo7RBjqFdzWJg228=;
        b=OMBb9JQRlNr5iH/yu7UTMija7pz3pZHdQ77LJO1kvPzGvTVwvkeFUSv0neheWNMcoc
         RwKarrzNbWeQ6lVB7iBXuKnq22/QXUvzhiJNsoNWma3T/WNaPf+yQ9FTuJ4Zj3JN11jv
         nrsGRwrhG7ShOtitZP2g/v/tt8ebN9MacVHXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=bBY3bQPAdyQ0lUwTHP/T7ef648eBH89uqGNPemVSgBsqFn/b1fMme0QZgLN28H36Ea
         ka9cv/AQUNf0/uOcH67PznRkVResr6neHX37I9XI28kLCLaaiZqeVJHtlVf+ESuDHPic
         w7HyaqixF4eYrFDq35ZwIpLZz+gKLUQQLYwVs=
Received: by 10.100.142.16 with HTTP; Sat, 10 Apr 2010 14:24:35 -0700 (PDT)
In-Reply-To: <h2t51dd1af81004101239pe340cc54lcbb1a5b3702ec091@mail.gmail.com>
Received: by 10.101.58.8 with SMTP id l8mr3228672ank.7.1270934675296; Sat, 10 
	Apr 2010 14:24:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144596>

> A lot of web services (like some Catalyst-based applications) support
> all of these equally. If Git had machine readable output like this it
> would be nice if every git-* program just had --format=* where * could
> be xml, json, yaml, sexp, perl etc.
>
> The program would just construct a native datastructure and then there
> would be an output driver to generate the textual representation.
>

I had something just like this in mind when I suggested XML...
I would personally avoid it for same reasons others have pointed out, but...
There are lots of tools out there that can parse and display XML very
well natively.  Firefox is one such example.

My intention is not to start a flame here, rather try to keep our
options flexible.  ASCII would clearly remain the default though! ;)

Simon
