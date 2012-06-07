From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Thu, 7 Jun 2012 14:50:58 -0500
Message-ID: <20120607195058.GC3194@burratino>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 <7vr4u23f0i.fsf@alter.siamese.dyndns.org>
 <20120529203759.GC22151@burratino>
 <CACsJy8AGKQHKx9XU+baUagcmi6Sc-=faNshpED=Q46JpV_31WA@mail.gmail.com>
 <20120602124440.GA28996@burratino>
 <CACsJy8A+FTjD3dzBWtL7X35YE9E3t0Gcx-DA6T_+Nt=X3Wp1jQ@mail.gmail.com>
 <20120607124155.GB12987@burratino>
 <CACsJy8D=SMmhiyp-+pL5FxfcUGdLp9X4D42eV0uAGX3_LAa0xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 21:51:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scijh-0000Ye-AL
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 21:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab2FGTvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 15:51:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56067 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab2FGTvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 15:51:07 -0400
Received: by yhmm54 with SMTP id m54so738044yhm.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C2IYrM85n4TsM9sAWI7icP+bcLFSruBIDGSgWrJs3FY=;
        b=0WJljuhqQAKTdQ8cgYKQ+w53FwqcdAjDy5bFMo9vAo2zR1VXw3hurlGogn0/fA2Lxp
         7783m7P6CkLsH6ojKXBpTWoLP51654Bjc2CYfizRlDF+abyNtRoESIwGieOE7y2IRnP5
         1f64yyXHvngdAwmOxI8JSRglNcpIHGeM3DTswPr/O0vM2DZkdA+Ui8HjFfsRS6XX/asb
         49HR/DFEzl/AvWi/+qpTLPYOV7V2NEJ/1HMpAqs++4ax8HVHwKLu6A8ZuU0sqotnSH9L
         IJU1qiWEA804wkrtE2D5yLTwiMRdnIxpjKiI7uJLTkQT3GSzeWPwT5A6N3m1oJUASuJ2
         z1dw==
Received: by 10.50.104.228 with SMTP id gh4mr1950447igb.71.1339098665281;
        Thu, 07 Jun 2012 12:51:05 -0700 (PDT)
Received: from burratino (guardian2.ccc.edu. [216.125.49.252])
        by mx.google.com with ESMTPS id gh2sm1898788igb.9.2012.06.07.12.51.02
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 12:51:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8D=SMmhiyp-+pL5FxfcUGdLp9X4D42eV0uAGX3_LAa0xA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199442>

Nguyen Thai Ngoc Duy wrote:

> They still are and should be fixed when the new facility comes, so
> there's no point fixing them now.

Meh.  The whole point of GETTEXT_POISON from my point of view is to
prepare for a later facility like that, and I don't see how the fix
would be any different then, so...

But I don't mind waiting until someone interested (like me) has time,
so I guess this kind of question is moot.
