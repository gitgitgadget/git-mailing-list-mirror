From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: 195b7ca6 breaks t9010 at current master
Date: Tue, 29 Mar 2011 03:06:20 -0400
Message-ID: <08D5E94F-23F7-4F18-9E3F-A92722F70C70@silverinsanity.com>
References: <AANLkTik0CNXY9bKGOa9Xmai_OPQgExfLsFs1yN2pCVr8@mail.gmail.com> <20110329042446.GB25693@elie>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=D8yvind_A=2E_Holm?= <sunny@sunbase.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 09:06:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4T0X-00079i-VE
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 09:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab1C2HGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 03:06:24 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44856 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab1C2HGY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 03:06:24 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 00F161FFC192; Tue, 29 Mar 2011 07:06:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 1B4731FFC190;
	Tue, 29 Mar 2011 07:06:09 +0000 (UTC)
In-Reply-To: <20110329042446.GB25693@elie>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170234>


On Mar 29, 2011, at 12:24 AM, Jonathan Nieder wrote:

> =D8yvind A. Holm wrote:
>=20
>> When running "make test" at current master (v1.7.4.2-406-gbe919d5),
>> t9010-svn-fe.sh fails. Bisecting shows that 195b7ca6 ("vcs-svn: hand=
le
>> log message with embedded NUL") breaks the test.
>=20
> Could you try with the following patch applied?  It comes from
> squashing the last two patches from the svn-fe branch:

Breakage also seen on OS X 10.6.7, the provided patch does fix.

~~ Brian