From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 11:00:55 +0100
Message-ID: <25FDB05F-3E85-4E08-90BE-1BE468C07805@wincent.com>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org> <1197776919-16121-1-git-send-email-bfields@citi.umich.edu> <1197776919-16121-2-git-send-email-bfields@citi.umich.edu> <1197776919-16121-3-git-send-email-bfields@citi.umich.edu> <1197776919-16121-4-git-send-email-bfields@citi.umich.edu> <1197776919-16121-5-git-send-email-bfields@citi.umich.edu> <fk2pua$b4p$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Junio Hamano <junkio@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 11:01:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3qJO-0000m3-NR
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 11:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758480AbXLPKBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2007 05:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757993AbXLPKBG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 05:01:06 -0500
Received: from wincent.com ([72.3.236.74]:55132 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756076AbXLPKBE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Dec 2007 05:01:04 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBGA0vYo009937;
	Sun, 16 Dec 2007 04:00:58 -0600
In-Reply-To: <fk2pua$b4p$1@ger.gmane.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68451>

El 16/12/2007, a las 10:08, Jakub Narebski escribi=F3:

> J. Bruce Fields wrote:
>
>> This allows catching initial indents like '\t        ' (a tab =20
>> followed
>> by 8 spaces), while previously indent-with-non-tab caught only =20
>> indents
>> that consisted entirely of spaces.
>
> I prefer to use tabs for indent, but _spaces_ for align. While =20
> previous,
> less strict version of check catches indent using spaces, this one =20
> also
> catches _align_ using spaces.

I'd say that Jakub's is a fairly common use case (it's used in many =20
places in the Git codebase too, I think) so it would be a bad thing to =
=20
change the behaviour of "indent-with-non-tab".

If you also want to check for "align-with-non-tab" then it really =20
should be a separate, optional class of whitespace error.

Cheers,
Wincent
