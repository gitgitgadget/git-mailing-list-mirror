From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: [PATCH] git-web--browse: improve browser support under OS X
Date: Mon, 11 Feb 2008 09:15:23 -0500
Message-ID: <76718490802110615j3017e17awcae2a04087984f0d@mail.gmail.com>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
	 <1202696664-1565-1-git-send-email-jaysoffian+git@gmail.com>
	 <7vve4wb3h7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 15:16:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOZSm-000051-UP
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 15:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbYBKOPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 09:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754677AbYBKOPa
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 09:15:30 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:4186 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbYBKOPY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 09:15:24 -0500
Received: by wr-out-0506.google.com with SMTP id c48so4000609wra.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 06:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=xMFUfMXlapDXIui0VASf+t474krStEawIABnS3y3Ylk=;
        b=AbqsPrDBSCBhpNHAT3TqUI0uV+HsGfY+30d6UwEN34/CXo9WHDstughrZ4VmwUW+43l1h5Yc2m4ghv1g+ts466Puzi6AHIK2zQbdmKK/56vBzc9Ph/IcpUBUYldmk37lq/GHzLTXdAKHuNbAVZ1JZjF3E3+jwXOK+Ct62f/YV0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JdU2KmTr1nHvPHjgFRSgHBdzEwhs1RwZVd0LnzRDr09VYVSIZR68cmTaMgRS9gclGXXZqfnZT3gRFgLC5DrI6GnM1enyKxyUF9okShk8CMEp3xZwM4paknITgTlMHGxpl4THYtp0byRvA9A21ox1aEgp58OPyC1Sc8FZaQKIlIY=
Received: by 10.114.80.4 with SMTP id d4mr27521wab.44.1202739323142;
        Mon, 11 Feb 2008 06:15:23 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Mon, 11 Feb 2008 06:15:23 -0800 (PST)
In-Reply-To: <7vve4wb3h7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 4feb45a66fe4c555
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73536>

On Feb 10, 2008 10:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Because we preprocess git-web--browse.sh to create the final
> git-web--browse to be installed, something like "open" that is
> not a user but a platform preference might be better done as a
> build-time thing, instead of forcing everybody to spawn "uname",
> perhaps like this?

Seems like overkill (over the original patch), but honestly, I'm happy
with whatever solution deemed appropriate, just as long as I can use
my native browser on OS X. :-)

> Also I wonder why the check for SECURITYSESSIONID your original
> had is not good enough for this Mac specific customization?

Well, I thought it was. I was just responding to feedback. I don't
have enough experience with the git project to have much of an opinion
either way.

Anyway, thanks for the pointers.

j.
