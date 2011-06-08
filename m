From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 2/5] gitweb: Describe CSSMIN and JSMIN in gitweb/INSTALL
Date: Wed, 8 Jun 2011 13:32:18 +0200
Message-ID: <201106081332.19008.jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com> <1307382271-7677-3-git-send-email-jnareb@gmail.com> <20110606200126.GB30588@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Drew Northup <drew.northup@maine.edu>,
	Petr Baudis <pasky@ucw.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 13:32:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUGzy-0007Nw-LZ
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 13:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab1FHLca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 07:32:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63254 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab1FHLc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 07:32:29 -0400
Received: by bwz15 with SMTP id 15so329901bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=b2xlYp8SphWZboA2v7UoMnTTHcx/9E9p+rbcpmr9dD4=;
        b=jO2PPAqf+7ObLRHf6j3vIIzYqfM/UQRn+Pa+uQzgPc2BYoY+aVAvrJTfoGv45a1gf5
         R2fd2JhQyKOI6wdiUdjKFq5ONJmI/KA9Vr+PyPGiaPLGNCK4Q1yoUNtwu+Rtc798rNFh
         /qpbQe6nP331tzI30JIPv2gj/02IjyM+I3F7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=D0qhFuOfOWWaDPqYpcM6WZHa75bRXc/VDoHvgOs8eEK+oVlLks/NPw5fGQ446WJpwm
         6PInnBHqZpnZIutZymuYeZ6FamvskkMwKx28//fUKNdrzqW7EVcDVvNYh3ZA5X5YD78r
         7bfVX3KkX4IyLpfjsHBebg1SXlvxVHeLQjdEo=
Received: by 10.204.73.206 with SMTP id r14mr724028bkj.181.1307532747923;
        Wed, 08 Jun 2011 04:32:27 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl [83.8.218.41])
        by mx.google.com with ESMTPS id ek1sm468232bkb.9.2011.06.08.04.32.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 04:32:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110606200126.GB30588@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175357>

On Mon, 6 June 2011, Jonathan Nieder wrote:

Thank you very much for your review and comments.

> Jakub Narebski wrote:
> 
> > The build-time configuration variables JSMIN and CSSMIN were mentioned
> > only in Makefile; add their description to gitweb/INSTALL.
> >
> > This required moving description of GITWEB_JS up, near GITWEB_CSS and
> > just introduced CSMIN and JSMIN.
> 
> Why does this require that?  Ah, to make the analogy with GITWEB_CSS
> clear and because the JSMIN description refers to it.

Yes, moving description of GITWEB_JS was required because I wanted to
cover both of CSSMIN and JSMIN with one entry, which entry of course
refers to both GITWEB_CSS and GITWEB_JS.

> > --- a/gitweb/INSTALL
> > +++ b/gitweb/INSTALL
> > @@ -147,6 +147,19 @@ You can specify the following configuration variables when building GIT:
> [...]
> > + * CSSMIN, JSMIN
> > +   Invocation of a CSS minifier or a JavaScript minifier, respectively,
> > +   working as a filter (source on standard input, minified result on
> > +   standard output).  If set, it is used to generate a minified version of
> > +   'static/gitweb.css' or 'static/gitweb.js', respectively.  *Note* that
> > +   minified files would have *.min.css and *.min.js extension, which is
> > +   important if you also set GITWEB_CSS and/or GITWEB_JS.  [No default]
> 
> When I first read this, I thought it meant these command lines were
> going to be cooked into the gitweb script and invoked at run time.
> Maybe (sorry for the rough text):
> 
> * CSSMIN, JSMIN
>   Command for a CSS minifier or a Javascript minifier, working as a
>   filter [...]
>   These are used if defined to generate smaller, non human-readable
>   versions of 'gitweb/gitweb.css' and 'static/gitweb.js' at
>   'static/gitweb.min.css' and 'static/gitweb.min.js'.  Only the minified
>   versions are installed, which is important if you also set GITWEB_CSS
>   or GITWEB_JS.  [No default]
> 
> Aside from that, looks good.  Thanks.

Thanks.  I'll incorporate those comments in next round... or as a separate
improvement (it is not that bad, I think, to not allow it to be fixed
"in tree").

Anyway the description could use some improvements.  We need to cover the
following issues:

1. CSSMIN and JSMIN are invoked during building gitweb.

2. CSSMIN and JSMIN are interpreted as shell commands, so
   * if you refer to script by full path, you need to quote spaces
     yourself, e.g. 

     JSMIN="'c:/Program Files/JSMin/jsmin.exe'"

   * you can provide options, so you can e.g. use

     JSMIN="perl -MJavaScript::Minifier=minify -we 'minify(input => *STDIN, output => *STDOUT);'"

3. CSSMIN and JSMIN must accept source on standard input, and print
   minified version to standard output, i.e. they are invoked as

     $(CSSMIN) <$< >$@

4. Minified files will be named static/gitweb.min.css and
   static/gitweb.min.js, respectively

5. If you do not set GITWEB_CSS and GITWEB_JS, but use CSS and/or JSMIN,
   they would be set to appropriate values automatically

6. The "install" target in gitweb Makefile, and "install-gitweb" target
   in main Makefile, would install minified versions (if any).

7. If you set both CSSMIN and GITWEB_CSS, you have to adjust GITWEB_CSS
   by yourself.  Same for JSMIN and GITWEB_JS.

Help with wording those would be much appreciated, in more compact form.
Thanks in advance.

-- 
Jakub Narebski
Poland (not native English speaker)
