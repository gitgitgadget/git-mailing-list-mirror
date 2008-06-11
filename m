From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-daemon on Windows?
Date: Wed, 11 Jun 2008 12:41:41 -0400
Message-ID: <32541b130806110941n2b8c880bk79fb09db3f089f82@mail.gmail.com>
References: <63c5d3820806110551y69e895eeg4fde4bfdaf22bbf2@mail.gmail.com>
	 <m38wxcrtjr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Chris Hoffman" <chris.c.hoffman@gmail.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 18:42:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6TPD-0008Mq-KM
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 18:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760817AbYFKQln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 12:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbYFKQln
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 12:41:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:14304 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbYFKQlm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 12:41:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2174941fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Xu5yLeAs4DsEmiLnZTtHvCPA02IUdu+trqsft1NikaQ=;
        b=j4qmKojYPjPaa83W8eHHB2z5voS9Mb6IyqF4WuPkNO+FOQGM4XftdR0QXPrMk/ciO0
         5dmfrwIJiDxbKcjAQYHjUJ/VG1D05sQK88m1V3n4npF/o/Qd+t8KZV9RMrceCQ2NhCJ+
         E2qq4uDom1me6GNrzG/zMnOyxxnJmAPdIk+po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ol3YCqS0971YyiRW9jbB5lok1WdrVGF+UE3hdlmFtorKCTwnnruELmJPwgfS02aHHS
         LRBASEq8hXMXeSad+UpQwr4ctfJ2KlaRRwiF11sxij+cuitB3ahSXN2c/hDcAEDdrjfm
         lYqaF3gP1ugHQKKhf+6T7qqpx6V5mmvCMAuuc=
Received: by 10.82.174.20 with SMTP id w20mr1156bue.58.1213202501226;
        Wed, 11 Jun 2008 09:41:41 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Wed, 11 Jun 2008 09:41:41 -0700 (PDT)
In-Reply-To: <m38wxcrtjr.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84622>

On 6/11/08, Jakub Narebski <jnareb@gmail.com> wrote:
> "Chris Hoffman" <chris.c.hoffman@gmail.com> writes:
>
>  > Is there a distribution of the git server for Windows, or am I totally
>  > missing the point of git?
>
> I don't know about git-daemon (git server) under Windows

I can confirm that the git-daemon works fine on Windows (cygwin).
Currently using git 1.5.5, but previous versions worked for me as
well.

But Jakub's other suggestions are probably more appropriate for a "git
server" in the same sense as an "svn server" or "p4 server" (ie.
read-write access with authentication).

Have fun,

Avery
