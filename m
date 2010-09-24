From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCHv2 11/16] t6016 (rev-list-graph-simplify-history): add
 missing &&
Date: Fri, 24 Sep 2010 23:00:01 +0000
Message-ID: <AANLkTimGq2-Gxna71TpX613AHYfU3n+RGagEfB68u1Tu@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-12-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 01:00:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzHFT-0003rS-9T
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 01:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758413Ab0IXXAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 19:00:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60075 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758405Ab0IXXAC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 19:00:02 -0400
Received: by iwn5 with SMTP id 5so2745305iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 16:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8HjzroQVEQ16u782qpZFDYNisOUcDA28M5VNlZgYQyA=;
        b=Vn1972GcKR3nmbjFyLBxMcF5kHPrw7vY7qtZPQJ9x9JagxaDRZ0i6vVVduRgjxdGE7
         tJpxnlPMRozja5AdrDi/7yVSgm8pnaugmYYtUqIGvMnE1a08IC8r6Hu6EvCKmvj0Dlph
         E7Ku2wdnOvfxF4cE91SAqVO/6M3+GgUlYAeN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hk/e4prkra/mqReJnqVQuTAbxZWoIoR2vkDjcmNziIMizkmGczd2I0PjB5IZgqNXLq
         /YolBBzieAXGWojbQn7esUWpvtIaNk9jm0WCxzySFxyk9UFh124ecqXi/IdwXsCSZTff
         HxcfP0lKmptUqJ9YcOFNandmCwODHbvyuaGgQ=
Received: by 10.231.13.140 with SMTP id c12mr4440312iba.25.1285369201682; Fri,
 24 Sep 2010 16:00:01 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 16:00:01 -0700 (PDT)
In-Reply-To: <1285366976-22216-12-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157098>

On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wrote:
> Also removed several repeated tag and branch deletions, since the tag=
s and
> branches had already been deleted. =C2=A0FIXME: Should I just keep th=
e repeated
> deletions in there and guard them with a test_might_fail?

No, no reason if they're not doing anything.
