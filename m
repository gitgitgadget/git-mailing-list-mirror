From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: FastCGI support in gitweb
Date: Tue, 04 Mar 2008 02:11:52 -0800 (PST)
Message-ID: <m3od9uiyru.fsf@localhost.localdomain>
References: <1c3be50f0803011334u2629011cg85cb8728a244ea4e@mail.gmail.com>
	<m38x12jeqt.fsf@localhost.localdomain> <47CBEED2.30808@vilain.net>
	<200803040119.22240.jnareb@gmail.com>
	<slrnfspi8b.83u.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 11:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWU8S-0002IN-G7
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 11:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYCDKL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 05:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbYCDKL6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 05:11:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:6274 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbYCDKL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 05:11:57 -0500
Received: by nf-out-0910.google.com with SMTP id g13so403155nfb.21
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 02:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=L0sErJ27ZCqAlZjcCVcV+ZWzsoOzkgYXIDuv1K191FI=;
        b=utRhvWLCdNNuBnYCvEDbkl6S2s7xUFhqy2ghmMSCE3ID/lI+N0ZAaM1fzyNPEkxk2QabiURtK5O+JYVnPhoEe7RhRLbtBlkT5z9rWYh4Cd6gqHsLvUBwJA+ztypmFSKDEEyK/I1hpAb+gsTFG1aENbsTJMQoK/BnIpcoQ0RRT1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=kLVhwdashsYYFD1vVW2jt6qCXg7WPQqb5rZEg7bvfun1ScBUL4nLqBEtCYMzpDNnAkE37GhdeeRUZK+dNsRCHRk8FRVLMrve87hR99DT55rcvcbY2Dsu4+z6xJrjtGvf/Q907o7xjw/xQKTJksx0uZ3Jg4hWx7fnlx6z7eEFN5I=
Received: by 10.82.182.1 with SMTP id e1mr3974829buf.21.1204625513871;
        Tue, 04 Mar 2008 02:11:53 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.156])
        by mx.google.com with ESMTPS id m5sm1646017gve.11.2008.03.04.02.11.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 02:11:52 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m24AC7Ue010649;
	Tue, 4 Mar 2008 11:12:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m24AC6PG010646;
	Tue, 4 Mar 2008 11:12:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <slrnfspi8b.83u.jgoerzen@katherina.lan.complete.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76060>

John Goerzen <jgoerzen@complete.org> writes:
> On 2008-03-04, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>>> Thanks.  I didn't submit this because I couldn't fix the bugs in it.
>>> Glad you found it.  I had to make many changes in a similar vein with a
>>> current gitweb version; did it work for you in its current form?
>>
>> I couldn't test it with FastCGI server, as I use Apache2, and all
>> FastCGI modules for Apache are third part modules.
> 
> On Debian, this was as easy as apt-get install libapache2-mod-fcgid

And for Fedora Core?

>From what I have found there exists three 3rd-party (i.e. not
developed by Apache) modules for FastCGI support: mod_fastcgi,
mod_fcgi and mod_proxy_fcgi. Which one to choose?
 
>> Besides, it doesn't
>> make much sense to use generic FastCGI for Perl, when there is mod_perl
>> module.
> 
> Sure it can.  I currently am running both Python and Ruby code under
> FastCGI.  Adding mod_perl for just one program increases my
> webserver's memory footprint, potentially dramatically, and increases
> my complexity as well.  I'd much rather run FastCGI than mod_perl.

Well, if you are running FastCGI for other scripts, it makes sense
then.

Although... doesn't there exists modules for Python (mod_python,
mod_wsgi, mod_snake) and for Ruby (mod_ruby)?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
