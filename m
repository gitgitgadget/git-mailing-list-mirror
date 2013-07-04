From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is
 used
Date: Thu, 4 Jul 2013 12:01:12 +0200
Message-ID: <20130704100112.GD17597@paksenarrion.iveqy.com>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 12:01:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UugLZ-0001Nl-7m
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 12:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409Ab3GDKBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 06:01:00 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:62847 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158Ab3GDKA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 06:00:58 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so1037584lab.24
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s47q8hjrGZCgK3neeIUDrIm3p+L67pOh6lOdRsIUGv4=;
        b=ubGGeRshuHps01+A57eK7xbvSoDUd2oQZvP4+NHVlUgy7oT1zipica+5HGJY8SDwhk
         1yFqD95xCa6vYnpllJ1YckjNkkmH9xpikXmn3o5HmeP2y2if4UyNMQBbN77DJB4x9XHF
         0V5tt5nJlNbHq/b1QtkrJcWfbD7cHbIzX4pTayNboTgfKWlndUiYKG7uP01rxTvwrkfQ
         zsGdg8KaU+vPprAQzZUviFrsX4ow+EVuHmbSDkU670TnIq2MBRRzHapTlunrmSoCq8VJ
         5MM+iElRYuGnMV4cwdW1U6KbQGfrr4luWkHjGQIgjzKIbfAoEJ3Oq4/4YKnP5pT6yGOo
         sBrg==
X-Received: by 10.112.130.37 with SMTP id ob5mr3165348lbb.77.1372932056904;
        Thu, 04 Jul 2013 03:00:56 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id v18sm974552lbd.5.2013.07.04.03.00.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 03:00:56 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UugLg-0002ke-RL; Thu, 04 Jul 2013 12:01:12 +0200
Content-Disposition: inline
In-Reply-To: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229566>

On Thu, Jul 04, 2013 at 12:47:28PM +0300, Orgad Shaneh wrote:
> If a prepare-commit-msg hook is used, git gui executes it for "New Co=
mmit".
>=20
> If the "New Commit" is selected, and then immediately "Amend" (before
> the hook returns), when the hook returns the message is replaced with
> the one produced by the hook.

I don't get it. The message from the hook is replaced with the message
from the hook?

What I don't get is how you can amend to a commit that doesn't yet
exists. How is that possible?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
