From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/7] gitweb: auxiliary functions to group data
Date: Fri, 17 Sep 2010 18:06:48 +0200
Message-ID: <201009171806.49774.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <201009170324.25801.jnareb@gmail.com> <AANLkTikk7vUFMr31Azdcpe+PK0-yA2sp2EcnHjdfw0Zn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 18:07:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwdSn-0005gT-LM
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 18:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab0IQQGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 12:06:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35423 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab0IQQGx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 12:06:53 -0400
Received: by bwz11 with SMTP id 11so2767465bwz.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nXPFoo6HTlSfsGgxs8NogynO81iZ76NGTg1afBKQsEM=;
        b=TBEmEJhddiFJ4JwOONXHL96IL5AMr6auyGLHQWePsJNBc6J2+zIwL7gfJlYpWAhcZ4
         UVAKooczW0Es+huFW/IFT+bectG+WA3cxzyPTGT8XnspSlqyOAhLwW93BwZkyn2MJ0R5
         vuMOu4CoJS91VVq2hBNm8UsxRfSC88IX2Krz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=K1YFdkSTvLZw59RwCrQpPt32vwQksPm+y2rL+PsZho//aPJT8RmxMRIsNvymavA5js
         aODaD1on7T3kQV9QIy35yNugunBMt5zS4zFELBfaE93MoNpKchQ7+MdVprD04mEw/Mek
         8tMkdqIZz+4PE/Xj7La3+9SeMaZmruigAwA1o=
Received: by 10.204.53.142 with SMTP id m14mr3927629bkg.147.1284739612522;
        Fri, 17 Sep 2010 09:06:52 -0700 (PDT)
Received: from [192.168.1.13] (abvo68.neoplus.adsl.tpnet.pl [83.8.212.68])
        by mx.google.com with ESMTPS id s34sm3764734bkk.13.2010.09.17.09.06.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Sep 2010 09:06:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikk7vUFMr31Azdcpe+PK0-yA2sp2EcnHjdfw0Zn@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156392>

Giuseppe Bilotta wrote:
> On Fri, Sep 17, 2010 at 3:24 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > ... but I think that having separate subroutines for opening and
> > closing tags is a bad design / bad API (except in some rare cases).
> > It is begging for unbalanced HTML.
> >
> > It would be better if it was a single subroutine wrapping 'div' around
> > contents given either as a string, or via callback (subroutine reference),
> > in my opinion.
> 
> I'm not sure that in this case the string or callback approach would
> be any cleaner. I'll see if perl supports closures or something like
> that.

Perl supports closures (thanks to anonymous subroutines 'sub { ... }'
and lexical variables 'my $var'), see perlsub and "Function Templates"
in perlref.

I also recommend free ebook "Higher-Order Perl" http://hop.perl.plover.com/
-- 
Jakub Narebski
Poland
