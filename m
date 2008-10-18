From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: What is the pre-merge hook status?
Date: Sat, 18 Oct 2008 23:57:15 +0200
Message-ID: <48FA5BBB.8060406@gnu.org>
References: <c6c947f60810172342n6843b173tb0019d0af706800d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 23:58:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrJog-0002Ji-2G
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 23:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbYJRV5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 17:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbYJRV5U
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 17:57:20 -0400
Received: from mail-gx0-f29.google.com ([209.85.217.29]:40606 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbYJRV5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 17:57:19 -0400
Received: by gxk10 with SMTP id 10so491954gxk.13
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=v+f6chP4OPZiWCkZdqSqxeWNjt3UCvz59R/ijhp89Kg=;
        b=xBSeQbsrHCIbsBx3SvbacWTyhfAPozTlGDZDLxBxi/EZuiRhagRN0Na8Vt4kJHYq3q
         oNlv6cWysOoErCv3R0gyIvGoHVFtVbgnvtz8NaO9dfujfUVutEmz3YFBdo2jXvQZ/wZf
         A4w9UzvAcXnUQHan7VGKpuYpAoyEfKjqpXz+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=LSeN+6OPR84XpJU0U0hoSQwXA0FCbv0M3N+RwNTssrMJpkh7R7wN/QnqZ4gVVAys0o
         qKE0BIn+WZAQWpzAyf7I4bgRs47RRynmnghjdyiYM73l6KPP2b1TUbqMdfiC0IqIGXRg
         jYtdtPPAwMUXHXiu2Fn08Udi8yQgWY6i+M4YI=
Received: by 10.214.9.8 with SMTP id 8mr7762855qai.51.1224367038227;
        Sat, 18 Oct 2008 14:57:18 -0700 (PDT)
Received: from 187.0.71.10.in-addr.arpa (70.43.3.242.nw.nuvox.net [70.43.3.242])
        by mx.google.com with ESMTPS id 33sm5950645yxr.3.2008.10.18.14.57.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Oct 2008 14:57:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
In-Reply-To: <c6c947f60810172342n6843b173tb0019d0af706800d@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98575>

Alexander Gladysh wrote:
> Hi, Paolo!
> 
> What is the status of your pre-merge hook patch?
> 
> http://article.gmane.org/gmane.comp.version-control.git/93888
> 
> I think it can help me greatly with my repository management process.

I decided that it was a bad design for me at least, because the control
had better be implemented on the server (using an update hook).  But I
can submit it if you need it for something.

Paolo
