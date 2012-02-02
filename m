From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.9
Date: Thu, 02 Feb 2012 12:50:14 -0800 (PST)
Message-ID: <m3y5slark1.fsf@localhost.localdomain>
References: <7vipjwzvc2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Thu Feb 02 21:50:30 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Rt3bv-0000Oe-P6
	for glk-linux-kernel-3@plane.gmane.org; Thu, 02 Feb 2012 21:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab2BBUuS (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 2 Feb 2012 15:50:18 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48621 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448Ab2BBUuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2012 15:50:16 -0500
Received: by eekc14 with SMTP id c14so913651eek.19
        for <multiple recipients>; Thu, 02 Feb 2012 12:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=eLUiuWdTy5CkSk1XB0dKKZ49G+d4v8fX2G3C9AZgeVI=;
        b=bDQFrtsrVvvUldetULbEyvgE2gtgkG06ibd58QVcPengi3Jwf8LVUhC+b+aj6zD+3K
         FRxGXkyqEjN6GjRi29z9o6HzWukRIVOGwCzeY8sZIvV+o/OZ9b5e+R3s1/o9Ft9UBmnI
         uOXWZedfST0wcISNsxqJMaNvYYkpUeGD1GPSw=
Received: by 10.14.119.202 with SMTP id n50mr1388378eeh.120.1328215814885;
        Thu, 02 Feb 2012 12:50:14 -0800 (PST)
Received: from localhost.localdomain (abwd54.neoplus.adsl.tpnet.pl. [83.8.227.54])
        by mx.google.com with ESMTPS id c16sm13364344eei.1.2012.02.02.12.50.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:50:14 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q12KoNE3029160;
	Thu, 2 Feb 2012 21:50:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q12Ko6fV029150;
	Thu, 2 Feb 2012 21:50:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vipjwzvc2.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189707>

Junio C Hamano <gitster@pobox.com> writes:

> The latest feature release Git 1.7.9 is now available at the usual
> places.
> 
> The release tarballs are found at:
> 
>     http://code.google.com/p/git-core/downloads/list
> 
> and their SHA-1 checksums are:
> 
> ed51ef5ef250daaa6e98515cf2641820cd268d4c  git-1.7.9.tar.gz
> c7b1fa20dc501beb2cb5091dd24dbfd2a0013a0c  git-htmldocs-1.7.9.tar.gz
> 1ca1fc430b2814f9e9cf82ec3bf7f2eaf5209b7a  git-manpages-1.7.9.tar.gz

When trying to rebuild RPM out of tarball with

  $ rpmbuild -tb git-1.7.9.tar.gz

I get the following error at the end of build phase:

 RPM build errors:
     Installed (but unpackaged) file(s) found:
    /usr/share/locale/is/LC_MESSAGES/git.mo

Shouldn't this file be put in git package, or in separate 
git-i18n-is / git-i18n-Icelandic RPM package?

-- 
Jakub Narebski
