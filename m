From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Git blame only current branch
Date: Tue, 13 Dec 2011 15:18:31 +0100
Message-ID: <op.v6fl05u30aolir@keputer>
References: <e9e35956-a091-4143-8fd4-3516b54263a6@mail>
 <d615954f-bed8-482d-a2e3-e1e741d6dd23@mail>
 <20111212165542.GA4802@sigill.intra.peff.net> <8739cpteat.fsf@gmail.com>
 <7vobvdvx9c.fsf@alter.siamese.dyndns.org> <87y5ugsguj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Stephen Bash" <bash@genarts.com>,
	"git discussion list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Vijay Lakshminarayanan" <laksvij@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 15:18:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaTBr-0003mj-Eh
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 15:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229Ab1LMOSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 09:18:39 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52377 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab1LMOSi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 09:18:38 -0500
Received: by eaaj10 with SMTP id j10so1137068eaa.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 06:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=bcKEh2fru8YEY3mT+yH5GSLVmsJn09d9himCHYMI/pc=;
        b=fdTeVJkaMsPHA6UtMJdPkoloXqaEUgfQTcRF1rfHQbodgcNlly5IOXwzCzdw6Xdf6O
         7uh5QohlhETT7bsEfL4wBFG1lhRf4EfYf9VFMqGdiIWKTDu5QhuknOxivRjHZQfwnt5Z
         /LegfDihCUjfTthgNjMfOwKVNR7JjeCOpVNH4=
Received: by 10.14.35.101 with SMTP id t77mr4290115eea.216.1323785916607;
        Tue, 13 Dec 2011 06:18:36 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id z43sm77294888eef.7.2011.12.13.06.18.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 06:18:35 -0800 (PST)
In-Reply-To: <87y5ugsguj.fsf@gmail.com>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187022>

On Tue, 13 Dec 2011 15:09:56 +0100, Vijay Lakshminarayanan  
<laksvij@gmail.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Vijay Lakshminarayanan <laksvij@gmail.com> writes:
>>
>>> The code reads fine when there's no numeral 1 around but now it doesn't
>>> read well.  I think refactoring
>>>
>>>     struct commit_list *l
>>>
>>> to
>>>
>>>     struct commit_list *lst
>>>
>>> is justified.  Thoughts?
>>
>> Not justified at all.
>>
>> What is "lst" and why is it not spelled "list"?  It is a disease to drop
>> vowels when you do not have to.
>
> lst is better than l in this particular context.  I think fried_chicken
> is better than l in this particular context ;-)

I tend to agree. If you casually look over the code it may look odd, and  
with several monospace fonts there really isn't a very big difference  
between 1?1:0 and l?1:0. You shouldn't have to squint to properly see the  
intention of the code.

If there's going to be a rename, there is no reason to leave out the i  
though.
