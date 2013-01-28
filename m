From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/11] unify appending of sob
Date: Sun, 27 Jan 2013 19:48:31 -0800
Message-ID: <20130128034831.GQ8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 04:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzfiO-000595-Tx
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 04:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157Ab3A1Dsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 22:48:38 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:42384 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab3A1Dsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 22:48:37 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so1033670dak.34
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 19:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0zkchCEfhbur8Ri54IL1Vn+/ZHIUO0QT29gsTHfbLL0=;
        b=g0HvYwlJg6bGdc3TQqw4G/FXFx73XksOzpM2M4qYc5yNY1I5PesLEAFKSMct8oZ5Ui
         sfJ1ExnqnB98mpc/Jhf1URpmBipMu2DByIe4BqI3VQCln0bQGHo5fpACRdWdlZE1BTHG
         GtCwrpFtwAorIQzMNChu61ZocFGD1AaB/vB4De4vs8vNJVSZJ/cD1KPebdM3tHeGaxUF
         ay7FN5J7CW9Ogpu55t512Pp0VU13M6S3V/B9jwPdQlQ1rQWzVPoJH+UWVMUTkwQO4t1f
         hyGAOM2iiLjaKPLon7i3bb3czgGUpjhUMG99JBcIX10sZllOgBw47rHAcRz1VX2w7dd6
         EOMw==
X-Received: by 10.68.230.101 with SMTP id sx5mr34505326pbc.50.1359344917388;
        Sun, 27 Jan 2013 19:48:37 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id d8sm5854883pax.23.2013.01.27.19.48.35
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 19:48:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214800>

Brandon Casey wrote:

> Round 3.

Thanks for a pleasant read.  My only remaining observations are
cosmetic, except for a portability question in Duy's test script, a
small behavior change when the commit message ends with an
RFC2822-style header with no trailing newline and the possibility of
tightening the pattern in sequencer.c to match the strictness of
format-patch (which could easily wait for a later patch).

Jonathan
