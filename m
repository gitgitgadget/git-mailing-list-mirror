From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git-upload-pack bandwidth cap over SSH?
Date: Sat, 25 Sep 2010 03:13:09 +0800
Message-ID: <AANLkTinLL_pP=cvKcv=WtbqfacMKqris8sVe+Hb5=f-5@mail.gmail.com>
References: <4C9CB9E9.8010901@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 21:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzDhu-0008CQ-MV
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 21:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470Ab0IXTNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 15:13:12 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44071 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab0IXTNL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 15:13:11 -0400
Received: by ewy23 with SMTP id 23so857378ewy.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hBK5IY0tiMw+/omdBJcQ1128hh+8nb3Xras5jeD0YM0=;
        b=nX6ssu0V94n0hYXoy28DNkCWhJoBPiJbI/8dRmbSjEqaQ0qo55MMrd7vrq+xR6XDP6
         463XEHK3pdd8Sz52ku4O87ODW5pL6VWAeND2gFRYIgawhvDSGNbeCLuX1RiTPXAtMhnz
         +i8ivMIyhmG4AndtmVjbtZYwBt8JlWlOqwL/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KhABG/uH3jIwf4TfSQNGMdx6011MixF+ymbCGjhJ+VtgTlQItNxJvAPJSvt7BqHaZ3
         4/64QGZlL4xCk2TEvyvD14/EhzOZtAsDcsnYFDnRsnCXv9cewebtdf2sId99gYYFxVzo
         B2pbk6VW/kNSykm5V30ZcISQmOdYMwYBUEpE8=
Received: by 10.213.7.81 with SMTP id c17mr3491274ebc.17.1285355589567; Fri,
 24 Sep 2010 12:13:09 -0700 (PDT)
Received: by 10.213.31.147 with HTTP; Fri, 24 Sep 2010 12:13:09 -0700 (PDT)
In-Reply-To: <4C9CB9E9.8010901@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157040>

Hi,

On Fri, Sep 24, 2010 at 10:47 PM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> Thinking it might be a hardware issue (half duplex?), I installed Vir=
tualBox
> on my Windows 7 64-bit machine and then made an Ubuntu Gitolite insta=
ll.
> =A0Running on my local hardware, the push is roughly 12 megabytes per=
 second.
> =A0The 'git pull' downstream again caps at 1.55 MiB/s.

Where's the git repository living in? A VirtualBox hdd? Shared folder?
Samba share?

> Update: I just copied a large file via 'scp', and the downstream stil=
l
> capped at 1.55-ish megabytes per second. =A0So it isn't Git.

You might probably get better help on VirtualBox's forum.

--=20
Cheers,
Ray Chuan
