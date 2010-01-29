From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 12:38:13 -0800
Message-ID: <8c9a061001291238o77040252s36d8a88a546d014a@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com> 
	<fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naxbz-0005vj-Vd
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab0A2Uie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 15:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356Ab0A2Uie
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:38:34 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:40362 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab0A2Uid convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 15:38:33 -0500
Received: by pxi12 with SMTP id 12so1943724pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 12:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q9QCxyWR1RINU4UtFPaazRnoTQNwXZj1HmxCFF1NJH0=;
        b=GLHQb52NWX6GOi4fLZUsqMHSn5FOeD63JFGAjtuLJu1PRKvFeWZ7bge5N4JxHtddbx
         drxkbW3DV1mQxj3ojHlD/M7QX8kp/0s/GjR4eKgQENqigA3CW1VjEo9KiW3bvndDhKOu
         HVz06Q4bRqzGG5OLt4Iwp98B+JDUepy5IMEHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=I86e2IlOU9sFM2jxbP2VMth74eA0U7UIsjNL8uOTPU92wVlrTeNIPKvBmjsdphFisT
         hnhBxWy6D2iVVyD8LzlzTHoCG31hc8zALSg6nJtmgjqqbvhjNu680siJiHiVr4qHrlp2
         it/UoCMGlMCiHEXY8n/SqalLBdbH4DgAQuRAY=
Received: by 10.141.90.5 with SMTP id s5mr885300rvl.81.1264797513076; Fri, 29 
	Jan 2010 12:38:33 -0800 (PST)
In-Reply-To: <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138352>

On Fri, Jan 29, 2010 at 12:35, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> Heya,
>
> On Fri, Jan 29, 2010 at 21:27, Jacob Helwig <jacob.helwig@gmail.com> =
wrote:
>> On Fri, Jan 29, 2010 at 12:20, Ron1 <ron1@flownet.com> wrote:
>>> This is a test repository which has never been pulled from nor push=
ed to
>>> anywhere. =C2=A0So how is it possible that I have a non-local branc=
h?
>>
>> master^ is a commit (the first parent of master), not a branch (loca=
l
>> or otherwise).
>
> Perhaps we should change the message to say "not a branch" if it's no=
t
> a reference to a remote branch? Or simply changing the text to "not a
> (local) branch"?
>

I think "not a branch" would be better than "not a (local) branch".
In my mind, the latter reads almost exactly the same as the current
message.
