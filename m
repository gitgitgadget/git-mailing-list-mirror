From: Peter Spierenburg <ionlyusethisaddressforlists@gmail.com>
Subject: Re: git/webdav is refusing to authenticate properly.
Date: Mon, 12 Jan 2009 17:35:44 -0700
Message-ID: <496BE1E0.9010908@gmail.com>
References: <137c54e10901121354l284f11ag675abb003fc83e93@mail.gmail.com> <alpine.DEB.1.00.0901130003490.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Jan 13 01:54:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXXp-0000ol-At
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 01:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbZAMAwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbZAMAwo
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:52:44 -0500
Received: from mail-gx0-f26.google.com ([209.85.217.26]:36038 "EHLO
	mail-gx0-f26.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZAMAwn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 19:52:43 -0500
X-Greylist: delayed 1013 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jan 2009 19:52:43 EST
Received: by gxk7 with SMTP id 7so84815gxk.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 16:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=aYlFtggjWvhU7lxqA5bSldeBf1IKLr1d99m4kTtghy0=;
        b=cdsbidE9COsTz2azT93voB2VHcU2nHzwZ9mxKT8Kn809isyisrpMAp7fCmjaOdksHk
         u9l3pI2JocTNujO1eomxfXB/dOwaZxdu+LQv2qfPsQYjTa5gqeP02NQIqUvmE9lhLvYC
         gdcHdxnmEoQ7qk9CfqdZkS4CyWSd3taPy9FUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=jIaIIEGuXyUBKhYqyksSB1VL67N0DBk4GckGd4QFgc0ZKk3zFS+7/p0P2FZknJ574T
         m0UxTa9jyhRkT4m0E3wJDYgirNelHJQnCIWovReHkBnjDFJtrIgBoFiANgvpDyaF2Enj
         AenLjcWXi0xHNinH604ObtjAJtbgr5TQV9kgY=
Received: by 10.101.70.14 with SMTP id x14mr12193380ank.154.1231806948220;
        Mon, 12 Jan 2009 16:35:48 -0800 (PST)
Received: from pspierenburg-lnx1.int.pason.com (smtp.pason.com [208.38.1.1])
        by mx.google.com with ESMTPS id d22sm730142and.0.2009.01.12.16.35.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 16:35:47 -0800 (PST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <alpine.DEB.1.00.0901130003490.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105429>

C'mon, leave my password 'in-the-clear', in a text file on a networked 
box? That is the kind of prank a fourth-year student would try to pull 
on a freshman.

How do I really do it?

Peter.


Johannes Schindelin wrote:
> Hi,
>
> On Mon, 12 Jan 2009, Peter Spierenburg wrote:
>
>   
>> I'm trying to push a local git repository to a remote site using WebDAV, 
>> but it is eating my lunch.
>>     
>
> Please see Documentation/howto/setup-git-server-over-http.txt.
>
> In short, http-push does not ask for a password interactively, but you 
> have to use .netrc.
>
> Hth,
> Dscho
>
>   
