From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Mon, 30 Sep 2013 12:33:43 -0700
Message-ID: <20130930193343.GW9464@google.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
 <20130924045325.GD2766@sigill.intra.peff.net>
 <20130924183958.GK9464@google.com>
 <CAMP44s0UcP5AhWrm7vjBDLvY6CupzL03kys1YXs9cpGJNxkBBA@mail.gmail.com>
 <52479C04.8060000@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 30 21:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQjE8-0000t8-7x
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 21:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab3I3Tds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 15:33:48 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:38001 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab3I3Tdr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 15:33:47 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so5929602pbc.7
        for <git@vger.kernel.org>; Mon, 30 Sep 2013 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=b7FLfmpeUlU9y9+3yV/CTo9zverTht5Zz6wDbPLslWI=;
        b=n0OlBJHF1KF7swd9OK4sScjZaNoWNXJt7p7csCejniBdqK/oeCJ3mKPzuxUVvYH9PW
         NHrupz62Dg68cFCCX7LeyReELyOLoAyXsf0O2efKAyT2n4Ruwgv5NU/K7ef0JRKyZiU4
         sOHK5DrnoLRv8AzrWmOAEdlIjrh+AxRzleHyUVaXOI1rpF5g2PO+6QU3fGyzAb4/670n
         nuG4qiIAwaeCoRl4yvlFNrHtilDp3EUJlVNM9D1vUwe8affiBhcLuO/TGkQkb02kzBJL
         lfZbwfTyVIu3J/6Qpt74mnc/d5QH1xcP+aDmFmhVVJhze0qJEZfIcQ9qaJRPIAuPov8D
         M4ZA==
X-Received: by 10.66.187.34 with SMTP id fp2mr29489048pac.12.1380569627388;
        Mon, 30 Sep 2013 12:33:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id jj1sm2339308pbb.17.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 12:33:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52479C04.8060000@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235623>

Michael Haggerty wrote:

> That being said, independent of aliases, there are many other config
> settings that can affect commands that might be used in documentation or
> scripts, and which also could be the source of errors for the non-vigilent.

Yep, this is a problem, too (I'm looking at you, "git push").  We try
to avoid this problem or balance it against convenience by being
careful when adding new configuration, but sometimes we slip up.

Thanks for your thoughtfulness.

Sincerely,
Jonathan
