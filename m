From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why there is no pre-checkout hook?
Date: Fri, 15 Oct 2010 03:30:22 -0500
Message-ID: <20101015083022.GA8763@burratino>
References: <87hbgn27f0.fsf@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w5NzY2Fy?= Fuentes <ofv@wanadoo.es>
X-From: git-owner@vger.kernel.org Fri Oct 15 10:40:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6fpw-00012q-1x
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 10:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab0JOIkK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 04:40:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62989 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab0JOIkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 04:40:09 -0400
Received: by gye5 with SMTP id 5so18765gye.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MwYI+oJOqq/qOlTbBP13AM62lTWDwGdc5CIFgQDGpyU=;
        b=F3fZUrARwv3iPg9KK4ehN9AsA7k45Psdr6Vo67el1cs40ZTccBRFHyEalW1npl02OS
         L98yZ6JjEP44ftVHdHQVbj8FMzGuCoBs/uRPUKCR5jAZl92sCPHJZWyKxYGRnmOdq62a
         +jSSLaHrgzK4sxCtwR7wbmXbQfVuH6BTsn/TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Z/m58NI+2OJl+ROlmGejeOD+ORHwvWlG27w3ykck7iY8OCo6OvyVnHiXbTxH195uie
         jjDS/HMB62DmQDjHuSJmY43DPEDnhZPaIjydUjSk/1OzUpVh8Vn3NfGpP/UUUbjN7oMX
         VBbqQuErCNA/GG+5fhqQxn2aeRMP82ZsWbkOI=
Received: by 10.100.154.13 with SMTP id b13mr4175896ane.249.1287131631875;
        Fri, 15 Oct 2010 01:33:51 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id g29sm15717627anh.16.2010.10.15.01.33.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 01:33:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87hbgn27f0.fsf@telefonica.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159105>

=C3=93scar Fuentes wrote:

> [Subject: Why there is no pre-checkout hook?]

Because you can use your script in place of "git checkout".

Or: because no one's come up with a compelling use case for
one.

Or: because no one implemented it and demonstrated how to
use it yet.

Take your pick. :)
