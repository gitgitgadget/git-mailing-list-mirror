From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Add svnrdump
Date: Thu, 22 Jul 2010 00:33:24 +0530
Message-ID: <20100721190324.GC23839@kytes>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
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
X-From: git-owner@vger.kernel.org Wed Jul 21 21:05:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obebk-0006a0-2G
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 21:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758771Ab0GUTF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 15:05:27 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab0GUTF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 15:05:26 -0400
Received: by pvc7 with SMTP id 7so2725533pvc.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cyxcaK7w2f2dPECpfd1xRDFv/Wkt/9mOOCNWtaO2BD4=;
        b=pyvsdNLOOfx8qhEqcCkqprg1k9ycO4hNG/M/rAzEmBgNMalvCtIvYOGSVJ6uBjIrVR
         Wl8zVITuNASSdna/G/yrqwm8YhjhXVfuRiJvBxHj/TZ9jAEoMeOykXdfoa28wuMh96am
         ZLX2afIAM4+EB3D8pi4Rbf+qdlPgVw3aV3tHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PeX+4lf0bPVBII0MjlpUbGKmQ6INenhOFJWKGpuXw5M3UDVxT5s2M5rIIbo7HffAQz
         CRKQMNoro1C8Hz+nzTVHbZYt019mC49sj7Va8Q5osm6iXekwJXRWxOIqjYnFet3ECGTW
         BilxePm4MWQn39+EE7oB4OZdBC9KN+ioNZq00=
Received: by 10.142.231.14 with SMTP id d14mr751806wfh.129.1279739115288;
        Wed, 21 Jul 2010 12:05:15 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id k25sm19970285rvb.4.2010.07.21.12.05.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 12:05:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100713201105.GN13310@ted.stsp.name>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151411>

Hi Stefan,

Stefan Sperling writes:
> Copy of what and when? This baton is global for the entire edit...
> 
> Going through the code, I see that you're using this to indicate to
> dump_node() whether an add_directory() or add_file() was in fact a copy.
> Why not remove this field from the struct and add it as a parameter to
> dump_node instead?

This is an excellent catch! It's in the editor baton for historical
reasons- cleaned up with my latest commit.

Thanks :)

-- Ram
