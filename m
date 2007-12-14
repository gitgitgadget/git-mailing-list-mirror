From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/5] New version of pre-commit hook
Date: Fri, 14 Dec 2007 08:24:04 +0100
Message-ID: <06C937AD-24B3-496B-AE76-B63CA007BEBB@wincent.com>
References: <1197552751-53480-1-git-send-email-win@wincent.com> <1197552751-53480-2-git-send-email-win@wincent.com> <1197552751-53480-3-git-send-email-win@wincent.com> <fjsi37$7ji$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 08:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J34uZ-00074L-2x
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 08:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbXLNHYT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 02:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbXLNHYS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 02:24:18 -0500
Received: from wincent.com ([72.3.236.74]:49723 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbXLNHYS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 02:24:18 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBE7OEFK012438;
	Fri, 14 Dec 2007 01:24:16 -0600
In-Reply-To: <fjsi37$7ji$1@ger.gmane.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68253>

El 14/12/2007, a las 1:17, Jakub Narebski escribi=F3:

> Wincent Colaiuta wrote:
>
>> Now that "git diff --check" indicates problems with its exit code th=
e
>> pre-commit hook becomes a trivial one-liner.
>
>> -         if (/^(?:[<>=3D]){7}/) {
>> -             bad_line("unresolved merge conflict", $_);
>> -         }
>
> Aren't you losing this check with rewrite?

Yes. If that's a problem then this is definitely a "no-goer".

Cheers,
Wincent
