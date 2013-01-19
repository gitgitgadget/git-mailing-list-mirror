From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Sat, 19 Jan 2013 13:49:22 -0800
Message-ID: <20130119214921.GE4009@elie.Belkin>
References: <50FB1196.2090309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tomas Carnecky <tomas.carnecky@gmail.com>
To: Eric James Michael Ritz <lobbyjones@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 22:49:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwgIP-0007Cr-8F
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 22:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab3ASVt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 16:49:28 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:33194 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab3ASVt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 16:49:27 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so2664102pbb.29
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 13:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=nyj2RMXFrUsCGksGZ9OsQvDnCfqm+zwhsVjeRV6xOWs=;
        b=iQWGJESEsaNe4O+ESHD2ZU9UZDcZA2FUw1iZ4/Jyeg8ZXh3/lZhHaKuVKtU15SJ0ha
         w670DLZSIXbhNHdssqXnqF9S0nKlFJIXOO9CugFU5frQoXm6vGXx09pbQTw7E8euUqC4
         /ouY6+v9UgVaaucSU92SwBLKYgbwPiQClvdfiswExFMNeHzCaHb50+pavT1mn0IQ30un
         xvwn1n+pKytOFtZEhnSN0tLAcoo5wMpO2PQKB630a0mEjybqfjuWtY0cdBFOgwPD134+
         pUG12b6EIfUMIpI/TikQABg4xEJxeqXFNjiGg+NeQgVjQQG3FiSIKIrMbXEn8anUMl5p
         Acsw==
X-Received: by 10.68.131.73 with SMTP id ok9mr17915578pbb.83.1358632167010;
        Sat, 19 Jan 2013 13:49:27 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id e6sm6053013paw.16.2013.01.19.13.49.24
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jan 2013 13:49:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50FB1196.2090309@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213990>

Eric James Michael Ritz wrote:

> When I came to my senses and realized that does not work I began to
> wonder if `git rm -u` should exist.  If any deleted, tracked files are
> not part of the index to commit then `git rm -u` would add that change
> to the index.

I like it.  If you have time to write such a patch, I'll be happy to
read it.

Thanks,
Jonathan
