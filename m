From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] Allow HTTP user agent string to be modified.
Date: Sat, 7 Aug 2010 17:39:38 +0000
Message-ID: <AANLkTimsYJxvHZkj8DNyOLozA4HJ9cwo+v3G_r2UXWz-@mail.gmail.com>
References: <1281152060-16736-1-git-send-email-olsonse@umich.edu>
	<AANLkTinyohKaACbheGR2Q=-K5sWwv+y1u1-3b2WPzxVh@mail.gmail.com>
	<1281202184.4815.1.camel@compaq.olson.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Sat Aug 07 19:39:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhnN5-00082R-6Z
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 19:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab0HGRjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 13:39:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38490 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab0HGRjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Aug 2010 13:39:39 -0400
Received: by iwn33 with SMTP id 33so2372002iwn.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EKVSjOvpObooy4VJLdZtA/Y2i8KXtjBNk798BB2nwOE=;
        b=XgjAMWPnleAQQFuC47Do/qq86qIeBLE+PbmY0MP/qp3SETTj2YDfwFu4v8COSlzJn2
         TQZWhCol/FYfVo8a5+vTBtyJr0v7iKgRk93oiU5TXtgIlnKRor47udns/8Et5BLwurJ4
         5hUQUV6A6mYPThMvelDCkNuxnPq801FGxZ/Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HxfAZK8VS43HK4ZfcwyYn/P4cAOT6Az30W5LYKXAFEUk/7ADYBwFrzg72N13wQLVbU
         5+oQT6QWh5O6ALcn8+HFzhSX2G5Havp2nNY5hOEwurort7c8P+H5/M3XjbdEHw5y3T6W
         i4yra4HVMTvD1g5lgkpPUGt390M5YbknKco3U=
Received: by 10.231.155.206 with SMTP id t14mr16266560ibw.34.1281202778415; 
	Sat, 07 Aug 2010 10:39:38 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 7 Aug 2010 10:39:38 -0700 (PDT)
In-Reply-To: <1281202184.4815.1.camel@compaq.olson.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152859>

On Sat, Aug 7, 2010 at 17:29, Spencer E. Olson <olsonse@umich.edu> wrot=
e:
> I would have no problem doing that. =C2=A0I was just trying to match =
the
> style already present in http.c. =C2=A0All the other pointer tests in=
 that
> function/file are done the same.

Ah, fair enough. I didn't notice that the rest of http.c already used
that style, nevermind then.

It's best to just keep it consistent, and maybe clean it up in some
later patch, but best not to introduce an inconsistency by using a
different style just for this one.

Your patch looks good.
