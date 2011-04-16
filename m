From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sat, 16 Apr 2011 19:44:50 +0200
Message-ID: <BANLkTikNfTWuSM1yscUZVqgQk-EyPZL58A@mail.gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201104141154.55078.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 19:45:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB9Ya-0003iB-Db
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 19:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab1DPRpM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 13:45:12 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35613 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1DPRpK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2011 13:45:10 -0400
Received: by pvg12 with SMTP id 12so1544486pvg.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 10:45:10 -0700 (PDT)
Received: by 10.68.52.38 with SMTP id q6mr4143668pbo.179.1302975910071; Sat,
 16 Apr 2011 10:45:10 -0700 (PDT)
Received: by 10.68.55.163 with HTTP; Sat, 16 Apr 2011 10:44:50 -0700 (PDT)
In-Reply-To: <201104141154.55078.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171688>

Hi,

My suggestion is going to be tremendously unpopular, but still: if I
were to develop my own gitweb, I'd use Wt ( http://webtoolkit.eu ) +
libgit2. In fact, there is a very basic gitweb-like example bundled
with Wt sources, it's available online at
http://www.webtoolkit.eu/wt/examples/git

All those detect if this feature is available or not, fallback to
plain HTML (no Javascript, no AJAX), use HTML5, or SVG, or... where
available are already solved (and are totally automatical) in Wt. It's
C++ with Boost and Qt-like API, not plain C, Perl or bash scripting,
though.

On Thu, Apr 14, 2011 at 11:54 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>
> This is second installment, talking about JavaScript (client-side)
> part of gitweb code.
> [...]
> Those issues are already solved in __JavaScript libraries__ and
> frameworks, probably better way than in our attempt. =A0Using JavaScr=
ipt
> framework would also give as higher level constructs, and could
> replace what we have and could have in gitweb/static/js/lib:

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
