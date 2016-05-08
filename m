From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: t6044 broken on pu
Date: Sun, 8 May 2016 08:54:06 +0200
Message-ID: <5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
 <878tzmrrfg.fsf@linux-m68k.org> <d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
 <xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 08 08:54:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azIbj-0004yf-LI
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 08:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbcEHGyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 02:54:20 -0400
Received: from mout.web.de ([212.227.17.11]:51883 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbcEHGyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 02:54:18 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LbrZ2-1bOQgm3y3I-00jI2D; Sun, 08 May 2016 08:54:09
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:QSpuZhZ2i5RmSHiAueh54qPpAIrVDUfUkpvib+xP/YB7pO3O+fG
 G+ep8LDHVyIgTIhyYg3d886uwTqH6fCkJ+IjKQUsVcUDR6DatqRcQ50Rjl1nUSPbDnmNc2D
 2K+6hwY5UsiPK6cHgq6YnAaGPcLBMwugQm7/9ZL2dmqUNC8o03EhWicucDgftEzA6qQRjGz
 j/OErqbiEm5vuN7l1sL6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cj6f4Ju9ftU=:yl25Mth5pmLTk497IRlS9l
 GBZyAqR68onzVRTjd4dde6GgG59H9M7uptaaSGc6FHTOLj1V+z273W32yryvCxATi3dRumi5F
 Uh8vGnGOJVyaTaVioGlyZ69wycbeIz0iwf0QVcOHZaN70OIYEChZORlRW/k6cnwbHtNLkypPx
 FU7Q1Wh0eLgrAiBCU5N+0n1ZPR5J7ax9oe2fWVWSgwYDNsqjyQd/T2ae3Xd34Bojlg/YRMuMl
 46WhFHmLWC5lISglgqWp80syZpOK1IMk1V+wa/qyXTnSZuTKIZLaaY/lOHzUSOUpkRlGtpRTO
 3FXCv3QPtFSFGWK31iHBKp8hH6GaR/SAV1/CBqP8qA+929OPwwN0SbJf/pM/HabZwaZIoibd+
 qWVIwj1VVVasVH+AhrR6/OAHdwfR16xMQRwnUr6sZw7pl+Da/yxruleE+03QOM750jOVq+K47
 93i+004ClY6n/usRxYkMkzz1H+ww5nNUTAVRcszkbX7TCVxEQVNoyCeCnPkYYSfmI/ql8YFJ3
 99FAYS8X03gKqv51VSIHajhGJj1vZrgqszq6rjvvMc58T4vRgJzoeufayVhDYOyD5TLeAjlc2
 IpJworL0HvntGFx86OmyHHCV3hMlkbnehQsBqeHc11mTGUULYHE8ik+bWbRcEhpF0bMa+rU7T
 ikEQXnaYdTOIUztmTplhuDn5DqyqccTo8n0+uC24KvkiH0rjd/kOwUNvAu8AKY9YzpnelXipr
 NfJkhwo4HJBJ6RrT/4klfmU/Co62XlWz+2k2tZG/nMZHjQK5NoybgP/toE+24fimUSMLYsOU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293911>

On 08.05.16 04:21, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> That's true, but the test passes anyway.
> You can also remove the body of the test and replace it with "true"
> and say "the test passes anyway".  Changing the test to use a file
> with only one line is irresponsible, if you do not know the nature
> of expected future bug that requires 10 lines to be there to
> manifest that the test wants to try.
>
> test_seq was invented exactly for the purpose of accomodating
> platforms that lack seq, so using it would probably be the best
> first step.  Updating implementation of test_seq to avoid $PERL
> would be a separate step, if desired (I personally do not think
> that is worth it).
We don't need to invoke perl, when the shell can do that internally ?

May a  simple
 printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n"

be an option ?
