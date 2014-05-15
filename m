From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 11/44] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Thu, 15 May 2014 12:44:56 -0700
Message-ID: <20140515194456.GI26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-12-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:45:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl1aX-00017T-5h
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894AbaEOTpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 15:45:01 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55034 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891AbaEOTo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 15:44:59 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so1475853pab.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RrPTt2iupHoaQVa++7VXtJw6hgZExtZb6wWAg62SgnE=;
        b=x/eGNnv70W+e7ew9B0AsfIWntqsShoRj2QqHw+luPwv6cJ7D//GF8IgDbvOoLAg2T9
         E0qJDt7u76q4FXryKAzCje6jYcOhVuwI0doadGZ0uGigQmg8vLNDhPDhFd0ctUmoRaaS
         uh/RpqVHI09jpRakeOEm5XfKn5Lt1HbL/aQYQbOxO1ibDY2ih1v6qo8tqt0vaF9Ax6rl
         FpRZe4IEp01rDQ0CtJpja0SoJIw+Sj71xCbGdOGLboE63Ld3GL8vNyxDQsErjnRjB1p8
         sFEYI9ZScikO34Ke2ihY1CtAmFTHqRNFqkA1yOgr8ZbN3KsgK42v0JvqniYO2lc87ov4
         kIlg==
X-Received: by 10.68.196.202 with SMTP id io10mr14798570pbc.149.1400183098750;
        Thu, 15 May 2014 12:44:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id i10sm24700172pat.36.2014.05.15.12.44.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 12:44:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-12-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249194>

Ronnie Sahlberg wrote:

> Do basic error checking in ref_transaction_create() and make it return
> non-zero on error.

Same thoughts as _update().  Basic idea is good but would be nice to
have a 'struct strbuf *err' parameter.

Thanks,
Jonathan
