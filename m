From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 18:07:04 -0700
Message-ID: <d411cc4a0811011807g229f8becs9f411d6e19fb6c12@mail.gmail.com>
References: <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
	 <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm>
	 <20081101010011.GG14786@spearce.org>
	 <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm>
	 <20081101010824.GE29036@artemis.corp>
	 <alpine.LFD.2.00.0810312121000.13034@xanadu.home>
	 <20081101014336.GI14786@spearce.org>
	 <alpine.LFD.2.00.0810312150200.13034@xanadu.home>
	 <20081101225714.GD15463@spearce.org>
	 <d411cc4a0811011726h1fb1ad0ct5c37af753940f4a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Pierre Habouzit" <madcoder@debian.org>, david@lang.hm,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 02:08:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwRSC-0004kE-7R
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 02:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbYKBBHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 21:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbYKBBHH
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 21:07:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:13198 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbYKBBHF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 21:07:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1068632wah.21
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 18:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8oIigff8fBi/0ExBUDlXrVGMLtTbo6Mm6rlCDhOZadI=;
        b=GfAviOXXNNZ59Iu2UoAyKgo5JzIj/b0mSBfDveHqk+sW9kBRvZ8rpfsyVKZdH0So5t
         6/vKjWa7kzMNgDxUu1HguZahQmnRuyUVsJJE9c5AVXDM9q/RIaTYtepiJTr2pVtcOKKP
         pEZHVlJCMbkeZjoesyvmbgenFyyv0FjtApT0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WTRcwgo3pfYtC3Kk7+fm4H/j5RuLqQqhlilka3dCsBlq+gMi0FbW72br6Cg46BLdMB
         iWyYHeM8RUAIffFJfs/dIzLhISp6AjRuMLKqfOOuSBQe6R2tZRKrLLQTMxu+bZ4pOpNi
         WwcnlvmM6y9VFXjNx/sYmix2Z253/0L2PIlCM=
Received: by 10.114.255.1 with SMTP id c1mr11488144wai.87.1225588025165;
        Sat, 01 Nov 2008 18:07:05 -0700 (PDT)
Received: by 10.114.135.18 with HTTP; Sat, 1 Nov 2008 18:07:04 -0700 (PDT)
In-Reply-To: <d411cc4a0811011726h1fb1ad0ct5c37af753940f4a4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99793>

> On Sat, Nov 1, 2008 at 3:57 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Nicolas Pitre <nico@cam.org> wrote:
>>> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
>>>
>>> > My take on the consensus for the license part of the discussion is
>>> > that libgit2 should be under the "GPL gcc library" license.
>>> >
>>> > BTW, I can't actually find a copy of that license; the only thing
>>> > I can locate in the GCC SVN tree is a copy of the LGPL.
>>>
>>> The exception is usually found at the top of files constituting
>>> libgcc.a.  One example is gcc/config/arm/ieee754-df.S.  ;-)
>>
>> Headers updated.  Its now GPL+gcc library exception.
>>
>> Not that the 5 lines of useful code there really needs copyright,
>> but hey, whatever.

I guess my main concern is that if a company wanted to direct
resources at supporting Git in something (say, an editor or GUI or
whatnot), and that company is of _any_ size, they are going to have to
get their legal department to review this strange and almost totally
unused license - only knowing that it's barely different than GPL and
they know GPL will not fly.  LGPL will likely be known to them and a
policy may already be in place.

Think about trying to incorporate this into something proprietary,
Shawn - how much of a pain is it going to be to get that license
reviewed in Google?  However, LGPL I'm sure there is already a
reviewed policy.  Now, since that may be a pain, time that Shawn could
have been spending being paid to work on the library is lost because
they can't use it, or it takes weeks/months to review it.  That's my
concern.

I personally would rather see it BSD or something more permissive so
that no human has to waste even a second of their valuable time
figuring out if they can work with it or not, but I understand that
many people here are much more protective of their code.  I simply
think that LGPL is a much more widely used and understood compromise
that affords nearly the same protectionism.

Scott

>>
>> --
>> Shawn.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
