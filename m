From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [RFC/PATCH] Remove repo-config
Date: Tue, 15 Jan 2008 22:40:08 -0600
Message-ID: <478D8AA8.3070008@gmail.com>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> <7vtzles8j8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:40:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF04v-0006jd-UD
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbYAPEkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbYAPEkN
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:40:13 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:26156 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYAPEkL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:40:11 -0500
Received: by an-out-0708.google.com with SMTP id d31so25040and.103
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 20:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=iqD4kYcJdFn4SJcw72WCB7Ol6Vna4VixwsIlIlBVxh4=;
        b=BIw4LXdXw5oilk0ITDxQDWAqSpe7y1PXZD4WcUYn0vnMjIwMYSG1jrZ0fGwxhrxlylY+WnIa9u7TrZpHG/jxs5DciLVcdMy8fBT5F1zOGfhSJ1PwL9Dw5RTR5FyjGm4MxRy/I8240dcZypzvVSVhuyBf6TiN7Y7Z1A0VuuYDDvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IHdcsj/eQm27BeaaHcH7ly9S2QJ+K2uof6FX7O+Du3v/qtmOn5xUlKYp408FtwTE5J0s7WvM2OwOuHKabCDl19ycR3tvkWrh752qOwqmGcnQAxS67Bm0Wh0eSXwfOfElZM9axwebZiD115eF71jkSOiKp/HEjz7tQClQVzgx+jg=
Received: by 10.100.7.1 with SMTP id 1mr673616ang.81.1200458410683;
        Tue, 15 Jan 2008 20:40:10 -0800 (PST)
Received: from ?192.168.1.100? ( [76.197.238.51])
        by mx.google.com with ESMTPS id a13sm466505rof.9.2008.01.15.20.40.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jan 2008 20:40:10 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071212)
In-Reply-To: <7vtzles8j8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70630>

On 01/15/2008 10:23 PM, Junio C Hamano wrote:
> I do not think it is unreasonable to add repo-config to feature
> removal schedule in 1.5.4 release notes.  Perhaps something like...
> 
> + * "git repo-config", which was an old name for "git config" command,
> +   has been supported without being advertised for a long time.  The
> +   next feature release will remove it.
> +

Seems fine to me. Does it need to be put in command-list.txt for the time being too, or what all is that file used for? Sorry I am not familiar.

Something like:

git-repo-config                       ancillarymanipulators	deprecated
