From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Git doesn't detect change, if file modification time is restored
 to original one
Date: Thu, 23 Jul 2015 09:58:13 +0200
Message-ID: <55B09E95.4000700@gmail.com>
References: <CABEDGg8zixeab-CsviAU-fNE1Jmi0ZWbN6=e6Q+-XK3eFv6djA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 09:58:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIBP0-0001qC-48
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 09:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbbGWH6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2015 03:58:33 -0400
Received: from plane.gmane.org ([80.91.229.3]:40727 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbbGWH60 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 03:58:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZIBOY-0001a3-S0
	for git@vger.kernel.org; Thu, 23 Jul 2015 09:58:23 +0200
Received: from 131.228.216.134 ([131.228.216.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 09:58:22 +0200
Received: from sschuberth by 131.228.216.134 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 09:58:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 131.228.216.134
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CABEDGg8zixeab-CsviAU-fNE1Jmi0ZWbN6=e6Q+-XK3eFv6djA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274487>

On 7/23/2015 9:29, Konr=C3=A1d L=C5=91rinczi wrote:

> Interesting, that git status doesn't show replaced changes, if the
> mtime is same as original.

See the somewhat related FAQ entry at [1] and also the lengthy discussi=
on at [2] about a similar issue. That said, deleting the .git/index fil=
e should make these files appear as modified.

[1] https://git.wiki.kernel.org/index.php/Git_FAQ#Why_isn.27t_Git_prese=
rving_modification_time_on_files.3F
[2] https://github.com/msysgit/git/issues/312

Regards,
Sebastian
