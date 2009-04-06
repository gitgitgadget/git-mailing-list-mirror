From: Andreas Ericsson <exon@op5.com>
Subject: Re: [PATCH v2] Add configuration variable for sign-off to format-patch
Date: Mon, 06 Apr 2009 12:58:08 +0200
Message-ID: <49D9E040.40007@op5.se>
References: <20090331185018.GD72569@macbook.lan> <20090331200457.GA23879@coredump.intra.peff.net> <20090331204338.GA88381@macbook.lan> <20090401102610.GC26181@coredump.intra.peff.net> <20090401175153.GA90421@macbook.lan> <7veiw69p26.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 13:00:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqmYO-00026h-U6
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 12:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372AbZDFK6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 06:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755269AbZDFK6R
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 06:58:17 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:35813 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbZDFK6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 06:58:16 -0400
Received: by fxm2 with SMTP id 2so1819534fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 03:58:11 -0700 (PDT)
Received: by 10.86.49.13 with SMTP id w13mr2984845fgw.76.1239015491776;
        Mon, 06 Apr 2009 03:58:11 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 3sm6899997fge.29.2009.04.06.03.58.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 03:58:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7veiw69p26.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115805>

Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index ad22cb8..27cb7f1 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -715,6 +715,13 @@ format.thread::
>>  	A true boolean value is the same as `shallow`, and a false
>>  	value disables threading.
>>  
>> +format.signoff::
>> +    A boolean value which lets you enable the `-s/--signoff` option of
>> +    format-patch by default. *Note:* Adding the Signed-off-by: line to a
>> +    patch should be a conscious act and means that you certify you have
>> +    the rights to submit this work under the same open source license.
>> +    Please see the 'SubmittingPatches' document for further discussion.
> 
> I have a mixed feeling about this description.  The existing description
> on the --signoff option merely talks about what it does, leaving what it
> means, and it is quite deliberate.  If your project uses S-o-b, it may be
> useful.  If yours doesn't, you simply just don't use it.  It does not
> matter to _us_ as the document writer what that line means to your
> project.
> 
> We do want to make the reader think twice iff S-o-b is used in the
> reader's project with the same meaning as it means in git and the Linux
> kernel project, which is what the description you added is about.  But
> should we just assume if anybody uses S-o-b convention in their project
> they must give it the same meaning as we give it?
> 
> The patch looks straightforward enough, and the wording we can update if
> somebody can come up with a better one, so I'll apply the patch to
> 'master' and we will go from there.
> 

How about:
"Some projects (notably the Linux kernel and git itself) put special
meaning in a 'Signed-off-by' line while other's dont. Please refer
to your project's documentation for appropriate behaviour."

Optionally with the following amendment:

"In general, you should refrain from signing off on a patch containing
material that you're not sure can be legally spread under the project's
license."

I'll whip up a patch if someone cares enough about it to say "+1" to
either proposal, or make a better one.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
