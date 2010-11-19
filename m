From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: clarify documentation of "feature" command
Date: Fri, 19 Nov 2010 12:58:49 +0100
Message-ID: <AANLkTinverp9axgvtWtb4SwTAYJTkWnN1ejd5Ce3symm@mail.gmail.com>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
 <20101119093530.GA19061@burratino> <20101119094045.GC19061@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	vcs-fast-import-devs@lists.launchpad.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 12:59:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJPcb-00037b-CH
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 12:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab0KSL7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 06:59:12 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61222 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab0KSL7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 06:59:11 -0500
Received: by gwj17 with SMTP id 17so2593193gwj.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 03:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8oIwPM6YYrRlBJEL2jqda5DYQWsBBxb1ZhyOsr6pFGo=;
        b=sBnRxAnLtfWYZrXPWC2gdEHLcWWb14zKsns/AlSjkOSYez25j9mkptgPRB1l2Cn8eH
         Eh+yd5/RgKxwwSSapDTNmsd9+fP3gnn5lXoUjaqOJDJiceC5zL36vr3HE4zYQlZj8fJh
         9mkHHQ94r3j9J1GkblSa/UV+bbvENbtP0TkG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=M0wczx9oMwld+G+Hb1tIcwfocQUK8A/IY5w68mTyPGsyGwcmzpWhUrtfGhowfVRq9L
         YXfMmMirmA5wv9WiaGxrpKGlskG+MZ8yEwm29P1l+9Nzh1jpexXjtWOTYYxLpGZQT4iG
         Dld5aWOaklGXI175CNx5kZf9CO05LNtx3954c=
Received: by 10.151.150.11 with SMTP id c11mr3374927ybo.413.1290167950733;
 Fri, 19 Nov 2010 03:59:10 -0800 (PST)
Received: by 10.151.100.3 with HTTP; Fri, 19 Nov 2010 03:58:49 -0800 (PST)
In-Reply-To: <20101119094045.GC19061@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161740>

Heya,

On Fri, Nov 19, 2010 at 10:40, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Make this more obvious by being more explicit about how the analogy
> between most "feature" commands and command-line options works. =C2=A0=
Treat
> the feature (import-marks) that does not fit this analogy separately.

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

> In particular, it is not obvious to me whether cat-blob, ls-tree,
> and so on ought to be considered a single feature but with the
> feature command syntax, we could dodge the issue. :) =C2=A0Sane?

Yes, I like that idea, although I'm not sure how clean the
implementation would be :)

--=20
Cheers,

Sverre Rabbelier
