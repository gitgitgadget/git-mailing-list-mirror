From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: dependencies for vcs-svn tests
Date: Sat, 4 Dec 2010 13:23:30 -0600
Message-ID: <20101204192330.GA28181@burratino>
References: <20101010055032.GA23100@burratino>
 <7vmxqjngin.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 20:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POxi8-0004pd-2Y
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 20:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272Ab0LDTXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 14:23:50 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40328 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab0LDTXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 14:23:50 -0500
Received: by ywl5 with SMTP id 5so5348731ywl.19
        for <git@vger.kernel.org>; Sat, 04 Dec 2010 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n1CqC3jdfKil3COduptUWScQGUAGBtPs8lnnQ6LW1Mc=;
        b=f8L8tBIUaoTIxv6cRjJWIAJd3LP8MNOTU8Pog+N7YXtgXBlwsbff6xyK+9HJ5z+1/4
         f5od1XZA5K1LpgRMzpKWSodkaESN9vcuBfiJ7zg6JVJwrCE+kkucofRHVbuKiSmKtWOy
         TdMElgu7SxVOGyi+zGTlV0WgwuBsAxHTvWkxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RFxI38XfKb0Aqj2+Xzicre57DhJSRZmjYg+ClOYgwC/+ixrfpMnwepSObQ8vqEeaiD
         ao+k1HHTDuoZfM8IV5nX5uTyKTt5+QG68PhR2GmMM0Wpe3Dp/5a8pd2Wiu0Ca5ZJvucx
         /CPi6ehcJQ1MFLGqIhmu4AYE8YpAJUDNUWD+w=
Received: by 10.150.147.11 with SMTP id u11mr3461126ybd.207.1291490629488;
        Sat, 04 Dec 2010 11:23:49 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id q31sm2128243yba.6.2010.12.04.11.23.47
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Dec 2010 11:23:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vmxqjngin.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162900>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The vcs-svn tests (test-treap.o et al) depend on the vcs-svn
>> headers for declarations and inline functions.  Declare the
>> dependency.  While at it, declare a dependency of the vcs-svn
>> objects (vcs-svn/string_pool.o et al) on $(LIB_H) to reflect use
>> within the vcs-svn library of git-compat-util.h and cache.h.
>
> Thanks.

What happened with this patch?  It doesn't seem to be applied
in pu.
