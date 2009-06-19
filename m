From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC/PATCH 0/2] Support for arbitrary mapping for "git pull 
	--rebase"
Date: Fri, 19 Jun 2009 15:42:35 +0200
Message-ID: <adf1fd3d0906190642j383411e8ydf03b524abcc1875@mail.gmail.com>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
	 <alpine.DEB.1.00.0906181040320.4848@intel-tinevez-2-302>
	 <adf1fd3d0906180224l668b4c84kc633ec13f8d0296@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 15:42:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHeMf-0005Qc-06
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 15:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbZFSNmf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 09:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbZFSNmf
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 09:42:35 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:35378 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbZFSNme convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 09:42:34 -0400
Received: by bwz9 with SMTP id 9so1750923bwz.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 06:42:35 -0700 (PDT)
Received: by 10.204.103.145 with SMTP id k17mr2250812bko.10.1245418955692; 
	Fri, 19 Jun 2009 06:42:35 -0700 (PDT)
In-Reply-To: <adf1fd3d0906180224l668b4c84kc633ec13f8d0296@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121897>

2009/6/18 Santi B=E9jar <santi@agolina.net>:
> 2009/6/18 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> Hi,
>>
>> On Thu, 18 Jun 2009, Santi B=E9jar wrote:
>>
>>> Santi B??jar (2):
>>
>> Seems something is wrong in the --cover-letter utf-8 handlin, no?
>
> In this case (the cover letter) it is send-email that handles the
> utf-8, but I don't know why it is not working, as there is a test in
> t9001-send-email that tests it. I think it worked, I'll try to bisect
> if I found a working version.

In fact I've been checking some of my cover letter and almost none of
them have the MIME headers. One that have the MIME headers is:

Subject: [PATCHv4 0/4] Show author and/or committer in some cases
Date: Sun,  4 May 2008 18:04:48 +0200
Message-Id: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
X-Mailer: git-send-email 1.5.5.1.224.gadb29
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

But I don't know/remeber what I did differently and I cannot reproduce
it even using the same git-send-email version.

So I don't know what else to look, and in fact I don't know who is
responsible (if any) for these MIME headers in a cover-letter. But
they are added automatically if you use the --compose flag. So maybe
git-send-email could be enhanced so that it adds the MIME headers to
the cover-letter (0000-cover-letter.patch) as if run with --compose.

Santi
