From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Fri, 06 Mar 2015 22:30:35 +0100
Message-ID: <54FA1C7B.3040906@web.de>
References: <54F88684.3020905@alum.mit.edu> <xmqqwq2v14iv.fsf@gitster.dls.corp.google.com> <54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	=?windows-1252?Q?Torsten_B?= =?windows-1252?Q?=F6gershausen?= 
	<tboegi@web.de>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 22:31:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTzpo-0007Ad-Mr
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 22:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbbCFVbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 16:31:00 -0500
Received: from mout.web.de ([212.227.15.14]:55438 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbbCFVa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 16:30:59 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MEER6-1YEbdY09fc-00FQs7; Fri, 06 Mar 2015 22:30:40
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54F9E907.4040703@alum.mit.edu>
X-Provags-ID: V03:K0:zjOEX/pblV2qdDEoY55ywy3GWFG6RcoAzXKGxATXgtEQcQSO9kI
 1NZWUgO19hHWFLo9RR9YHV1CAzMEiaR9BIzrOjdV+fqZM4WspMi+5jl4E8v8Qgu5Hx/aFxs
 AdwCu0i1QnfgibPq4qWE8Fsn3yNWzv9lMeivxOOswFKa7P1UIe7d4AAzXHHaicrdkeJe3qS
 wTDIu8mLTE1suukiBf1gQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264965>


> Oops, I misunderstood an internal bug report. In seems that it is the
> following scenario that is incorrect:
>
>     *.png text=auto eol=crlf
Hm, I don't know if we support this combination at all.

The current logic supports auto-detection of text/binary,
* text=auto
(the files will get the line ending from core.eol or core.autocrlf)

or the  the setting of a line ending:
*.sh eol=lf
*.bat eol=crlf


Is there a special use-case, which needs the combination of both ?
