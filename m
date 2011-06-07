From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 7/8] transport-helper: don't feed bogus refs to export push
Date: Tue, 7 Jun 2011 19:31:12 +0200
Message-ID: <BANLkTi=JMNv=5WbPBR-3fBwpo=NaK0QKBw@mail.gmail.com>
References: <20110607171838.GA21685@sigill.intra.peff.net> <20110607172111.GF22111@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:32:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU08E-00067S-3W
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437Ab1FGRbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:31:55 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33745 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab1FGRby (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:31:54 -0400
Received: by qyk7 with SMTP id 7so1476809qyk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=nMvZKAPNn9JdNuh5NxjEFn8vctOejAGoY2o+tIU1R2s=;
        b=thcI9fMfrCwmqTl6KQiadzLAFLLFoM4gmePykhK9E6J1mxOH0VOP+6eUWTXi6U9PuN
         3fJLsYsP1sOsbYmPYyui6zeZHw4ZaL8PHAS4JcPsGUQbkxYlI5kQo3JfYInUkuWjCrtQ
         6I3KmKF+fb1H2p8Ytl4pIzN5FwMQt3wzQEc4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=H8934Gl3PVTBfxlqiDuRN9TndpaB8GX2G6DnOLj5A+KIJUJU2rsEsA8ldBeA0jLH9v
         LHgoq3EHkwxsvHuCrLxJbz7UT4/+Gdj3H0P+Nj8Mc/0dhWcBUOv0YM+6QysuuNiRxbpx
         7Juz7MjEqtdIXx4MOtR6UExZLAudk7UofEeX8=
Received: by 10.229.24.19 with SMTP id t19mr4733434qcb.167.1307467913133; Tue,
 07 Jun 2011 10:31:53 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 10:31:12 -0700 (PDT)
In-Reply-To: <20110607172111.GF22111@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175232>

Heya,

On Tue, Jun 7, 2011 at 19:21, Jeff King <peff@peff.net> wrote:
> When we want to push to a remote helper that has the
> "export" capability, we collect all of the refs we want to
> push and then feed them to fast-export.

Whoah! I think this fixes the bug that's been preventing me from using
git-remote-hg for pushing! If it is, I can finally send it out for
review!

Thanks for spending time on this Peff!

-- 
Cheers,

Sverre Rabbelier
