From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Add svnrdump
Date: Wed, 21 Jul 2010 17:16:10 +0530
Message-ID: <20100721114610.GC15903@kytes>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
 <20100715190220.GI22574@debian>
 <20100715192321.GA722@ted.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Sperling <stsp@elego.de>
X-From: git-owner@vger.kernel.org Wed Jul 21 13:48:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObXmP-0002SB-1a
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 13:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab0GULr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 07:47:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53609 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0GULr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 07:47:58 -0400
Received: by pzk26 with SMTP id 26so2043747pzk.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=i4DtfQ4kzQ5+Y4wlXhDD5fcaQwJ3702vuGhPGH71ndE=;
        b=Q/0xmw2hY76Gshs1ZljW0feKd4uX/E8AdZfEeSvALe7xIKDFz21fPFUPzALF3ncnsE
         ucjAqSOWi/s03xmh2KTN1WLkriffTZosgxsT+2EJEZDaluHXeeEe/Yo72r3umjSkb78J
         Zm7dfOGs6QO8qOdvt8VyCl597Ym92SmlMgD5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=btSP7VzVuLP1AMsOMXopUVBrt00bjnNlUwY9HpC2v7D2FRkWPt3q5/h/gy2WoHuspm
         24N/cQraIn3c+CgBagJsabY+LDgIAnLTXb52XD7zAGszoe1h1xZIxpFsMmLEQ8PFgcsK
         1qrD7PefMNu/9zR9dbi5eES8Gg+QhuxaFgAL0=
Received: by 10.142.132.18 with SMTP id f18mr70379wfd.28.1279712877484;
        Wed, 21 Jul 2010 04:47:57 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id r15sm304963rvi.8.2010.07.21.04.47.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 04:47:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100715192321.GA722@ted.stsp.name>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151394>

Hi Stefan,

It's been a while, and I've fixed most of the issues that you pointed
out intermittently over the last few days. I'm still writing a
unittest in Python, although I'm still trying to figure out how to
test it without using that ugly awk query to compare it against the
`svnadmin dump` output. With the help of the Subversion community, I
think I should be able to beat it into shape in a month or so :)


-- Ram
