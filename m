From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: add submodule.* to the big
 configuration variable list
Date: Thu, 15 Jul 2010 18:12:43 -0500
Message-ID: <20100715231243.GA8270@burratino>
References: <4C3DD7EF.6010805@panasas.com>
 <20100715074155.GA22244@burratino>
 <20100715075119.GB22244@burratino>
 <201007151134.56090.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Git Mailing List <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 01:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZXce-0007ff-SP
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 01:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934951Ab0GOXNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 19:13:39 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64297 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933661Ab0GOXNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 19:13:38 -0400
Received: by qyk38 with SMTP id 38so258818qyk.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BWwKo7TSMX/I0sBx1yWvQTjow1Md5D9LKz4zDIJvRZ4=;
        b=wwTuKxwTR8yPb+ubE/YavSJe7mp7e+5M87d8jrEKs/TXckB3sKfH2rYIrv1kptRpPt
         dmph02sdKv7IHWSX/0zdrtounStj/GiE/tpDrOH0jmK9IUVqcaUq6uFE5u4ymfgHlr/s
         siBJ7aLTuGSC0mHqnaspOA+qxq2BYKXVkLgw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=gUOnZD4NbLeD5Gi51culE4yt1FwvDOqbcmTyEiDZfLdffFWQd9+0JlMMut+P8spXd2
         aQIFnLJNEGPQXhUAHEcW9zXGyP/9CZfIKqPr4mpOkZvSV41gZkS0dix6fU+RI0qyNoyu
         E3DNn/gRzuUhI169a3L7DKIhF4RNVucq1LR78=
Received: by 10.224.59.223 with SMTP id m31mr165302qah.207.1279235616069;
        Thu, 15 Jul 2010 16:13:36 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id i26sm6924032qcm.43.2010.07.15.16.13.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 16:13:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201007151134.56090.johan@herland.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151128>

Johan Herland wrote:

> May be more legible with:
>=20
>   The path within this project, the URL, and the updating strategy...

Thanks, Johan.  I=E2=80=99ve pushed both patches out to
  git://repo.or.cz/git/jrn.git submodule-doc
including that change.

Jonathan Nieder (2):
      gitmodules.5: url can be a relative path
      Documentation: add submodule.* to the big configuration variable =
list

 Documentation/config.txt     |    9 +++++++++
 Documentation/gitmodules.txt |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)
