From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git fast-import : Warning duplicated ref: refs/remotes/origin/master
Date: Mon, 30 May 2011 18:09:50 -0500
Message-ID: <BANLkTikxZfgQ18L2qHMBMTCnJG=hAXUikg@mail.gmail.com>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
 <20110529232405.GA8369@elie> <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
 <20110530173517.GA13539@elie> <vpqzkm4gef2.fsf@bauges.imag.fr>
 <20110530201351.GB14427@elie> <BANLkTi=+v0Jt2+xgxy=qV+BT7pOUMpoMtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?UTF-8?B?SsOpcsOpbWllIE5JS0FFUw==?= <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 01:10:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRBbc-0002D0-4d
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 01:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab1E3XKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 19:10:32 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64537 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1E3XKb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 19:10:31 -0400
Received: by qwk3 with SMTP id 3so1837150qwk.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 16:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=kv6MqX2Dq1andGbmuA++t6oG9ykYjgIvkW6ZHOlWnfs=;
        b=G0ZCO4zSgKqALPC0O1CnnVOj42TbI6yetQ1kMlPIw16pqlvJeoszBNRq7ChjpUN0bl
         WOhc8ufYeHd5Dk23KTeP6xyDJNqFUj1rbb2zwMKiSivDLV9fDr3gwdw+uWjOoC93nYFS
         LwFo0pmfpZgjgo+u5wr3XHYfIqsHKrCpefiX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Hdqh6HoRmUw/42g1IpqjHhKgYuzX9X6X9mFqbEeEhxy5zSnKwHsCFfFqRs1z21yvnB
         /z3JN8IprK0PBvdSTZkcVlCQmMaUOsaFvTfjkQZWf0Un6LPk3nZ2vl4vsbOS1IC6RvpJ
         fMIhFfj25FCt7x62W2lI/TcCrUmBjl9SGqf3c=
Received: by 10.229.126.167 with SMTP id c39mr3730990qcs.119.1306797030223;
 Mon, 30 May 2011 16:10:30 -0700 (PDT)
Received: by 10.229.20.6 with HTTP; Mon, 30 May 2011 16:09:50 -0700 (PDT)
In-Reply-To: <BANLkTi=+v0Jt2+xgxy=qV+BT7pOUMpoMtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174787>

Heya,

On Mon, May 30, 2011 at 15:32, J=C3=A9r=C3=A9mie NIKAES <jeremie.nikaes=
@gmail.com> wrote:
> Well yes that would indeed make more sense. It feels weird to have to
> do it like this.

The patch series I was referring to can be found at [0].

[0] http://thread.gmane.org/gmane.comp.version-control.git/157860/focus=
=3D157864

--=20
Cheers,

Sverre Rabbelier
