From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [msysGit] Re: Need your help with MinGW Issue 17: --color options don't work (produce garbage)
Date: Wed, 15 Aug 2007 15:07:18 -0700
Message-ID: <a1bbc6950708151507l15de5e9br5a09f13ad21d7f41@mail.gmail.com>
References: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com>
	 <3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com>
	 <a1bbc6950708150103v35330b47o781fb5d74e3d9aef@mail.gmail.com>
	 <3f4fd2640708150131o7578c2efy806891fc3def7429@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 00:07:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILR1Q-0001kb-Ox
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 00:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734AbXHOWHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 18:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbXHOWHV
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 18:07:21 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:38328 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757734AbXHOWHT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 18:07:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so60033rvb
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 15:07:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IniALqXDRl0aXR92L0z0guUvt4oWHkD/EuReOtrRJpWDWJ49hp/10NJfqVhX8u3EoRIfhxn+JZdrFg9QKyFEgkH74s2BJI4QnuJTBbtsoStIsJzuse0sfUw3YmWYgraVRUMGzBTyeuxvoUn/JO/7plY+rSO0/WoUJEW/TQhlXIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d3EYMdInv71ZAFAYIKCpwTpN1psmIJdeWpypOEiNZURYMgkkx+9TvH2fakovK37iowo0mYVht+z0ip0H4ZUa4VMGy70MbilADS+3NS4WludI84wTWbOBXGjU+d6+88LQ8ikmec/dPJYB1HcjChrQoxxXZu5XIHfaysLEZypr6Ko=
Received: by 10.140.191.14 with SMTP id o14mr421587rvf.1187215638168;
        Wed, 15 Aug 2007 15:07:18 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Wed, 15 Aug 2007 15:07:18 -0700 (PDT)
In-Reply-To: <3f4fd2640708150131o7578c2efy806891fc3def7429@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55958>

On 8/15/07, Reece Dunn <msclrhd@googlemail.com> wrote:
> I don't believe that MinGW has got this working for cat, that is why
> one that supports colours on Windows needs to be written.

MSys' cat does support colors even when I run it from cmd.exe.
I've looked at sources for cat on mingw.sourceforge.com and (as
expected) there is no code to handle esc-sequences.
That would be insane - too many utilities like ls, diff, cat, less
etc. do that. So there is obviously a library for this.
I've tried to "parse" makefiles for cat, but they are so huge and I
know about gcc/make on Unix so little that I was unable to find the
secret sauce.
I've also asked this question on MinGW list so I'm waiting for reply.

-- 
- Dmitry
