From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Repeatable test t9010-svn-fe.sh failure w/ master (685e9d9,
 1.7.4.rc1)
Date: Thu, 6 Jan 2011 10:59:58 -0600
Message-ID: <20110106165958.GA11190@burratino>
References: <4D25E818.5050909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 18:00:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PatCM-0004at-7O
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 18:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab1AFRAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 12:00:18 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55233 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab1AFRAR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 12:00:17 -0500
Received: by eye27 with SMTP id 27so7271227eye.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QR6fVe2VakTBmRw2+kW+yKYYxmk6bU66KEhDNu//i3o=;
        b=K3w8jmIC1Tq5UwAjcmLYZu8ve4R2NeyVyymh8EYoSrFzb+n4pgJvLjWTCWRk6rFAc7
         f2mgOyiwISIFEp8Lq/ZYBEks1RgZaefyIntMsJ6FStcrTCtihU9/Kcdrf3ra7fdgJeH5
         rjCZl0UXXzTwgFMYVynDMFMSMydzBdYVkt+Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BTJMG4DSuDvbe2LGLPqIRo2S0NewSRB/2hfQN8Wc/Z21fmtwfcwybV89NjrrHpsRXU
         kBXjQC+rz27/gt1JN0/506CawFMmYWaKm0jOUbOvmufeHxlT0JCQtNzmtMPKSsJy0ILu
         FJNscG2j1VG/ZARrkS6bEWygqAW8xREtw+y7w=
Received: by 10.223.83.11 with SMTP id d11mr3730820fal.37.1294333215721;
        Thu, 06 Jan 2011 09:00:15 -0800 (PST)
Received: from burratino ([69.209.72.219])
        by mx.google.com with ESMTPS id f24sm5886925fak.24.2011.01.06.09.00.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 09:00:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D25E818.5050909@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164641>

A Large Angry SCM wrote:

> *** t9010-svn-fe.sh ***
> ok 1 - empty dump
> ok 2 - v3 dumps not supported
> not ok - 3 t9135/svn.dump

Thanks for reporting.  Unfortunately I haven't been able to reproduce
this on the machines I have access to (amd64 with svn 1.5.0 and i386
with svn 1.6.15).

Does running

	sh t9010-svn-fe.sh -v

from the t/ directory give an error message?  If not, how about

	GIT_TRACE=1 sh -x t9010-svn-fe.sh -v

?
