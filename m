From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Mon, 7 Nov 2005 17:50:02 +1300
Message-ID: <46a038f90511062050geee7e73qddcd52e3a2ec86df@mail.gmail.com>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com>
	 <46a038f90511061852h5cdf9539o34f69b4deb9f041a@mail.gmail.com>
	 <20051107043737.GI3001@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 05:51:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYyxZ-00035Y-AY
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 05:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVKGEuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 23:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVKGEuF
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 23:50:05 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:17007 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751284AbVKGEuC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 23:50:02 -0500
Received: by xproxy.gmail.com with SMTP id s9so312353wxc
        for <git@vger.kernel.org>; Sun, 06 Nov 2005 20:50:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hJcfFXRqV7f1tGZmjRx+lHRLWtNHDE6WqkIRZZAchOHAsmHwpySs8I9ziPzSnk7fLOtueP+tweCS7kh2UFXlQcj0qc9jcipH8u/xR7krYP3MKx9dPiSQ0cVTSxSboSgvcTNLAH937IPhDqIcaVyUEP+eYRUUGRTZq2/qdAPLQlU=
Received: by 10.64.208.19 with SMTP id f19mr4938063qbg;
        Sun, 06 Nov 2005 20:50:02 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Sun, 6 Nov 2005 20:50:02 -0800 (PST)
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051107043737.GI3001@reactrix.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11254>

On 11/7/05, Nick Hengeveld <nickh@reactrix.com> wrote:
> On Mon, Nov 07, 2005 at 03:52:41PM +1300, Martin Langhoff wrote:
>
> > > I'm getting errors when cloning over http
> >
> > More info on this.
> >
> > git-fetch-pack (invoked by cg-fetch) bails out because it thinks it
> > got a 404 fetching one of the packs:
>
> Does it always error out on the same pack file?

Yes.

> Which build of git are you using, and which version of curl?

A mix of 0.99.9, 0.99.9{b,c,d} and today's. Tested with Johannes'
patch of today for curl message handling, thinking it was related. No
dice.

On the Debian x86 box, it's
$ curl -V
curl 7.13.2 (i386-pc-linux-gnu) libcurl/7.14.0 OpenSSL/0.9.7g
zlib/1.2.2 libidn/0.5.18
Protocols: ftp gopher telnet dict ldap http file https ftps
Features: IDN IPv6 Largefile NTLM SSL libz

On the MacOSX box, it's
$ curl -V
curl 7.10.2 (powerpc-apple-darwin7.0) libcurl/7.10.2 OpenSSL/0.9.7g zlib/1.1.4

cheers,



martin
