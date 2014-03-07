From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 02/11] trailer: process trailers from stdin and arguments
Date: Fri, 7 Mar 2014 07:19:15 +0100
Message-ID: <CAP8UFD3pg7xeFok6wKPc=iP3D87qhZwyOJm=kiUnAj09NcUJKQ@mail.gmail.com>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
	<20140304194810.14249.7378.chriscool@tuxfamily.org>
	<xmqqiors1cn4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 07:19:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLo7u-0006xP-1C
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 07:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbaCGGTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 01:19:16 -0500
Received: from mail-vc0-f169.google.com ([209.85.220.169]:64138 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaCGGTP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 01:19:15 -0500
Received: by mail-vc0-f169.google.com with SMTP id hq11so3855391vcb.28
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 22:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uyzp44agjOGoIuqLBfOihWlmrNaJx2dpvibC5Oc6Q58=;
        b=HAe+N5OZtyVuDWquqBUKNSJg6eO5PpGFUXGdAuIjo9MSrvlv9L69Akx4GA94tABprO
         E+xdVfxZZj/olLtK7/CHWvZcxA+cALfc6MB2KuQ9mYST+YorKQCydtYmPcC+Zq0KWz/Z
         wKpehzV5dGJf5rNAR+ufQh6oOU+oTtqhF7npBjqJeHpCz4NysyBR0XbU9IBOCJyruh38
         laSGdJwe4Q+IQl03L8E9Wcb9yH19ppl9jlzoABPn0+t7+cD0mzWOZjmc3O/+JzPMYe0I
         +O86hAzvKbUX3OfmfMqpCA31BE8+zTo3VNEfHFP0Y1j6/YBSl1mlUMHX0tneXafRtX8F
         4Nbw==
X-Received: by 10.58.165.68 with SMTP id yw4mr8979912veb.17.1394173155162;
 Thu, 06 Mar 2014 22:19:15 -0800 (PST)
Received: by 10.58.104.129 with HTTP; Thu, 6 Mar 2014 22:19:15 -0800 (PST)
In-Reply-To: <xmqqiors1cn4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243588>

On Wed, Mar 5, 2014 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> This round is marked as the sixth, but I still see quite a many
> style issues, which I expect not to see from long timers without
> being told.  Somewhat disappointing...

Yeah, I don't know why, but these days I find it very hard to review
style issues in my own code without being distracted.
And by the way is there a good script to check them?

Thanks,
Christian.
