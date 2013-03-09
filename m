From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/19] spell checking
Date: Sat, 9 Mar 2013 12:25:19 -0800
Message-ID: <20130309202518.GD3908@elie.Belkin>
References: <CALeLG_=R4o1y-kA+n883nnAu+jrjgaA2ys2d+Vo9KasmVKeduQ@mail.gmail.com>
 <7vobese4rp.fsf@alter.siamese.dyndns.org>
 <CALeLG_kdYjFhZXWedTgr2zdzJfrGV6XmqT1qkMX9XpJgztnPcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	David Greene <greened@obbligato.org>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Sat Mar 09 21:25:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEQL1-0001K6-D5
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 21:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760Ab3CIUZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 15:25:26 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:51525 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab3CIUZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 15:25:25 -0500
Received: by mail-pb0-f41.google.com with SMTP id um15so2403392pbc.14
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 12:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YMKjLapGyjrBg5UNUBhuux5HeqCBOnB0CJ31ny6gMAk=;
        b=BuKOlXPa1cGUGXfw3X3v57jS0MuOfPQhVWmyqxfiktEHgKaEnyzXoYfKkw0CbulNMx
         wUq4q5w02BzfUdp6ZIHzzSDOhgF6FNKp/oAKw1bgvNnruMo5hPNbAh7bHK4SXDwO47wH
         ZHpVmnERVmYGdP/iINA/8FQvj74o+5e6WISutc6pPdgwHpjAqGJpI9t1F2eVpimvQsWW
         KTECEELKqRzKSk3IIfg8USuxoz0Uf2ntD87wX8PW42p3LPH1knS/Hrg2veSRHRymXEIq
         SC3h4JusRJxZ8CifUlZzUVkOEJsUrj2ppAN1eriaqSwGzjMVHJ6Ai4KqxQQVa6tEMXFQ
         elBw==
X-Received: by 10.68.11.35 with SMTP id n3mr13838482pbb.220.1362860724549;
        Sat, 09 Mar 2013 12:25:24 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id tm1sm11765347pbc.11.2013.03.09.12.25.22
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 12:25:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALeLG_kdYjFhZXWedTgr2zdzJfrGV6XmqT1qkMX9XpJgztnPcg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217761>

Paul Campbell wrote:

> Four of the eight original authors now have dead email addresses. As I
> found out when I started getting the mail bounces when I started
> sending these patches out. Would it be acceptable for those patches to
> leave the From line, add a Based-on-patch-by and then sign of myself?

It's always nice to get the original author's sign-off, but if you can
certify what's stated in the DCO1.1 (from
Documentation/SubmittingPatches) then just adding your sign-off is
fine.  Please still keep the original authorship in that case, and no
need to add a Based-on-patch-by line.

Thanks,
Jonathan
