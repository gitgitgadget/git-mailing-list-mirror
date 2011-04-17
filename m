From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sun, 17 Apr 2011 16:59:01 +0200
Message-ID: <201104171659.02950.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201104141154.55078.jnareb@gmail.com> <BANLkTikNfTWuSM1yscUZVqgQk-EyPZL58A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Petr Baudis <pasky@ucw.cz>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 16:59:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBTRY-0004oK-KZ
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 16:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652Ab1DQO7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2011 10:59:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37122 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab1DQO7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 10:59:14 -0400
Received: by fxm17 with SMTP id 17so2575033fxm.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=tn/8BhaVurhzBDCvUNqA8pKvDNlUKfw2Eq0RqUm/zkQ=;
        b=kR6h+Ak0RL95WyUuIkPRYh0Lkyp3l6zf5Rd7wbdmszrZrm7T5i5RV0BNiTs8jltMPc
         3xokjgFmt3TOgOu9s0P3KufnVOIFJRqyR8hbCEwPEXxm3hL1KWzHACw//ik+tKHwQasv
         YKRG/oX+U2dyiMKZXqHRnxUZRT8ccPsp1l7Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=swaABu7Bm/+PhaV2nDlV70roeJbcJZBmF3HuArh1N2bNdfrekkFoPZ8JBUbvwxS4T+
         Nvb2Vug3pug7R+nlT4fedF7p/q0jqBfVhx9jM+lp2jf2M9ioJTUzOJkEkQWVlP9oh3gH
         rg+CLb0T1gdogSXX0Q1xyhJk1xANV/xtWz7+A=
Received: by 10.223.54.148 with SMTP id q20mr1919036fag.84.1303052353633;
        Sun, 17 Apr 2011 07:59:13 -0700 (PDT)
Received: from [192.168.1.13] (abvn58.neoplus.adsl.tpnet.pl [83.8.211.58])
        by mx.google.com with ESMTPS id k5sm1379304faa.15.2011.04.17.07.59.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Apr 2011 07:59:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTikNfTWuSM1yscUZVqgQk-EyPZL58A@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171721>

On Sat, 16 Apr 2011, Pau Garcia i Quiles wrote:
> On Thu, Apr 14, 2011 at 11:54 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
> >
> > This is second installment, talking about JavaScript (client-side)
> > part of gitweb code.
> > [...]
> > Those issues are already solved in __JavaScript libraries__ and
> > frameworks, probably better way than in our attempt. =A0Using JavaS=
cript
> > framework would also give as higher level constructs, and could
> > replace what we have and could have in gitweb/static/js/lib:

> My suggestion is going to be tremendously unpopular, but still: if I
> were to develop my own gitweb, I'd use Wt ( http://webtoolkit.eu ) +
> libgit2. In fact, there is a very basic gitweb-like example bundled
> with Wt sources, it's available online at
> http://www.webtoolkit.eu/wt/examples/git

Well, nothing prevents you or anybody else from writing (yet another)
web interface in C++ + Wt + libgit2.  Gitweb is not the only git web
interface:
  https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tool=
s#Web_Interfaces
=20
There is Gitalist in Perl which uses Catalyst MVC framework, cgit in
C linking directly to git (libgit.a), git-php and ViewGit in PHP, etc.

> All those detect if this feature is available or not, fallback to
> plain HTML (no Javascript, no AJAX), use HTML5, or SVG, or... where
> available are already solved (and are totally automatical) in Wt. It'=
s
> C++ with Boost and Qt-like API, not plain C, Perl or bash scripting,
> though.

Gitweb has the advantage that if you can install git, and you have web
server with CGI support, you can install and run gitweb.  First part
of series was about relaxing this "no non-core dependencies required"
requirement.  Requiring to install C++ / libstdc++, Boost and Wt...

Note that git chosen to write strbuf and parseopt from scratch,
instead of using some existing library (bstrings, Boost, popt,...).

So, as yet another web interface, fine.  As replacement for gitweb:
I don't think so.


BTW. do I understand correctly that Wt generates JavaScript code, in
similar vein to GWT for Java, or Pyjamas for Python?

--=20
Jakub Narebski
Poland
