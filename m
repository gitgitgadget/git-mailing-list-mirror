From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4 4/4] Add Travis CI support
Date: Fri, 6 Nov 2015 14:57:54 +0100
Message-ID: <CAHGBnuOmZFYUXKRnydUZSouOuJ59QU8K_=FvQG0xkQ+TywFPew@mail.gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
	<1446800323-2914-5-git-send-email-larsxschneider@gmail.com>
	<CAPig+cSc+BBgd3-UeVE79D9GWXfaQqbLCQdKo6FbhnPMsK_eFA@mail.gmail.com>
	<22B2C2B1-9260-4EC0-A4C5-C7F7DDD388BA@gmail.com>
	<CAHGBnuNwzGNjfh57zFOtwr6qU1PCsc7rgOniY8-Mz5Jgnv2QTg@mail.gmail.com>
	<D71ED634-382A-4835-AF65-D16FEFF17270@gmail.com>
	<CAHGBnuO9aVGYLd+3F3wp7QwazQvWZAS-NeNba3SwsuVkcVkCWg@mail.gmail.com>
	<BE90093A-90AA-4E63-9664-C5ABCDE6B410@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 14:58:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuhWu-0003Nf-6J
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 14:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161633AbbKFN6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 08:58:07 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38529 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161339AbbKFN5y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 08:57:54 -0500
Received: by igbxm8 with SMTP id xm8so9511862igb.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 05:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h7DtPnRxVRhZl8azTjztDHGnO5loYNTMNxEYV6ikh3o=;
        b=yXChdjPVqdAveKifxkNcylHDbm59G4o5PGCzX+e2cX5O1sTbBFXdy9IVELpJhnXzqR
         FEu9uA6nQN10iaj5rXzwD7MKS/YOn4e66q9WrZi4Ojwvtc1M0+B2ANeZkGqEvLEW4f7U
         9d4rK8srRCn0CqXsGK8DJrT2e7Q60ajEU+Haqb1jjNhvIOPvDmyn84qGT0NVNJPNMoTE
         MTRKIde3PE8aTb4MRKFNM2of2r1I8L2C1IIH5BtqzRAIVejTXdVk1984B1XGhC/LtVCJ
         32rZjO5wjllTu+VEuR9ovsACaecDAIzEFGlVhcaEX92/kc7pzUuGvdHdsfRMfAiZS4X3
         Xd8A==
X-Received: by 10.50.110.102 with SMTP id hz6mr9250936igb.47.1446818274371;
 Fri, 06 Nov 2015 05:57:54 -0800 (PST)
Received: by 10.107.182.133 with HTTP; Fri, 6 Nov 2015 05:57:54 -0800 (PST)
In-Reply-To: <BE90093A-90AA-4E63-9664-C5ABCDE6B410@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280984>

On Fri, Nov 6, 2015 at 2:55 PM, Lars Schneider <larsxschneider@gmail.com> wrote:

>> I think running different configuration per branch makes sense, yes.
>
> If the list decides to accept this patch. Do you think that would be a necessary requirement for the first iteration?

No. I think this could be addressed later as an improvements. To me
it's more important to finally get *some* sane Travis CI configuration
in.

-- 
Sebastian Schuberth
