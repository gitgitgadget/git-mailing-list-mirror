From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 15:13:40 -0500
Message-ID: <32541b131001131213m75b4baefsc70a4cbf3c8431c8@mail.gmail.com>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<20100113135753.GA7095@Knoppix> <20100113141218.GA17687@inner.home.ulmdo.de> 
	<20100113144745.GA7246@Knoppix> <20100113161711.GB17687@inner.home.ulmdo.de> 
	<20100113173610.GA7609@Knoppix> <20100113183520.GA23674@inner.home.ulmdo.de> 
	<20100113191802.GA8110@Knoppix> <32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com> 
	<20100113200629.GA8383@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:14:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9bV-0006Y4-Ak
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab0AMUOB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 15:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755208Ab0AMUOB
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:14:01 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:55226 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab0AMUOB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 15:14:01 -0500
Received: by iwn35 with SMTP id 35so16668063iwn.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 12:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HzrHLV6KphBBNJeXXMne0ClgRjKN7ZFgl4n1j1cJ81M=;
        b=cyehXUzhXcuCqu0EEewjKCzwwk3Jj+qIPdfZB1cgCIcXUPjngaL+nTqHH2B4tsXCho
         +ooGzrQGS/D+ZASxyR9zfnBFOZRn0bFj++9tsiBnD0x2LyXg8pupSUrtcRpUvGGlvjEu
         0DniRJ+VxZtnnARIx9jR3F0mtgo8W+JscWz2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TVPHCfM3EZ6Y//t7M3+N8/9Q1kO/PkD1bMpDXr7s2HQ682Rig1qulUyBAEYok8i+K1
         pGzu2aGQbLl5UnJ9ScUu1FPTg9CIFm9MzBdNFkfvBsr2OuItT9UO9NMhOTUzVHNN6wrr
         UQkLkf1MFPqKtJX0a3Dz+k/cqQHWgix6dj+w4=
Received: by 10.231.145.70 with SMTP id c6mr282608ibv.36.1263413640104; Wed, 
	13 Jan 2010 12:14:00 -0800 (PST)
In-Reply-To: <20100113200629.GA8383@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136873>

On Wed, Jan 13, 2010 at 3:06 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Wed, Jan 13, 2010 at 02:30:20PM -0500, Avery Pennarun wrote:
>> That's why every major web browser supports them. [X.509 client-side=
 certificates]
>
> Supports !=3D is actually usable.

Lots of people use it.  That was my point.  If it weren't important,
web browser makers wouldn't bother putting it in; God knows they leave
out a lot of other stuff that I'd like.

>> Furthermore, how many people who really want ssh-style keypairs (and
>> thus refuse to use X.509 and PKI) can't just use ssh as their git
>> transport? =A0I don't actually understand what the goal is here.
>
> As said, I got fed up with failure modes of SSH.

I think this is the answer that needs clarification.  What failure
modes are these?  ssh doesn't seem to fail for me.  And github.com
seems to be working rather well with a huge number of users and ssh
authentication.

If you're upset at the failure modes of ssh, is it possible to fix ssh
instead of introducing Yet Another Tunneling Protocol?

Have fun,

Avery
