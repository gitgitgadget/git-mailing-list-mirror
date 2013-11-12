From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Tue, 12 Nov 2013 02:39:50 -0500
Message-ID: <5281DB46.2010004@bbn.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>	<1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>	<xmqqd2m6jyue.fsf@gitster.dls.corp.google.com> <CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 08:40:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg8Zx-0005uj-5B
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 08:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab3KLHkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 02:40:01 -0500
Received: from smtp.bbn.com ([128.33.0.80]:31257 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab3KLHkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 02:40:00 -0500
Received: from socket.bbn.com ([192.1.120.102]:57724)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg8Zj-000Msz-Hh; Tue, 12 Nov 2013 02:39:51 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 1400C3FF72
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237701>

On 2013-11-11 18:50, Felipe Contreras wrote:
> On Mon, Nov 11, 2013 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> So that we can convert the exported ref names.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>
>> I thought that the discussion agreed this option should not be
>> called --refspec but something like --refmap?
> 
> I don't know what you agreed to,

http://article.gmane.org/gmane.comp.version-control.git/237473

> but I didn't agree to anything.

Based on your silence I too thought that you had agreed.

> What you pass to this option is a refspec, so it makes sense to name
> the option --refspec.

As discussed in that thread, it's not really the same thing as a refspec
used in push or fetch.  In those commands, the refspec specifies two
separable things:  what to transfer, and how to translate refs names
between the remote and local repositories.  IIUC, the fast-export
--refspec argument only specifies how to translate ref names, not what
gets transferred.

If my understanding is correct, then I agree with Junio and Peff that
--refmap is a better name.

-Richard
