From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Possible bug in Git
Date: Thu, 15 Apr 2010 20:38:58 -0400
Message-ID: <o2w76718491004151738zb2deaad1p3f7360a437725c4d@mail.gmail.com>
References: <4BC6EECE.6060408@gestiweb.com>
	 <k2u32541b131004151645i78733507rc50724548036ef36@mail.gmail.com>
	 <7vr5mggt9a.fsf@alter.siamese.dyndns.org>
	 <o2m32541b131004151706hb48a0d04yf7fa4238d423a4e3@mail.gmail.com>
	 <k2n32541b131004151713s51498b01s34c5a95c0f360901@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?David_Mart=C3=ADnez_Mart=C3=AD?= 
	<desarrollo@gestiweb.com>, git@vger.kernel.org,
	deavidsedice@gmail.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 02:39:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ZaZ-0003kb-A1
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 02:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152Ab0DPAjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 20:39:00 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:46270 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590Ab0DPAi7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 20:38:59 -0400
Received: by ywh32 with SMTP id 32so1029045ywh.33
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AGO9GLk5qzk+oJHaOYrcPDuL303iIOo0z9FCafopozs=;
        b=tdImKbML7qzoAe41/+cGvkocgRCbDdG7EYR25OSKicbwU+Gm6CVFtrTRuKQHufg/2W
         bn7i5XUjRl6SfjMfHGjQvmSuglpYQ/q0SHQla9XoypCdSk965Zxr4CUKJqS4mPwenQeo
         +f/k0Xh1uQTyR7BCal9qDnzsjMV4H+d6+fd3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IOcObUDU3UGnJCxjRzzOU77RyHdfkGClnEx9/BnWp8tSNkDdcvuva5RrvgX7C4X8uM
         Ed9+7eSQ788rDcg0Yhldu+7fZfha+h4ox5nXmYDNUmWXAFZb4UVd85902ctQkCJ811Jd
         hp/UpaPRoz4HTbQzhJTv4MYkUJ+LjFQpMpazc=
Received: by 10.231.36.9 with HTTP; Thu, 15 Apr 2010 17:38:58 -0700 (PDT)
In-Reply-To: <k2n32541b131004151713s51498b01s34c5a95c0f360901@mail.gmail.com>
Received: by 10.150.160.16 with SMTP id i16mr1047139ybe.172.1271378338177; 
	Thu, 15 Apr 2010 17:38:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145039>

On Thu, Apr 15, 2010 at 8:13 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> =C2=A0true >profile =C2=A0 # blank the file
> =C2=A0git commit -a -m resolved
> =C2=A0git show HEAD:profile
> =C2=A0 # no output

Well, I wouldn't expect output from show HEAD:profile. But this is odd:=
:

$ git diff HEAD^1 --name-status
M       profile

$ git diff HEAD^2 --name-status
M       profile

$ git diff-tree HEAD --name-status
<no output>

Hmfph. "git log -m -p -1" at least gives the diffs from each side.

j.
