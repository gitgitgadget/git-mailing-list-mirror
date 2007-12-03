From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: [REGRESSION ?] git-remote "--mirror" option is not integrated in 1.5.3.7
Date: Mon, 3 Dec 2007 09:32:00 -0400
Message-ID: <31e679430712030532p12e1f0f5x7e10bd0a1fdf9ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 14:32:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzBPM-0000lt-8J
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 14:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbXLCNcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 08:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbXLCNcD
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 08:32:03 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:31355 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbXLCNcB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 08:32:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5169804wah
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 05:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=nZX18XHyuecpPmm46p3U7OB7mb3tKwmpj9KLtyhduzc=;
        b=UttKj2jTUU5c65W/n+oKY3wBhzAVM/pBNvYXgfJyqYTQJCZcbDCX8q+0Nd7Ugi7JDId3SFE1LT5CicgAG0qIK3AqIjWhc7VehYJVNHmlIxZdQXBv7ki6UVqjJuSsWtytcIeczoKBUVrBDurq3Be61rqJpvXsKm0SykNTw79yL0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=ApkHGd+OrQygR9CUbc6ScTTIQzKm4kO2YJNMzjkqJdVf+LWokuMkD156cC51fHZlE3EpfEn6u4XgRGWIfI8sSf5Wqy6imzhVK27DRJzEQu3meTc5Up2kqJkWTMYEcAQI4L/QFykzgUP0ZzKaWPFtkiNuF7uXc6AFhssMbmk6+7I=
Received: by 10.114.120.1 with SMTP id s1mr3115721wac.1196688720485;
        Mon, 03 Dec 2007 05:32:00 -0800 (PST)
Received: by 10.114.57.4 with HTTP; Mon, 3 Dec 2007 05:32:00 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: b8bed2a8c4cf1eeb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66919>

Hi all,

I've using git-remote --mirror mode for while right now but I saw it's
not integrated in v.1.5.3.7, is this on purpose?
I can still get it if I compile recent git's head
"36863af16e91aebc87696209f4f4780cf4c4059f".

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
