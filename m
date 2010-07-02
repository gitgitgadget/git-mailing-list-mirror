From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported 
	commit
Date: Fri, 2 Jul 2010 17:48:28 +0200
Message-ID: <AANLkTikDK8XlXPHAAUyn5HIKiqE6Ea_b3c3cFGOYOv4H@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino> 
	<20100702051201.GC7209@burratino> <AANLkTintWyhcx9pURSqxs3e9BBkPx9KSPPYh4UOU7kv6@mail.gmail.com> 
	<20100702154028.GB2287@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 17:49:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUiUC-00064Q-84
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 17:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819Ab0GBPsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 11:48:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51013 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab0GBPst convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 11:48:49 -0400
Received: by gwaa18 with SMTP id a18so276919gwa.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4hFkZ6TDp9SRLw8LOjRzUsjhLDSzgX7o+4U3RplAJIw=;
        b=bNT7xkf8jsTJXXDHRqvB1HChqctT8u9X//3elwKFsqUkViTZFv+Skn3VcGeHfj+9Mb
         RLQuTV+1ux3NMYXOZ8SQDmE1nU2E1xIGcqdxWWlAfh5cUrAfBwnNoCXCxf61Ofom9TKq
         yEWwnqMLXTTodI3iU62ILp7B28N6LGz6sZuuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KEZD3bgamJcq88617ghWihHTj9+xZ6pLtRLd24AC/yIb5OympMUgdAbk2WZqQmaxtw
         VNp46L4LaSi4cIBL9SNI7+nn/25Q0JQtgSHNCOGc9IYDTrZS6FqW8wwZfHxkLDqx1Mjh
         ecuG5SA9/e7Rb2LVMx8m4xXVBEW0eX+fi7O8o=
Received: by 10.224.106.18 with SMTP id v18mr288523qao.66.1278085728236; Fri, 
	02 Jul 2010 08:48:48 -0700 (PDT)
Received: by 10.150.184.8 with HTTP; Fri, 2 Jul 2010 08:48:28 -0700 (PDT)
In-Reply-To: <20100702154028.GB2287@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150139>

Heya,

On Fri, Jul 2, 2010 at 17:40, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=A0 la cat-file --batch. =C2=A0Hopefully by the end of this weeken=
d, if no
> one else gets to it first.

Okay, sounds like an excellent plan. Perhaps you can even borrow from
git cat-file's code?

--=20
Cheers,

Sverre Rabbelier
