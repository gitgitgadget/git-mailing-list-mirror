From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: wrong handling of text git attribute leading to files incorrectly
 reported as modified
Date: Fri, 11 Apr 2014 22:38:44 +0200
Message-ID: <534852D4.5070608@web.de>
References: <E8A9F28E-FF68-4899-B02C-DB7A2C66F38A@ammeter.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Frank Ammeter <git@ammeter.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 22:38:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYiDr-00039e-5z
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 22:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbaDKUiq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2014 16:38:46 -0400
Received: from mout.web.de ([212.227.15.4]:62849 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159AbaDKUiq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 16:38:46 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M2dt7-1Wrl8j2ERJ-00sQWp; Fri, 11 Apr 2014 22:38:44
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <E8A9F28E-FF68-4899-B02C-DB7A2C66F38A@ammeter.ch>
X-Provags-ID: V03:K0:H6xRArSUQjkHIaiDCin3yLrn0SQsBEJUBEVg67yFApwiEgW3Fbf
 VSXEsUsP9YiV/KgfESe+ciQyZYHxKBQH4467tOTs/oLzPN0nN4ZowHk9AXhAHid7AqnIgHn
 WUqXXgJ7ldQzpGgAIlzlirsk3O2CQK2RNSzv59aSDP4WHiRa6lXICcITsLAZbI3WDUS5DVb
 iUfZGp7KrrxmcoGkeALNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246143>

On 2014-04-11 22.20, Frank Ammeter wrote:
> I=92m not a git expert and this might be the wrong place to ask this =
question,
> so please send me somewhere else if I=92m in the wrong place.
>=20
> I asked the same question on stack overflow, but didn=92t get any res=
ponse:
> http://stackoverflow.com/questions/22823004/files-incorrectly-reporte=
d-modified-git-attributes-buggy-leading-to-inconsist
>=20
> If a file is committed with crlf line endings with the text attribute=
 unset in the working tree, but the text attribute is set in the repo, =
the file will be incorrectly shown as modified - for all users checking=
 out the file.
> Resetting or manually modifying the file will not help - The only rem=
edy is to commit the .gitattributes with the text attribute set for the=
 file.
>=20
> Wouldn=92t it be better to only consider the checked-in gitattributes=
 instead of the attributes in the working tree?
No.
If you change stuff in your working tree (and .gitattributes is a part =
of the working tree)
how should Git know what you want?
The primary assumption is that you know what you are doing in the worki=
ng tree.
> Is this a bug in git handling gitattributes or is this wrong usage?=20
I thinkk No, yes.

If it is wrong usage, is it documented anywhere?
Please have a look here:
https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html


And if you think that the documentation can be improved,
please feel free to send suggestions.

A simple "git diff" is a good start, and a patch with a commit message =
is even better.
