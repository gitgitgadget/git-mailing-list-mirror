From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: Display the date of a tag in a human friendly way.
Date: Sun, 3 Feb 2013 12:12:17 -0800
Message-ID: <20130203201217.GB3221@elie.Belkin>
References: <1357314431-32710-1-git-send-email-wildfire@progsoc.org>
 <7vhamwse2c.fsf@alter.siamese.dyndns.org>
 <CAM1C4Gm_ea8DgrVhnp_MHmqaF6pyDe98EDA_BPkjvc8M5AO6FQ@mail.gmail.com>
 <7v1udzqv1v.fsf@alter.siamese.dyndns.org>
 <CAM1C4G=mKzfgrfO-n_yXjyDkZ9vA7H6kQEY5Yja-5C-YRRLmyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Sun Feb 03 21:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U25vm-0006Oy-Uv
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 21:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab3BCUMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 15:12:24 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64778 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab3BCUMX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 15:12:23 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so295165pab.18
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 12:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DD3PTwHqE8zCq8onpQnCqRXXZD9ZQSslME9heQduWtI=;
        b=Kr77JzJD+yM0syQirQOBBR+YGh6f2ZlkbJSt+M1nVRZjqmB8VUZKnDP9w/NFhJp7Em
         xCRXKTXPjn9ZdwgEWcoEVIZ9kRNlxiBXtcJSdL+6tH5O1YwxZBRSBOaLR34X0MWm6yco
         lHwNW6nhaUPli0Ou+lzvgNzW6DAAaHwMu/CLyeqdfCULJnP4r1es3QArRxgsKTU+/0cd
         alg6FTSXvdxK0Qj5h3vY9OpMebp2yqj9Z9rF1+ooLXoClHKNG4gns1fIH+gJFk+M7EZc
         I1WTEbP8fpop3kANnl6y+uWfIPtQtHIBjrGhG38sdkFO3FaXKVdfoHKXZipfEQUKGJr9
         Y2tg==
X-Received: by 10.68.242.41 with SMTP id wn9mr49761983pbc.142.1359922342084;
        Sun, 03 Feb 2013 12:12:22 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id b3sm13868316pax.14.2013.02.03.12.12.20
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Feb 2013 12:12:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAM1C4G=mKzfgrfO-n_yXjyDkZ9vA7H6kQEY5Yja-5C-YRRLmyw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215330>

Hi Anand,

Anand Kumria wrote:

> I've not been able to find the canonical location of your gitk repository.

Here's how I find it:

	$ git clone git://repo.or.cz/git.git
[...]
	$ cd git
	$ git log -1 --oneline -- gitk-git
	ec3ae6ec Merge git://ozlabs.org/~paulus/gitk
	$ cd ..
	$ git clone git://ozlabs.org/~paulus/gitk.git

Patches, including documentation patches, go to git@vger.kernel.org,
cc-ing Paul Mackerras.

Hope that helps,
Jonathan
