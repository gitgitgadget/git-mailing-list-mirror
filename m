From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Wed, 24 Nov 2010 20:22:11 +0000
Message-ID: <AANLkTi=DQBYSMhu38asSGxKBktuzeSem5wq_48s64w0F@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
	<AANLkTinTisPh-x-JQBMkz-b=RoMJ6PUQ8Hp1VV_uZ=V+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git ML <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 21:22:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLLr8-00076x-07
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 21:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363Ab0KXUWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 15:22:13 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57556 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756268Ab0KXUWM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 15:22:12 -0500
Received: by vws2 with SMTP id 2so138963vws.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 12:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=cUzm4I/xF3PawigVUZ7z2Gp/pDKLDukiPHIveHo6zvk=;
        b=rlTntr/VyrjWXdDkrbc8jDwEnCh5bJrPGNu4TDFaZoSEodTmztWi5Ji9rx7KYNxzZE
         /ZoLzGRQyuyGQybQ96sJVl974CLNnzJncPX0jkZNt0Ux9cmB1kxUrY108ZTPhlTE0B9x
         qYu94j7i//L51doCjCU0pN12/a4gDE1WpkRgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ej+pD3X+lmM1bfef62GZcEYXYsubVOJ5y9fVfHeJJyBFBu71OV2LXPKsYNaDjgtvlo
         fJ3tExPAaaAQhEOMMnxtzzmGAuWPo1C4mZngCtuj+9HS02WXZtIUwe52BpAgbEPP8ZXn
         h3x/GyLntaCRTeVdE12gu3cBTun4+voYBgBF4=
Received: by 10.229.181.85 with SMTP id bx21mr7971060qcb.227.1290630131974;
 Wed, 24 Nov 2010 12:22:11 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Wed, 24 Nov 2010 12:22:11 -0800 (PST)
In-Reply-To: <AANLkTinTisPh-x-JQBMkz-b=RoMJ6PUQ8Hp1VV_uZ=V+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162081>

On Wed, Nov 24, 2010 at 1:32 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Does assume-unchanged bit (see "git update-index") help? I'm not
> suggesting to use it but it would help determine if the slowdown is
> worktree-related.

I will try that. Another possibility, perhaps a bit cleaner and more
appropriate as a steady-state solution, is to use sparse checkouts.

.D
