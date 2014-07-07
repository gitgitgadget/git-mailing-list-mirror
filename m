From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Mon, 07 Jul 2014 21:40:31 +0200
Message-ID: <53BAF7AF.4020901@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>	<53B5C7AC.4040701@web.de> <xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 21:41:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4EnV-0000yZ-7S
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 21:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbaGGTlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 15:41:53 -0400
Received: from mout.web.de ([212.227.17.11]:53245 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbaGGTlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 15:41:52 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MINAx-1X2rbH374J-004C4c; Mon, 07 Jul 2014 21:40:36
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:ynWkPI+CyMvOfvT8OSaGbFkYke1lriF/Q8E7noHYW8k809IGqtq
 ZQnvBq3dsR0SurNj13Jiw6jrZE6S0NdRysb7bGizehj7lg/SyYt8dCrEJ4QHJvKatoAszrw
 e14vi5dSd00Gp6F2OVgmWau7yfiBcgzfLW7X2sSKZJVn3AGtcP6RJkR5WTAvCPMIqsCy0E1
 4yw6i68RM/AJqOdmwsIIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252984>

On 2014-07-07 19.05, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Junio, do you want me to resend 02/14 without the non-portable "echo -n"
>> or could you just squash the following diff in?
> 
> Amended locally here already; thanks, both.

There seems to be some other trouble under Mac OS, not yet fully tracked down,
(may be related to the "diff -r")

And Msysgit complains 
error: fchmod on c:/xxxt/trash directory.t7613-merge-submodule/submodule_update_repo/.git/modules/sub1/config.lock failed: Function not implemented
