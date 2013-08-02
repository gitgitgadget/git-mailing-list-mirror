From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [TIG][PATCH] Scroll diff with arrow keys in log view
Date: Thu, 1 Aug 2013 22:01:58 -0400
Message-ID: <CAFuPQ1LMJNhY-Lxx9-TnB+Z8hQXGEAY_xK8afZeSsHnG1JMoLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Fri Aug 02 04:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V54hR-0008IV-OX
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 04:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab3HBCCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 22:02:33 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:52591 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab3HBCCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 22:02:19 -0400
Received: by mail-ob0-f180.google.com with SMTP id up14so183688obb.11
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 19:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=5zRIrgbkylwviuX+oEXh6wRucgJfkoBDkBBPIXmYdps=;
        b=gv5UW/kJAU8isTMN78SbzGFzwIblm4tXG2Zlr5f2WwlfTIy/FaMafTRT/6u0oZ3dJC
         xBPT9E7rc+9RjFPi9q/MfOUkYhpEFeZoqzCiV3bi+BV12CiLmanCMg6GJXQceSvPV5Lg
         9H4XjCPuiUggNYkUFsd8sXPXIp1CTdvrEFap/dXs38HYcDe0S6mSrPVM0CCSfpB/1GgM
         sqiHPQ219WPDS6IQAY5AdyPhM5nPLKnrI4/NglPuEIg5ekNqHOlTdg6bqWoAwjnRYlc/
         9+D9td2FAA8XTP7YfE2RKEqUDpLn7b8smQI4j91WW09QmE+WMm/pAurrX1/++Vliu5a+
         /N2w==
X-Received: by 10.60.117.34 with SMTP id kb2mr3502694oeb.54.1375408939204;
 Thu, 01 Aug 2013 19:02:19 -0700 (PDT)
Received: by 10.76.69.169 with HTTP; Thu, 1 Aug 2013 19:01:58 -0700 (PDT)
X-Google-Sender-Auth: Nc23xVk6FmjCx7F_lY5ioicjZzo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231513>

On Wed, Jul 31, 2013 at 11:11 PM, Kumar Appaiah
<a.kumar@alumni.iitm.ac.in> wrote:
> This commit introduces the VIEW_NO_PARENT_NAV flag and adds it to the
> log view. This allows the scrolling commands to fall through from the
> pager to the diff when the diff is viewed in the log mode.

Thanks, works like a charm.

BTW, please remember to label tig related patches by adding '[TIG]' or
something similar in the subject so people on this list won't get
confused.

-- 
Jonas Fonseca
