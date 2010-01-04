From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: edit Author/Date metadata as part of 'git commit' $EDITOR 
	invocation?
Date: Mon, 4 Jan 2010 15:32:19 -0500
Message-ID: <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
References: <xuu2fx6m4vdi.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adam Megacz <adam@megacz.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 21:32:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRtba-00056Q-2j
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 21:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab0ADUcl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jan 2010 15:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758Ab0ADUcl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 15:32:41 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:49672 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab0ADUcl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 15:32:41 -0500
Received: by pwj9 with SMTP id 9so9562340pwj.21
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 12:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vmfNL2sci4+NRNebVH895xPhwLuxWqPznAaVoArjDYk=;
        b=kIOyoQl+sXj1Hifxpstl8ceU16DMXPPtXNfyqvnKgme/wQ3cidNTvQeiNHKmliBoUN
         jFDyB23zS9MvAND5r1sdf8UWirzMWOqDJY5l3HZaDp3v6HB04DFv9RKCW6B3m23skOlL
         RsmTJksNs2KGqL5AQwT5Vcko6RlVwrM5UcDPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vv2a5gL68ByuH0riqFLKDQvtaS8PpYWCLMvPet3TrkI8y2k30/6LY6ijtHyD6vkNFc
         zyAmrzkn7DJKUp/JR5Lk0rTLNoacSYx1TKM9sIPP5CUsPM2nAYcVepO+sNhdAk/3rjFz
         V6OKX7V++9a20BSx7+GWsA8GiyMp7/uyJHqrA=
Received: by 10.142.117.5 with SMTP id p5mr15283064wfc.31.1262637159087; Mon, 
	04 Jan 2010 12:32:39 -0800 (PST)
In-Reply-To: <xuu2fx6m4vdi.fsf@nowhere.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136142>

Heya,

On Sun, Jan 3, 2010 at 18:32, Adam Megacz <adam@megacz.com> wrote:
> =A0 =A0 I've been having problems lately with running git on machines=
 where
> =A0 =A0 I forgot to set up my .gitconfig; I wind up with patches that=
 have
> =A0 =A0 committers like root@mymachine and so forth. =A0Being automat=
ically
> =A0 =A0 shown the committer/author when I make the commit would help =
me
> =A0 =A0 avoid these situations.

At the very least it should be easy to include these fields as
comments in the message template. But of course you would still be
bitten if you used "git commit -m" :(.

--=20
Cheers,

Sverre Rabbelier
