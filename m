From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: http-protocol question
Date: Mon, 1 Dec 2014 19:34:16 -0800
Message-ID: <20141202033416.GY6527@google.com>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 04:37:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XveHA-0006gA-EL
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 04:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbaLBDeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 22:34:19 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:58216 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304AbaLBDeT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 22:34:19 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so14293453igi.0
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 19:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4mLEYWJqkf7P0Qm5opdFRtaL8s1Uubca4hZaiIusPz8=;
        b=CYdq+9jYoj+pDsI9l450NRJtiItysZta2r2758UwmOfVDKj6IMPEMdEulTI87t15Ta
         UscpCdraK/9HB/dC9MLrsAPjs7vWwspoJzi7hO/bzPIna8MYEQOZIiBrmDQA6r2I8xw+
         tUaUO70FPf5b2WTq48X5F1VZdThaiRbsTET6ngWOdZ3LI2yDuEgsw73Gm5YW90ZwcsZ+
         5IeU/+SsgvKCMGmXeeQcYfN0yUy3oJqApNpdt/bFXzM68XvD/RZmp5sVLrlZ13wI2d0N
         ljfTcUSpBUdLBR+q9NxR2M0TIG+kGP69zKCcDnmzgsETjbMOnlo1+TM5sLjI8+b64ZKQ
         4t8w==
X-Received: by 10.50.111.161 with SMTP id ij1mr50400088igb.9.1417491258518;
        Mon, 01 Dec 2014 19:34:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:adae:4a7e:fb33:5785])
        by mx.google.com with ESMTPSA id rp3sm1727861igb.1.2014.12.01.19.34.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 19:34:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260528>

Hi Bryan,

Bryan Turner wrote:

> Is there actually logic somewhere in Git that does that "MAY walk
> backwards" step?

Yes.  See upload-pack.c::check_non_tip and
http://thread.gmane.org/gmane.comp.version-control.git/178814.

Hope that helps,
Jonathan
