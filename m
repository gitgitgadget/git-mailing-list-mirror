From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v4 12/10] git-remote-testgit: support the new 'force'
 option
Date: Tue, 12 Nov 2013 01:09:46 -0500
Message-ID: <5281C62A.6070208@bbn.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>	<1382908589-7000-1-git-send-email-rhansen@bbn.com>	<526f74cf8307f_37cdfb1e7c31@nysa.notmuch> <52800CB7.7080905@bbn.com> <xmqqwqkelrn1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 07:10:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg7Ah-0003xS-9v
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 07:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab3KLGJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 01:09:52 -0500
Received: from smtp.bbn.com ([128.33.0.80]:57722 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab3KLGJv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 01:09:51 -0500
Received: from socket.bbn.com ([192.1.120.102]:57718)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg7Aa-000MCH-4K; Tue, 12 Nov 2013 01:09:48 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 647DF4004D
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqwqkelrn1.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237696>

On 2013-11-11 13:28, Junio C Hamano wrote:
> Richard Hansen <rhansen@bbn.com> writes:
> 
>>> I think the convention is to align these:
>>>
>>> case $opt in
>>> force)
>>
>> The existing case statement in this file indents the patterns the same
>> amount as the case statement, so this should be aligned to match.
>>
>> In general I rarely see the case patterns indented at the same level as
>> the case statement,
> 
> What you see does not matter in the context of this project ;-)
> This is what we have in Documentation/CodingGuidelines:
> 
>     For shell scripts specifically (not exhaustive):
> 
>      - Case arms are indented at the same depth as case and esac lines.

Doh!  I missed that.  Thanks for pointing it out.

Thanks,
Richard
