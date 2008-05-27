From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Tue, 27 May 2008 14:58:23 +0200
Message-ID: <8aa486160805270558v40e7faabh7d4426731693f917@mail.gmail.com>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
	 <alpine.DEB.1.00.0805271151430.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 27 14:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0ym8-0002v8-7o
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 14:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701AbYE0M6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 08:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754835AbYE0M6o
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 08:58:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:34317 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbYE0M6n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2008 08:58:43 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1598448ywe.1
        for <git@vger.kernel.org>; Tue, 27 May 2008 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O+/53mGqllx/H1WcQwWCegaB8ZxVGl70Jboq7BlZ7Ss=;
        b=SvzIvfovV1jC8JxwIpPhRi7gMXl1y/v4m/ciEhTNHMAPMOgxFmQCeQAQY6RpDH04MX7lFPMynOA1tyIyh1lVcb1KVRy8eXsChT+C3FNCfpwg3UwT5o/PfY+N7u7zSsT0Xp7+KrZC3ZsvAW++JdextWNB4wUpdNIE9RrwQuLJJoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gkOjnici/aQo4GSl9pgRGxaB9ar9qBoPm0onCwSMJPpKtR7vhiG36tkYfuiT4mLtdNz0Yw9FDQlvb92yuEnubYHjdlldpQB0xzazbsQqp1nzzF6Wvi/J6S+WBqwxqCE11nKN4glK5RFpMil5J0IJ5aKwj5asThai/KrTR39bKtQ=
Received: by 10.150.86.10 with SMTP id j10mr894310ybb.213.1211893103449;
        Tue, 27 May 2008 05:58:23 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Tue, 27 May 2008 05:58:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805271151430.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83009>

On Tue, May 27, 2008 at 12:53 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 27 May 2008, Santi B=E9jar wrote:
>
>> In case you don't know the next step, if it is "git commit",
>> "git commit --amend", "git rebase --continue" or something else.
>
> We had a patch similar to this already, but I think that the right
> approach is _not_ to teach the single commands to explain their state=
, but
> to make a new script guessing the current state.

I think it belongs to each command to know the state, but I have no
problem with the single command approach.

>  AFAIR we have something
> like that in the completions already, as an (optional) prompt.

Thanks. And they do it a bit different, I'll use it if it is better tha=
n mine.

>
> However, I think it would make sense to push for that
> .dotest,.git/.dotest-merge -> .git/rebase change _before_ having anyt=
hing
> like git-whazzup.sh.

That's a problem of the single command approach.

Santi
