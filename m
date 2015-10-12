From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 09:46:33 -0700
Message-ID: <CF49BE6B-38E7-4552-B9C7-B7965E8A7881@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com> <1444586102-82557-2-git-send-email-larsxschneider@gmail.com> <CAPig+cQ4Gd6aNQdrdD7ZEJW2Mn=pJujkqje0-htJpJYz8LVbhQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Pete Wyckoff <pw@padd.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 18:46:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlgFL-0005Mo-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 18:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbJLQqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 12:46:43 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34361 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbbJLQqm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 12:46:42 -0400
Received: by padhy16 with SMTP id hy16so158263234pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d/ei8xCJAQvsL3V5cGVUF1KKkYL+mLcDFWOq+RImHCk=;
        b=yjH2enHy5fignlc07AAwwmnDrfwkftX7vZRIbYLAm0Pivat/KwYxCg1O4njNMNUlIf
         bUtOtHAAZMccg4MAcGjSSe+i/xYcTIz2JgMl97R1I/YIyRSHshVLsOBk3tmSZoLRzktH
         ZEg5PnuMjoXT4MTqMsbVl7Oo3wlJcJEWNlC/j9bOLcPJPp5+9+r5bj6mfrbjleZraKm7
         kEM6M7FFUVgguYrl/1tygtY6UVUfcbBfJEE9LvVZgQYEa0CZvvG9FYPG9q+2/pw3AnIn
         Lt+gosImDoHtGEK9yK4VLr+JcHcnFte3OQaM3h/IfTmJ8vY0hiCClkjBiN6mWoT8yzN6
         SXnQ==
X-Received: by 10.66.101.106 with SMTP id ff10mr36196446pab.100.1444668402080;
        Mon, 12 Oct 2015 09:46:42 -0700 (PDT)
Received: from sfo99wgxz1.ads.autodesk.com (adsk-nat-ip12.autodesk.com. [132.188.71.12])
        by smtp.gmail.com with ESMTPSA id po4sm19262957pbb.64.2015.10.12.09.46.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 09:46:41 -0700 (PDT)
In-Reply-To: <CAPig+cQ4Gd6aNQdrdD7ZEJW2Mn=pJujkqje0-htJpJYz8LVbhQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279382>


>> +      brew_force_set_latest_binary_hash () {
>> +        FORUMULA=$1
> 
> Is this spelling intentional or is it a misspelling of "formula"?

This is a misspelling. I will fix it.

Thanks,
Lars
