From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 14/16] transport-helper: add import|export-marks to
 fast-import command line.
Date: Sat, 28 Jul 2012 02:06:32 -0500
Message-ID: <20120728070632.GD4739@burratino>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <2151883.HpdNaV7ITK@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 09:07:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv17N-0000g3-20
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 09:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab2G1HGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 03:06:38 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51586 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab2G1HGi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 03:06:38 -0400
Received: by obbuo13 with SMTP id uo13so5470396obb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Oeqg86Jw4asDS/BoXno4bz7abCT4tGql0OhS+8bFI10=;
        b=OyRcQOfXuzgtm+pIys9fOrezIZb5CUDie08mGHyd3BTMfXxjmtEwpPDJkvOU2+v3xv
         6fyRWQXef1a4um6BDuxBbeDydVBV0bibd52hc2Mpd6OoY51eFjKo8EdurN0LdAI9zgLr
         je05huRFcuj+FETKawDoiQKG9hNo97sy2gS3sJhc9A5Y+HnAozFDHNUhAs9m5laq4+9I
         DTuojaS2VG5SK224oWMEa9rvZHe6ZbL7S5CyBq2vSjUPjIeNl7YrMxuV9FSwb5eok7Cl
         jFkTkNqpFYNd0HxPpB66/nP2swvy8n6JDEHv2oa8lc3Ko1WvN9skgQm1IGcY9df/c5eG
         d4Eg==
Received: by 10.50.207.65 with SMTP id lu1mr3920041igc.33.1343459197180;
        Sat, 28 Jul 2012 00:06:37 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dw5sm1165786igc.6.2012.07.28.00.06.35
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 00:06:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2151883.HpdNaV7ITK@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202408>

Hi,

Florian Achleitner wrote:

>           a515ebe9.
[...]
> Btw, these added capabilities are not mentioned in Docs.

Sverre, any hints about how these (capabilities "import-marks <file>"
and "export-marks <file>") are meant to be used?  Why would one use
these instead of "feature import-marks" / "feature export-marks"?
Should there be a corresponding capability for relative-marks, too?

Curious,
Jonathan
