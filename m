From: "Kevin O'Brien" <kevin@kiva.org>
Subject: Re: git push
Date: Mon, 19 Mar 2012 09:24:58 -0700
Message-ID: <CAJmx4Nyk4nVn-iiw3HJCATycK3U5JACKCDzysCzN-Nrn8mZJBg@mail.gmail.com>
References: <CAJmx4Nxh_WzkO-S=SN9E=aODCrfs+QCig4sT+Q8eQ+Pv1hB2+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 17:25:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9fOV-0000nA-G0
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 17:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031363Ab2CSQZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 12:25:04 -0400
Received: from na3sys010aog106.obsmtp.com ([74.125.245.80]:58179 "HELO
	na3sys010aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1031218Ab2CSQZD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 12:25:03 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]) (using TLSv1) by na3sys010aob106.postini.com ([74.125.244.12]) with SMTP
	ID DSNKT2dd3ML0RGvsYlcE8fg3QGQesrCiP1fM@postini.com; Mon, 19 Mar 2012 09:25:02 PDT
Received: by werg1 with SMTP id g1so6148337wer.10
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 09:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:x-gm-message-state;
        bh=yLf47NVq54IBoPtoAl6hDp9cU0jsq+A0O/qWobWe1Po=;
        b=WOXbh8I0EdLRzfFWTGptw4xeU8mMels55rS+s1o/NKbMf1OJN7w5QH2/5Fk+BBYn5+
         517lPBooDvkFaTzWjL9xmLgHuOzNviQbiNG30hRyd17X7QD7M5oN+Q/wOZfmIJ4o3GrL
         KSoLZsFkhpHnSiJnlGliLtvM6zffKJE5IixfLD4u8PNZwcyNLRS+XlJ1vlT1qI4Ym0Rr
         HXtiMqrdnsA3ShbP6JnA8q+QyD4YdPmnOMxUlZO7dYvYZsFmOrzJctChLCiufbvxRIZc
         7SAA1aq/OrCprjfrRdhZMjcMjiPUpumS8x1Ad1VkaE6QlUD6FdlHv97qUNhDKJStB4QX
         kmdA==
Received: by 10.180.107.101 with SMTP id hb5mr19938634wib.3.1332174298158;
 Mon, 19 Mar 2012 09:24:58 -0700 (PDT)
Received: by 10.180.87.138 with HTTP; Mon, 19 Mar 2012 09:24:58 -0700 (PDT)
In-Reply-To: <CAJmx4Nxh_WzkO-S=SN9E=aODCrfs+QCig4sT+Q8eQ+Pv1hB2+w@mail.gmail.com>
X-Gm-Message-State: ALoCoQnSLL7r3S4gb9j2xmr36sPjcl/iqay7wK2Hpqi1ubswDp9bAhME0tCEEJsFycdv6kWAGGMH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193437>

I agree with your proposed change for git push behavior as described
here: http://lwn.net/Articles/487131/
I'm also going to go change my push.default in .gitconfig now as the
behavior described is actually what I desire.

We've recently moved to using git at Kiva, and so I'm also letting my
colleagues know of this change to see if they have any comments.

Thanks for public notice.

Cheers,

-kevin
Software Engineer
http://www.kiva.org
