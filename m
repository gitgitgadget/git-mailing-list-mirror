From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/14] Remove unused code from imap-send.c
Date: Sun, 13 Jan 2013 22:57:57 -0800
Message-ID: <20130114065757.GK3125@elie.Belkin>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:58:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tue01-0003m9-BU
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 07:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab3ANG6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 01:58:04 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62562 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab3ANG6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 01:58:03 -0500
Received: by mail-pa0-f47.google.com with SMTP id fa10so2061769pad.6
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 22:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TjGB6Deqph3LWQg6BTCPiaSA06B/vMKvDgMPXOwkl2U=;
        b=xmEWpPYZ9ePJhz+Y/DOJSiuEwazMJsilMtmSRo8wdKOkz+RLEwpy4T7gVyeImMX0WJ
         1mnpM/CXolgeUMqCeK8qRl+xyHpxnEGoC/lY0JoQaJmCpTRG1PkxNqnhC3ynAx6LW1+e
         ftV9WGDtfcB5BdZpw5+aMUzd2TQLwzVU1uG7IAhOTWzjaT/IMUYzsUjiD2b+2iG1DpmG
         FcgeyJncaQOC7FFNwe1wG5xGZ+m61cS10ArgbthPWPnR3TRCfbHrKmtM+D06SIumIqAm
         hF5dM/lhbFVdaE2Qakd24LROjfcPOg8xPm9KHGtRRVrc9/4zLaL8TSwECuwpSxd4+JBb
         DiEg==
X-Received: by 10.68.238.106 with SMTP id vj10mr256596955pbc.40.1358146681860;
        Sun, 13 Jan 2013 22:58:01 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id kb3sm7685372pbc.27.2013.01.13.22.57.59
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 22:58:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213456>

Michael Haggerty wrote:

>  imap-send.c | 286 +++++++++---------------------------------------------------
>  1 file changed, 39 insertions(+), 247 deletions(-)

See my replies for comments on patches 1, 6, 9, 11, and 12.  The rest
are

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

The series is tasteful and easy to follow and it's hard to argue with
the resulting code reduction.  Thanks for a pleasant read.
