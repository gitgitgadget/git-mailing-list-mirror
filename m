From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: GNU patch: new 2.6 release
Date: Sun, 15 Nov 2009 15:02:20 +0100
Message-ID: <6672d0160911150602r450ae91fl34f533a39e61ed7@mail.gmail.com>
References: <200911140109.34202.agruen@suse.de>
	 <6672d0160911140045h70243c12w3c56ad925dc70d39@mail.gmail.com>
	 <200911151437.56228.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org,
	bug-patch@gnu.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Nov 15 15:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9fgS-00064t-U1
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 15:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbZKOOCR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 09:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbZKOOCQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 09:02:16 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:53091 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbZKOOCQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 09:02:16 -0500
Received: by fxm21 with SMTP id 21so1877641fxm.21
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 06:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JKBBHqWY50KpxlLXkx2g4mo+vSWE1TpMLTgPRyBBX5k=;
        b=xdsxAv05StN5FUrCBfUF/b8369QE/iU2VCz6izDfAvtBoJj/dWhsU9YycCml94tQ9U
         i3m8Bz8wmBp+bawHGEmbNWXF+bdRcaNYLOYWTzvLFGLoOmP+Zlu594rGE5e8kpL4NRWi
         EX0kuGH6pZBz8gWujI4j6ysmaU6JMDPyLwQmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bSxq9oPAYIefa7f39ea3sIf6dgk5UdSh0EABsO2yvaLOGjhuXeZIKz/aYy8BKw470r
         2r8dVyHaUfU0MVuwDgsJGEjGktQ5m4AjJF4qmjUMVOFwCpEFzOaLGDhGfIRrHhjmJRIb
         S4XPmRNxBmoty39ScZWNxUdLRv2aylubtxBfY=
Received: by 10.204.8.155 with SMTP id h27mr2754939bkh.55.1258293740491; Sun, 
	15 Nov 2009 06:02:20 -0800 (PST)
In-Reply-To: <200911151437.56228.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132939>

2009/11/15 Thomas Rast <trast@student.ethz.ch>:
> Bj=C3=B6rn Gustavsson wrote:
>> That would be very useful in a workflow when you work in git (and ha=
ve some
>> binary files in the repository), but need to commit your finished wo=
rk
>> into another VCS (such as Clearcase).
>
> You can simply use git-apply in this case, it also works outside a gi=
t
> repository.

Thanks, I didn't know that. I just assumed that it used the index
or generally depended on being run in a git repository.

The patch program does one thing that git-apply does not --
it can check out the files to be patched (for systems that need
it, such as Clearcase or RCS). I will have to handle that myself
(but that is not hard, I can either use 'git diff --name-only' to find
out the file names or extract the names from the patch itself).

/Bj=C3=B6rn
--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
