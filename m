From: =?ISO-8859-2?Q?Maciej_Ma=B3ecki?= <me@mmalecki.com>
Subject: Re: [PATCH] Use SSH key from `GIT_SSH_KEY` variable if supplied
Date: Tue, 20 Mar 2012 09:07:47 +0100
Message-ID: <CAKC8-7zr8JKCzMwameXvXVhCcycNG8B-dzCcPiCxrqFzGr_b8w@mail.gmail.com>
References: <1332207557-10965-1-git-send-email-me@mmalecki.com>
	<7vhaxk829x.fsf@alter.siamese.dyndns.org>
	<robbat2-20120320T020552-803311730Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 09:07:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9u6m-0001sq-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 09:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249Ab2CTIHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 04:07:51 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64209 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2CTIHr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 04:07:47 -0400
Received: by yenl12 with SMTP id l12so6042809yen.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 01:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=HnMxNYE+YfW/FG45ITAoYLeQdxiSEcIPna//D3B2scg=;
        b=ZiNasgKEeHxBGUPDZA5fs8wDxv+wi3MvtdL8S+N4fK5jW5naoyEyNw96ehej/m+qSc
         2lI3d4ZCC3o+alOESFD40OGxsAXvvUUNu/5YGhR39+/vrmaE4PV8uwhxtf3qUTKTvh7p
         DiYarqOwoNL0imRXX1XoO7POnDv7bwxOp76lUjVIvnzxW/H1cENagCbpdIbcmHkr9buF
         ovv8glj0TIJDdlVzlIrFoMzvkhbXE8+4tuPp5yXs8oQYCknnsaKY40l691XzvrRHvlvI
         h90rno54ZAcxtF7AJjb571tWSOBhr9uZYKE2EtJIu647npXTg1rY60TH43V0aUby1xY4
         5fog==
Received: by 10.60.23.138 with SMTP id m10mr17102451oef.12.1332230867300; Tue,
 20 Mar 2012 01:07:47 -0700 (PDT)
Received: by 10.182.116.104 with HTTP; Tue, 20 Mar 2012 01:07:47 -0700 (PDT)
X-Originating-IP: [83.25.48.110]
In-Reply-To: <robbat2-20120320T020552-803311730Z@orbis-terrarum.net>
X-Gm-Message-State: ALoCoQmCnOa80Swq2TF1U3S4YapS3x/jaOpQv5yJ9VT3BIYqpA4W7ZpYN1Ys/Xalbl7B4PidZy8/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193491>

W dniu 20 marca 2012 03:07 u=BFytkownik Robin H. Johnson
<robbat2@gentoo.org> napisa=B3:
> On Mon, Mar 19, 2012 at 06:55:06PM -0700, =A0Junio C Hamano wrote:
>> Hmm. I am somewhat torn.
>>
>> The minimalist in me finds this extraneous and unnecessary noise. =A0=
Why
>> should the user always set GIT_SSH_KEY environment variable that onl=
y
>> applies to git and does not help his other ssh sessions? =A0Why isn'=
t having
>> an entry in .ssh/config to name IdentityFile sufficient?
>>
>> Would GIT_SSH_ARGS=3D'-i /home/me/.ssh/there.pub -l me' be more appr=
opriate?
> I'd strongly prefer a generic args support, for making it easier to u=
se
> in deployment code.
After rethinking it, I'm also +1 on GIT_SSH_ARGS. Should I submit a pat=
ch?
Sorry for noob question, but it'd go into a new e-mail thread, right?
