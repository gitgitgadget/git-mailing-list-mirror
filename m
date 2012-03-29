From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Thu, 29 Mar 2012 10:14:10 +0100
Message-ID: <201203291114.15284.jnareb@gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com> <201203281238.49171.jnareb@gmail.com> <CACeyogf_ssqS6LdiYiopkh8UYGiBw5Cm06e-sut_y33cimiMJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 11:14:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDBRC-0003DK-W7
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 11:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758610Ab2C2JOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 05:14:25 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43120 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab2C2JOX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 05:14:23 -0400
Received: by eekc41 with SMTP id c41so822602eek.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=K0fotkdbCCt5C/5nwqBBh8ueEDbyhT12vzb7TSFeCbw=;
        b=T/mkq97Lm+gjuFNi+BpaeV9ILQduf6QVDN5tZizMyxbSOBbK5Sej29ZKlRE2l63wCo
         dTBIagsdr6X+UfRGATnUuLo0M5UFctwLLoMGrqg0487isV80XUE5TxMZ5eCUvmcQBl27
         YUtLzh4wg/TSd8U3ucq5DFi8fdpRVHfzNjqbhyoe0eDUxtTnZ4hxr48x6ciwFXunfADe
         kXB2T/lKdFyvBIxYHHkeyvIoiyBeWVe9+/tkmThTuvWKm28NipZXgUWAGUe844bdAxkb
         S/wWUFrCCwdVihVqJYEWMBeQG6SuZtiiNcHOoIXBrlqo0z5syXoX8GmWvo/w9S2XeIxB
         wyvw==
Received: by 10.180.101.8 with SMTP id fc8mr3709869wib.12.1333012462598;
        Thu, 29 Mar 2012 02:14:22 -0700 (PDT)
Received: from [192.168.1.13] (euy254.neoplus.adsl.tpnet.pl. [83.20.196.254])
        by mx.google.com with ESMTPS id l5sm65390934wia.11.2012.03.29.02.14.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 02:14:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACeyogf_ssqS6LdiYiopkh8UYGiBw5Cm06e-sut_y33cimiMJQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194242>

Please remove those parts of quoted (cited) message that are irrelevant
to your response.  Try to not top-post, either.

On Wed, 28 Mar 2012, chaitanyaa nalla wrote:

> I forgot to add this feature to employ JavaScript syntax highlighter
> to pretty-print contents of the blob view.

O.K.  Anyway, I think adding this feature is optional, as time permits;
especially that it is, I think, not easy.

> Here are my views regarding which JavaScript library to use.
> I want to stick to one or two libraries, as I don't want to
> mix things up which is a bad practise.

This is a good idea.

> For DOM manipulation jQuery is better than others.
> For graphics representation Raphael library or Dojo is better.
> If one need robust Object Oriented platform, Dojo is better.
> Based on popularity, light weight jQuery library is pretty famous
> because of its simplicity and power, it got added advantage that
> Microsoft's ASP.Net and Nokia are supporting it.
> YUI is modular.
> MooTools lets have us our own way .. http://jqueryvsmootools.com/
> Please take a look at this link:
>
>    http://en.wikipedia.org/wiki/Comparison_of_JavaScript_frameworks.

What is lacking in above description and comparison of various 
JavaScript frameworks is note about *your familiarity* with said 
libraries.

> Based on the goal of the project, I would prefer jQuery as it is well
> tested, robust, simple to use, widely popular, has good support for
> DOM manipulating, is fast (performance) in most cases.

Additional advantage is that there are many CDN (Content Delivery
Network) for jQuery that one can use.

I also think that for gitweb, where goal is to enhance its views
(rather than creating JavaScript app like e.g. GMail or Google Docs),
lightweight and popular jQuery library might be a best choice.

> Though for graphics I would go for Raphael.js, as it has clean
> and neat API similar to jQuery, and it has good graphics support.

Well, if there is time for adding client-side graphical history view
to gitweb, Raphael.js seems like a good choice.  But I am afraid that
this feature it as large as separate GSoC project.


P.S. Another source of inspiration for JavaScript usage in gitweb might
be git-browser project.  Just FYI.

-- 
Jakub Narebski
Poland
