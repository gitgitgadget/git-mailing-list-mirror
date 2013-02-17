From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] contrib/subtree/t: Added tests for .gitsubtree
 support
Date: Sun, 17 Feb 2013 03:37:23 -0800
Message-ID: <20130217113723.GA9882@elie.Belkin>
References: <CALeLG_=ir-kBTYpsRr_Hf8q2UY2ZtjShbTkO_tH=YiWSskfPOw@mail.gmail.com>
 <20130215225624.GB21165@google.com>
 <CALeLG_nLz9Gfqcfk4EcWixRXbWC0x0GUVFDAKD20DGbkhRNWvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Sun Feb 17 12:38:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U72ZI-00005f-DV
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 12:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab3BQLhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 06:37:34 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:39628 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967Ab3BQLhd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 06:37:33 -0500
Received: by mail-pa0-f50.google.com with SMTP id fa11so2373567pad.23
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 03:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AcJHGMQhaKNA5gRVnGar5U4noK3FTFzWyrBo1wHwf1E=;
        b=lY3qdZAbDQg5USQPNDY/Rhb+yhhn67CW2ZspzmFX/LV4pUoDO8uzXREIi6qYF2lGGf
         DpBku2wG2dnMFXKqtNyUGyDMkUHbvyLxYhj9GDDaitQzZJZaJxL63bRTTzdw60yEs0vl
         hDLuiOpW07th32ocPFLbwYcZ9xZrs+4Awk6ph+a3Zy34a+qQbvvw5lecHfuseHIJx4u7
         d1Bs91W8VarSu+fULkiqFmSaK2BShrkW9q8hu7shUz4h4hK1ui333+6Q3g8evYq9JHCO
         uZJS2VGWHyL/btNOjTH9v0mpKlrSF3umBVBfPSQxEZWTa0naTI/8wDxAklzZXLHAZT1g
         glfg==
X-Received: by 10.68.213.200 with SMTP id nu8mr20947161pbc.46.1361101053175;
        Sun, 17 Feb 2013 03:37:33 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id bi8sm100084582pab.15.2013.02.17.03.37.30
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Feb 2013 03:37:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALeLG_nLz9Gfqcfk4EcWixRXbWC0x0GUVFDAKD20DGbkhRNWvQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216392>

Paul Campbell wrote:

> Is there was a better way to verify that the push operation succeeds
> then grepping for a SHA1?

IIRC then when a push fails, it will exit with nonzero status (so the
usual &&-chaining would propagate the error).

Alternatively, one can fetch, ls-remote, or enter the target repo and
use history inspection tools to check that the result is as expected.

Hope that helps,
Jonathan
