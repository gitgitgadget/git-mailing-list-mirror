From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: sort entries numerically
Date: Sat, 7 Jun 2014 12:38:05 +0200
Message-ID: <20140607103805.GD4015@paksenarrion.iveqy.com>
References: <5392ABAE.6030208@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 07 12:35:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtDyY-00032C-5s
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 12:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbaFGKfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2014 06:35:40 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36986 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaFGKfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 06:35:39 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so2129387lbd.28
        for <git@vger.kernel.org>; Sat, 07 Jun 2014 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m5th3F4U15ytUYaxNoLBWxc9mWSAk927jd1WJrUljRw=;
        b=J/NBNFpnGUjwTMdcDhcIMJJ4O+WMFi1kl1Pe+9EklworKHdNSr9sQGfevmwQYYQ+iU
         BcH+JsPhIs3ka8Ku5//FwWb/oKH1nCe0Zd12V8H0lvreCM66fqA8PYsBuDB+9CU+nkLM
         sHHATvRO8PSUPlwyP59h7gCODhXxEMe5Kce4BwaQCDYxQB6RBQuSuvo7Oq6TvnharQAr
         i+GqB4S0OfOEuGrLF65d4s4n6zLazNYFv61O8yuZuHVvvg5eDdWT1G+yRof107Yq/E4r
         knLdRrbY921azYI44o2vsnBOwSaRrKbPuISh1v7sh0ahH0ONCK4KEfKVT2ZMw1MwILMv
         3TXw==
X-Received: by 10.112.159.7 with SMTP id wy7mr7919282lbb.4.1402137337634;
        Sat, 07 Jun 2014 03:35:37 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id o8sm10064713laj.10.2014.06.07.03.35.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 07 Jun 2014 03:35:36 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.82)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1WtE0j-0007Ao-DB; Sat, 07 Jun 2014 12:38:05 +0200
Content-Disposition: inline
In-Reply-To: <5392ABAE.6030208@gmx.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251041>

On Sat, Jun 07, 2014 at 08:05:34AM +0200, Toralf F=F6rster wrote:
> is there any chance to have "1.8" before "1.10" in an output like the=
 following :
>=20
> ...
> From https://code.wireshark.org/review/wireshark
>    52fe0aa..b69642d  master     -> origin/master
>    460db8a..540f061  master-1.10 -> origin/master-1.10
>    25bb29a..5741a40  master-1.12 -> origin/master-1.12
>    4ee4fc11..97898a2 master-1.8 -> origin/master-1.8

I don't find anything about it in git branch man page. However there's =
always:

git <command> | sort -d -r

as a workaround.

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
