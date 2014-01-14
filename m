From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Re* manpage for git-pull mentions a non-valid option -m in a
 comment
Date: Tue, 14 Jan 2014 19:51:57 +0100
Message-ID: <52D5874D.7070102@web.de>
References: <loom.20140114T025825-557@post.gmane.org> <xmqqvbxm4dyq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Ivan Zakharyaschev <imz@altlinux.org>
X-From: git-owner@vger.kernel.org Tue Jan 14 19:52:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W395r-00041I-Ew
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 19:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbaANSwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 13:52:03 -0500
Received: from mout.web.de ([212.227.15.4]:63486 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579AbaANSwB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 13:52:01 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M844f-1V7ccT027N-00ve9x for <git@vger.kernel.org>;
 Tue, 14 Jan 2014 19:52:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqqvbxm4dyq.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:kXBDoNeIkPfZpBszuYFvm1EyoTy3KA0pP4dlXacmxFy7LbkP9ZN
 NGBcAAFHGUKqk6ryc7MZ/tNnHLPUkBG4x4Tqy8/G6XZ9tomcgfuNyXzzr/7zb0TCUsy/7Hk
 02dZofmhK4ZvWUjZmaDFDo085Ts3ib7VyjmbXGf4E1A6XsNsSgzMmONNxPtM0D6JnXW8mbE
 wlFJ37CMqZDcKL8vtulxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240406>

On 2014-01-14 19.26, Junio C Hamano wrote:
> Ivan Zakharyaschev <imz@altlinux.org> writes:
> 
>> Hello!
>>
>> git-1.8.4.4
>>
>> The manpage for git-pull mentions -m in a comment:
>>
>> --edit, -e, --no-edit
>> Invoke an editor before committing successful mechanical merge to further edit
>> the auto-generated merge message, so that the user can explain and justify the
>> merge. The --no-edit option can be used to accept the auto-generated message
>> (this is generally discouraged). The --edit (or -e) option is still useful if
>> you are giving a draft message with the -m option from the command line and
>> want to edit it in the editor.
>>
>> but it is not accepted actually:
> 
> I do not think "git pull" ever had the "-m <message>" option; what
> you are seeing probably is a fallout from attempting to share the
> documentation pieces between "git pull" and "git merge" too
> agressively without proofreading.
> 
> It seems that there are two issues; here is an untested attempt to
> fix.
> 
> -- >8 --
> Subject: Documentaiotn: exclude irrelevant options from "git pull"
           ^^^^^^^^^^^^^^
(Small nit ??)
