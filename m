From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [PATCH v2] gitk: read and write a repository specific configuration
 file
Date: Wed, 05 Dec 2012 10:20:09 -0500
Message-ID: <50BF6629.8050806@xiplink.com>
References: <1354483766-13925-1-git-send-email-stlman@poczta.fm> <1354668583-4893-1-git-send-email-stlman@poczta.fm>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, paulus@samba.org, gitster@pobox.com
To: =?UTF-8?B?xYF1a2FzeiBTdGVsbWFjaA==?= <stlman@poczta.fm>
X-From: git-owner@vger.kernel.org Wed Dec 05 16:20:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgGly-0001IE-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 16:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab2LEPUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2012 10:20:11 -0500
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:34557 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab2LEPUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 10:20:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp13.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id AE5EC19812F;
	Wed,  5 Dec 2012 10:20:11 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp13.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EF2711980E1;
	Wed,  5 Dec 2012 10:20:10 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1354668583-4893-1-git-send-email-stlman@poczta.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211127>

On 12-12-04 07:49 PM, =C5=81ukasz Stelmach wrote:
> Enable gitk read and write repository specific configuration
> file: ".git/k" if the file exists. To make gitk use the local
> file simply create one, e.g. with the touch(1) command.
>=20
> This is very useful if one uses different views for different
> repositories. Now there is no need to store all of them in
> ~/.gitk and make the views list needlesly long.

s/needlesly/needlessly/

		M.
