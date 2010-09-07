From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add test-string-list.c
Date: Mon, 6 Sep 2010 19:07:03 -0500
Message-ID: <20100907000703.GB32717@burratino>
References: <4f798daaf4631e00927b455b77919d5bb8fade03.1283653854.git.tfransosi@gmail.com>
 <20100905050254.GA6134@burratino>
 <AANLkTi=J_0XaVYUt8Umu3uW15W86wbWv-xCMuVGA7cUE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 02:09:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslkP-00020c-MO
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 02:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab0IGAJJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 20:09:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61606 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0IGAJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 20:09:07 -0400
Received: by gyd8 with SMTP id 8so1777025gyd.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yDlmcOWbUu4Kyjp6iSTrwHVHVLSsQG4Uzzr/1+NOGEI=;
        b=jM4gNtPwh1cVEJJBLJPyTXNldtOJoodp/KeIhskXbGdyMi3A0RuCIV5J6hIEuKnxxt
         v4G7uFY4JAFIySfCBX/nvxh4RPvxUldKlmzojgxAfQXQ96Rr1BQTRKE7SoDOBaWmYNyH
         7KzKY4+yR/vW7+FC6sSc9S/3JvNoqsySj1TPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FQS3Kss3fCbB1bkam8avVdyMtGWQBaaHGBtZhK4rr/ElGZRHQP4+abNP0mbsWZIZzW
         I98gXvbcqhAO702mgAx1pB7gfxBCD4Si5JV+7I4PTefuu6jSdnwNhx97eoV8mw+sxzUp
         6aAgTFQ92X/IO0RwXsK9uKcFSwPiiEPjZeAqY=
Received: by 10.151.63.28 with SMTP id q28mr412182ybk.183.1283818146616;
        Mon, 06 Sep 2010 17:09:06 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q25sm6637846ybk.18.2010.09.06.17.09.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 17:09:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=J_0XaVYUt8Umu3uW15W86wbWv-xCMuVGA7cUE@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155649>

Hi Thiago,

Thiago Farina wrote:
> On Sun, Sep 5, 2010 at 2:02 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:>

>> To make sure this example remains valid, wouldn't you want to includ=
e
>> a caller in the t/ directory so it can be automatically run? =C2=A0(=
See
>> t/README.)
>
> I read it, but I'm not sure how to do this. Maybe you could point me
> to an example?

t0070-fundamental.sh might be a good place to add it.

> It can be expanded later by anyone to test many other things though.

I suppose.  Edge cases for arguments, sorting, and _DUP versus _NODUP
semantics would be the main thing I would be interested in testing.
Maybe another day.

Thanks,
Jonathan
