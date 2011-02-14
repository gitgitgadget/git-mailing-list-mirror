From: Miles Bader <miles@gnu.org>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 07:07:49 +0000
Message-ID: <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com> <4D58D2DF.1050205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 08:08:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PosY5-0006Hx-6o
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 08:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab1BNHIc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 02:08:32 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37336 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab1BNHIa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 02:08:30 -0500
Received: by bwz15 with SMTP id 15so5188710bwz.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 23:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5r6sSZPZq6orlyassX34i7AGxAqCjjfgs6imemKXbkU=;
        b=ftOfSOJNQ73kPSmIzSWSR9HMUIkbntNrJfUwERW/upb1KZRlcIS4G1zBXUQrHV7KJi
         ucUy1gCBGMrOJmR6DEGmEDi7gKyYhTGvdz7RvjSzU33r3BlmzC7aqIxpYAQ1d5GSVzO/
         jbs7PRFaCX/a++pQweHYw9O14eoTMvm2m/Ed8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=G5mEGtoisK1r5+wfny3hhCyK1Ny1zUunUVmT4cR8CdMLpXaNeuFWnHNxtL6ekAlAdX
         AkEVV0m84Bv3NT2nmpfgpPmp+JKHtBHG8ltHlXgcMHntookLXPgUlKbGMEXBBj6EnAQG
         FWZs4FvsLgmisaP9NLMdyAvEXjHv7ots5A82U=
Received: by 10.204.103.132 with SMTP id k4mr3080658bko.28.1297667309241; Sun,
 13 Feb 2011 23:08:29 -0800 (PST)
Received: by 10.204.119.130 with HTTP; Sun, 13 Feb 2011 23:07:49 -0800 (PST)
In-Reply-To: <4D58D2DF.1050205@viscovery.net>
X-Google-Sender-Auth: Z3K5kOp52gt5DVz123P7XKiSi5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166693>

On Mon, Feb 14, 2011 at 6:59 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 2/14/2011 7:27, schrieb Miles Bader:
>> "git diff -s" =A0? ... since --staged is an alias for --cached :)
>
> git config --global alias.diffc "diff --cached"

"Git should be convenient by default (for commonly used operations)"

-miles

--=20
Cat is power. =A0Cat is peace.
