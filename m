From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: git remote vs. submodules
Date: Thu, 11 Nov 2010 09:44:08 -0500
Message-ID: <AANLkTin=t7RoLTwxc1KOv7_vZi-OgD_Jcu+66-fte6Sq@mail.gmail.com>
References: <AANLkTinev0W7-mm9wXmnZwY6DxN0Y2X0hJdpBOgM_4q=@mail.gmail.com> <4CDBD4D4.1080607@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 15:44:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGYOF-00030Y-E1
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815Ab0KKOoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 09:44:30 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52358 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779Ab0KKOo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 09:44:29 -0500
Received: by fxm16 with SMTP id 16so1356859fxm.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=aNvtfVunL7L5egPBT/o90xGsJ2Jhd6Pctwl3tkyKqEQ=;
        b=fbJAChgIeXfByyo1HpXs0R48g+bl7ck3M5Ef7TEqzNJ9xC+nqB6wJnhefHSIZhOz+3
         QL8mSFdvXaBbv4J4sQmwRj5upgL5JguMC+m9QlQNPQt2nDt3cW7TeqRrDLtouNG7/Hb7
         YSR9PpZTPjpzzRHuU5D9FIoM/xoPNWm169IEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aaCYv90GDZpuwY2BgYtIj6+87YaDcSmabiPqLqairjnIeX8b1cgw4QfnailUFghLYH
         ob0oTeDCiO/VgvG4hrHyav3ulF/C0b62oDwUuvn06pB8K7xRfzMFIsEMzO+kNePj5Bxd
         s/E0E93FmEBLUsl43PSKEmaIFJBTXCdFeabxE=
Received: by 10.223.78.199 with SMTP id m7mr227271fak.11.1289486668296; Thu,
 11 Nov 2010 06:44:28 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Thu, 11 Nov 2010 06:44:08 -0800 (PST)
In-Reply-To: <4CDBD4D4.1080607@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161263>

On Thu, Nov 11, 2010 at 6:34 AM, Tomas Carnecky <tom@dbservice.com> wrote:
> Are you maybe looking for a subtree merge?
> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html

Yeah, that looks like it.  I never would have hit upon the read-tree
step by myself -- I would have just laid things out with the prefix
already embedded in the subprojects.

Hmmm... it seems to me that feeding changes back to the subprojects
might be difficult (and that is born out by a comment at the end of
the page you referenced.)

How much do folks use this approach?

--wpd
