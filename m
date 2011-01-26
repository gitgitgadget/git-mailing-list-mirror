From: Mika Fischer <mika.a.fischer@googlemail.com>
Subject: Re: [msysGit] Git unable to access https repositories due to
 curl/OpenSSL 1.0.0 handshake issues
Date: Wed, 26 Jan 2011 10:54:46 +0100
Message-ID: <AANLkTimJznExH8N9fcgSC88HOPfaFDF7jFMTZUJauL9+@mail.gmail.com>
References: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com>
 <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com> <AANLkTinGLMcRJ9EuZY_k4GoKyg+r7hxcgnq3z0=qOemA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 26 10:55:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi26D-0007zK-U7
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 10:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab1AZJzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 04:55:15 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53079 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab1AZJzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 04:55:07 -0500
Received: by iyj18 with SMTP id 18so193513iyj.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 01:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=vZpAys7GAlrtODPbJYHHusthxn4cD2ki9CfyVZX4kbQ=;
        b=AFQG2zMnlH1cNN0VzjeSTFkh1/tt0dopbF1JmepodnOYb9qlC3sTGTwA4rPLjVxPJh
         hY/HgBUBnw9lD2J2D6JK6V3KDE37nwYUQfInQoao+gDR+1+ohNQx8TsV/1W4fIXEymow
         yLyf5KinC2V+ZNy6Oxxoc1XiJN4ynDMAIxQHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XHL4sg3NltGQX0KMVhJE0SRoIFq+0ALk32O7tbgCnDXaplVJc/aPxJkdtXwiYsmo9J
         UVqsg9VU9S7XHfwklO9zm0u2SIch7TFzerPhWWzZZOk1xr1rzPvY0KrDSNTM6D25jgIl
         J/TE/DidVaF93ooL4o7ZKbDjyAMybmh9YQvAY=
Received: by 10.231.39.76 with SMTP id f12mr7888992ibe.126.1296035706588; Wed,
 26 Jan 2011 01:55:06 -0800 (PST)
Received: by 10.231.8.215 with HTTP; Wed, 26 Jan 2011 01:54:46 -0800 (PST)
In-Reply-To: <AANLkTinGLMcRJ9EuZY_k4GoKyg+r7hxcgnq3z0=qOemA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165511>

On Wed, Jan 26, 2011 at 10:15, Mika Fischer
<mika.a.fischer@googlemail.com> wrote:
> I'll see if I can get a more current version of curl to compile under Windows.

I did not manage to do do this.

But I noticed that the same problem occurs on OpenSuSE 11.2. So I
compiled the latest version of curl on OpenSuSE 11.2 and the problem
is still present...

Best,
 Mika
