From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.8.2
Date: Sat, 30 Apr 2016 18:01:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604301749590.9313@virtualbox>
References: <xmqq7ffgvzpn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, git-for-windows@googlegroups.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 18:02:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awXLK-0006Xk-P3
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 18:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbcD3QBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 12:01:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:53228 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbcD3QBs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 12:01:48 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LyEUz-1bhuoz2WZB-015cNt; Sat, 30 Apr 2016 18:01:40
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq7ffgvzpn.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:WNAtfpworovrqEMxFfwAKUj0wu3MNIeAbe/K6KBUxGQrnJtRb6C
 ZgUDib4fyPhOHY1mmi6QSQMbSQPT4cT7RdHL5zatH+peKQG7OYIcL0rROE+faicepW9GEJN
 eO8mnElqX5m9rkqXKf0FhPM52rp96S5jIADj6SzAzK8/cb8DQlzjJ4Ua6sBahrCGdN6k4w3
 ruPChLnsBgpa2zd+Vh49w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M0ivaJbgYx8=:79Gs2IBL+/WpikNqObkPO3
 Un1nL9lvD8pQWK6zd1hv6mYaBwrYafPF7FwQw45IKhjhykO3oy+CHB+LDE88SBtI2VMiaHl6g
 sBBkhVK1t5HUP73bR1J/9dwZi1kXgsoO8csnSGNou2Pm/dAKsXjIZWcTooDm+bNT51IabwblN
 xwHLHkdEM+S29Daijpk2WXnvoXEjEzyiu5DVfoQTMs/HeuwuqLdgZl3S8HZD3sRWso8GEtPSr
 NeRZucekbKINkT8x0ejPJmv/1jyGYJbnOS4L3zkHCYAmaWZajIpWqfvX3ffPwmBGliplqu0sC
 Sf3ZEvOWJnbthDvyfwuDzzNphjADwH5Y1WEo77w+fYE9hUMDebATsrTGV/YBOEfBrEn/w8D4V
 fdU3t94zFtJLJ+fTVFM79C1FM89snzCyQipnz5q5nAoosjtib9ozKxYibLXLmv3WSS2VmZxRr
 VBzV0hjAwOH4PBWJjK0dn28it/+nN+1d2fE442zHgLtmwhF22vq62PLWtuWHinJZeSl+wCaDW
 ZSGNB52er3Uv1XHPe95i+CtM78XOk6l5YrMj7ceO/j6FjmA0qHvytqt+RrZz3LMf20VcYIn9v
 0oAqIhBlmsHziAkEUbFv1PlHU62U7u6Ak4xrJi5noCHrnjWCwDFibiuYeWy+w8bYsBoMAj7L2
 E5aDGfD5fOeu3jlGtIiGCaWFkZ+bqaJb40DbHUoOLKrwSf297aIfTAwYbfuzwOIavzyx+r9Q1
 LS1zvs889UUd9DwD+xh3qiulhSLUQFKJE/fI6ZMUxnZItPCo2MhWiUrMt1Cfn/kuFZ5FE+eE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293124>

Hi all,

On Fri, 29 Apr 2016, Junio C Hamano wrote:

> The latest maintenance release Git v2.8.2 is now available at
> the usual places.

I considered releasing Git for Windows v2.8.2 today, too. However, I
decided to delay the release for a couple of days, for a couple of
reasons:

- I expect an update of the Git Credential Manager in the next few days.

- OpenSSL is slated to receive critical updates on Tuesday and I plan to
  incorporate these into Git for Windows' next version, too.

I will also use version 2.8.2 as an excuse to ship with support for the
extra HTTP headers configured via `http.extraheader`, which I hoped to
get into Git v2.8.2, too, because I'd like the feature to be available on
Linux and MacOSX, too.

In short: the tentative release date of Git for Windows v2.8.2 is
Tuesday, May 3rd, 2016.

Stay tuned,
Johannes
