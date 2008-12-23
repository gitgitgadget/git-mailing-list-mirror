From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: [RFC] Automagic patch merge ack emails
Date: Tue, 23 Dec 2008 15:46:27 +0100
Message-ID: <2d460de70812230646r181f59d0y55055e96ad6eda84@mail.gmail.com>
References: <2d460de70812220607j7f218ee3r7722bc8147a3dab4@mail.gmail.com>
	 <7v8wq8hs34.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 15:48:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF8Y6-0002dt-Ey
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 15:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbYLWOq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 09:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbYLWOq3
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 09:46:29 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:18040 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbYLWOq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 09:46:28 -0500
Received: by an-out-0708.google.com with SMTP id d40so835882and.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 06:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=V4H6C2Rjf1uliA7gqMZOUK6ix43kkJkjcj4BR1AQLvI=;
        b=Y7977FkYkEPZuAngzQIdQb1wqjx3vp/E9XEWmk0JNw7tEuYLcN5DtbTN4mYqoywqzr
         wtLb7CS2drQvbxZXmls9gkIV1OXBJaFV7qPKbuNz4I1zoTza8Ep218uJOYN79JRw7yTO
         pM92NcuYTyyYO0+vT1x7RMK6iFqI+rdXsvB0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XBHYByMtAz7QxMgn5u8Ar0ERxf8JLHdcZ1E5ZbuOhSxNu+6rZyOKPli7hVDKx47eKO
         634CqZg9B3K+dJK5OraLt+gOLYGB+/Z6P8nMlfb0ti4nN05v3x7ZoWGEZTOj2fdjFeW8
         1sgMfBMIdZE+9dAl8WotJruMTk8BWY4wveKqE=
Received: by 10.100.106.12 with SMTP id e12mr4609322anc.18.1230043587455;
        Tue, 23 Dec 2008 06:46:27 -0800 (PST)
Received: by 10.100.43.19 with HTTP; Tue, 23 Dec 2008 06:46:27 -0800 (PST)
In-Reply-To: <7v8wq8hs34.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103826>

On Mon, Dec 22, 2008 at 21:29, Junio C Hamano <gitster@pobox.com> wrote:

> The only time that it may make a difference to you is when things are
> pushed out to the public repository, and there is a mechanism for
> automating tasks after new commits hits the public repository: the
> post-receive hook.  contrib/hooks/post-receive-email may be a good example
> to study if you are interested (I use it in my day job repository, but I
> do not use the hook in git.git because the style of announcing I adopted
> on this list is to send out "What's in/cooking" messages once or twice a
> week).

That's pretty much what I meant, yes. As to the rest, I am still thinking
too much in VCS, not DVCS, style, I guess.
Thanks for your clarification, it all makes sense, now :)


Richard
