From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add --exclude to git-clean.j
Date: Mon, 19 Jul 2010 11:14:14 -0500
Message-ID: <20100719161414.GA17597@burratino>
References: <bf4ea4e83162ebf1d915b87413aad54a1162a637.1279554580.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 18:15:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oaszx-0001Vj-Jo
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 18:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936378Ab0GSQPO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 12:15:14 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47163 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936320Ab0GSQPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 12:15:12 -0400
Received: by wwb39 with SMTP id 39so359004wwb.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nKdMJMQ0g6d2rTP9+5DvqOf5HIKZyLu9q8ur/MinJNg=;
        b=WENlHggFN4rNOfBL6J6Kstb67ZhTWadfJm2VsEEAKJqktcbbAIA5B+lkTnGCFly2ms
         CwKoeXhBH/Cr4ds/OQ3hAt+BCKUrPDXxPpZIp6DDsIM+Ki1ke9qyU4aDZbEM7bo5R+fo
         rNCEf1JbJ3Vv2eMbykqnx1+zU+FAq+f6kwk4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YGR8z8MAp8G981tBbWXRWZvIkx3V58jeOYxeJ+kooUMYqfoOTpFTz2s4HuONP3DA7r
         TLmMSDGHfXRZVPMyf6OaWK8eI8QTDPCTVShCdemE9Y883Gfag0k+xT8qLZPP8Zq2VGgg
         bXoKZqftH79uU8amy1AWRJPWiRiOmmcyr+MS4=
Received: by 10.227.145.145 with SMTP id d17mr3548136wbv.148.1279556111315;
        Mon, 19 Jul 2010 09:15:11 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b18sm41989679wbb.13.2010.07.19.09.15.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 09:15:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bf4ea4e83162ebf1d915b87413aad54a1162a637.1279554580.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151254>

Jared Hance wrote:

> With the -e/--exclude option for git-clean, a user can specify files
> that they haven't yet told git about, but either need for a short amo=
unt
> of time or plan to tell git about them later.

No thoughts on your patch, but have you looked into =E2=80=9Cgit add -N=
=E2=80=9D?

Jonathan
