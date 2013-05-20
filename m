From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/6] t5000: add test for pax extended header generation
Date: Mon, 20 May 2013 13:43:16 +0200
Message-ID: <519A0C54.9090707@lsrfire.ath.cx>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 20 13:43:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeOV2-00068q-BY
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 13:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab3ETLn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 07:43:28 -0400
Received: from india601.server4you.de ([85.25.151.105]:56489 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab3ETLn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 07:43:27 -0400
Received: from [192.168.2.105] (p4FFDA8FE.dip0.t-ipconnect.de [79.253.168.254])
	by india601.server4you.de (Postfix) with ESMTPSA id 8F9B546;
	Mon, 20 May 2013 13:43:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224955>

Am 20.05.2013 11:58, schrieb Ren=C3=A9 Scharfe:
> This series adds a test that exercises git archive's pax header code.
> It checks for tar versions that don't support pax headers and works
> around their deficiency.
>
> The first five patches are cleanups and refactorings to centralize
> tar calls into a helper function.  The last patch adds the workaround
> at this central place and a file to the test archive whose name is to=
o
> long to fit into the path field of a standard tar header, making a pa=
x
> extended header necessary.

=46orgot to mention that the last patch was prompted by Thomas' recent=20
test coverage patches.

Ren=C3=A9
