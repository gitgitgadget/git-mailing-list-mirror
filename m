From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Fix git-instaweb breakage on MacOS X due to the limited sed functionality
Date: Wed, 19 Dec 2007 12:55:37 +0100
Message-ID: <DE63D291-1B73-41FB-AF56-9B671A6A66E4@wincent.com>
References: <20071219105752.GA23932@hashpling.org> <23306E3C-24F1-4626-A956-02531644B786@wincent.com> <20071219113617.GA26520@hashpling.org> <CA30F61D-4AE1-4100-A632-20B5587EB4D0@wincent.com> <20071219114823.GA28273@hashpling.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xWt-0008Ct-QV
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbXLSLzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 06:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXLSLzl
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:55:41 -0500
Received: from wincent.com ([72.3.236.74]:35546 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbXLSLzk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 06:55:40 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBJBtcTc019186;
	Wed, 19 Dec 2007 05:55:38 -0600
In-Reply-To: <20071219114823.GA28273@hashpling.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68896>

El 19/12/2007, a las 12:48, Charles Bailey escribi=F3:

> On Wed, Dec 19, 2007 at 12:43:12PM +0100, Wincent Colaiuta wrote:
>> El 19/12/2007, a las 12:36, Charles Bailey escribi=F3:
>>
>>> I agree completely, but all the generated scripts output hard coded
>>> paths so it would seem inconsistent not to qualify the path in this
>>> case too.
>>
>> It's not hard-coded, it's dynamic. Witness:
>
> It's *output* hardcoded, it's dynamic during script generation.

Ah, ok. Seems like we were working with different definitions of "hard-=
=20
coded". When I said "hard-coded" I meant "determined by you and not =20
overrideable by the user doing the build without hand-editing the =20
source file".

> A raw 'perl' in a shell script is dynamic during script run.

Sure, and seeing as you're only doing a simple find/replace any =20
version of perl installed on the path is probably fine.

But if you are going to provide an absolute path then you should at =20
least make it user-configurable like all the other perl paths.

Cheers,
Wincent
