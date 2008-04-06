From: "Elijah Newren" <newren@gmail.com>
Subject: Re: [PATCH] Add interactive option in rebase command completion list.
Date: Sun, 6 Apr 2008 12:33:29 -0600
Message-ID: <51419b2c0804061133t20f7606y2ebe8f921b6c3781@mail.gmail.com>
References: <1207503144-3008-1-git-send-email-pascal@obry.net>
	 <7vprt2sv60.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pascal Obry" <pascal.obry@gmail.com>, git@vger.kernel.org,
	"Pascal Obry" <pascal@obry.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 20:34:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiZhD-0001qv-3G
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 20:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbYDFSdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbYDFSdd
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 14:33:33 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:21689 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbYDFSdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 14:33:32 -0400
Received: by rn-out-0910.google.com with SMTP id e24so866630rng.1
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=i54E3fz8EmB2JBdnOGBX2SEWBARuux2UM5UmDYavrn8=;
        b=ZsrTt/X7P+3kiOV1Bl0rKs7D7vb+XTx//5eeqMxqBy95fE5gxUpXMyLwSMDbhaWVm/V3rwcjwZxML8QPsPAmzoAPa09WjrQZiMIs/HOWvzpgGHPZFQKPkgb3zib44/V+FKr5lQDcQ9gOZGlr+F0ieFRJiQQSy0iJp3DpcUSXS6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=v5/oyyR9Lw/7HHtKLDMYDqsrIXV5eW3AHCMfOL3CsgyEXT1UrCO9HG48Xkzy7zMKVeMJiU5Xt35KEWXXudABusA6oFgREvRz2B1xN3Z8rYBVXo/kqaVPsrJ/gxZKVuuZVe0UnQ+12Y69AF1djBG1OgSORb+0NJ/SMrONgZmNwQY=
Received: by 10.114.80.4 with SMTP id d4mr5027215wab.44.1207506809254;
        Sun, 06 Apr 2008 11:33:29 -0700 (PDT)
Received: by 10.114.46.15 with HTTP; Sun, 6 Apr 2008 11:33:29 -0700 (PDT)
In-Reply-To: <7vprt2sv60.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78908>

On Sun, Apr 6, 2008 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pascal Obry <pascal.obry@gmail.com> writes:
>
>  > -             __gitcomp "--onto --merge --strategy"
>  > +             __gitcomp "--onto --merge --strategy --interactive"
>
>  I personally do not think this is worth it where a single "-i" is enough.

One advantage of bash completion, in my opinion, is being able to be
reminded of option names by tabbing twice to get a list of possible
completions.  For exactly such a case, I'd be in favor of this patch.

Just my $0.02,
Elijah
