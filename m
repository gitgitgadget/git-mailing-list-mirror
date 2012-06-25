From: Thomas Badie <thomas.badie@gmail.com>
Subject: Re: [PATCH] git-add--interactive.perl: Remove two unused variables
Date: Tue, 26 Jun 2012 00:41:56 +0200
Message-ID: <4FE8E934.4090604@gmail.com>
References: <4FE7889E.2020009@gmail.com> <7vfw9khrrt.fsf@alter.siamese.dyndns.org> <CAFjFENo7qLTZHrEtPPBLGzp=h0w69C+7C2zfiJJmqFANmaWAgg@mail.gmail.com> <7v7guvgtbi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 00:42:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjHyy-000385-93
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 00:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540Ab2FYWmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 18:42:03 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33798 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab2FYWmC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 18:42:02 -0400
Received: by wibhr14 with SMTP id hr14so1592112wib.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Pg95sloyvF0AUqfcfjveRi2f6PejUZeGojIRIcl9Xac=;
        b=RtGxKBIUMG08gvHeL24s2Ed6pcp4PNA/O31c5nlA5e9ottcVJeVrDY51zKJgaGkxdH
         FJ9WMlMOeaQoPJQRE3MlZIPT4eE+yMIhH3SFJi4Q32vSGHV9C4a0p59lHh12NiJfMTQt
         2YeX9rQzx1BU8XoW8gJKfDw9IF67D4QVr0IGvbcqst57CqP07oTSNl4AqK532k9BF3ec
         qYDZmnT5NiLc9eI9FMk68JbrRzUeK2t11XdvKkmetgoJdEjDyLztfvak/Pi6BR1VUCqS
         Yv7KX9n1vgxIIwIhw2ueQMRZxVFoRzeWwBQTYLbldUr1Wb1lr4mvOznajSuy2h5Ohuf/
         8zKQ==
Received: by 10.180.101.103 with SMTP id ff7mr27721518wib.6.1340664120519;
        Mon, 25 Jun 2012 15:42:00 -0700 (PDT)
Received: from [192.168.0.10] (mna75-12-88-165-241-47.fbx.proxad.net. [88.165.241.47])
        by mx.google.com with ESMTPS id gv7sm585830wib.4.2012.06.25.15.41.59
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 15:41:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v7guvgtbi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200602>

On 25/06/2012 20:06, Junio C Hamano wrote:
> Thomas Badie <thomas.badie@gmail.com> writes:
> 
>> 2012/6/25 Junio C Hamano <gitster@pobox.com>:
>>> "Thomas \"Enki\" Badie" <thomas.badie@gmail.com> writes:
>>>
>>>> The patch 8f0bef6 refactors this script and leaves the `$fh' variable
>>>> unused in `diff_applies' and `patch_update_file'.
>>>>
>>>> Signed-off-by: Thomas Badie <badie@lrde.epita.fr>
>>>> ---
>>>> Hello,
>>>> This is my first patch. It introduces a really minor change, and I
>>>> also want to be sure the way I submit it is the right way. Thanks :)
>>>
>>> The patch submission is almost perfect, except that:
>>>
>>> (1) the patch seems to be whitespace damaged; and
>>>
>>
>> The only damage I see is a space on the deleted lines which doesn't
>> exist in the patch. Is that you're talking about ?
>> I need to investigate why it appears...
> 
> A typical context line would begin with SP and typically then tab
> (because our code is indented with leading tabs) but your context
> lines all have two SPs in front and indented with more SPs.  This is
> a symptom of your MUA mangling your patch, and the reason can be seen
> in the "Content-Type: text/plain; charset=ISO-8859-1; format=flowed"
> header.
> 

I follow the first approach in the tutorial in
`git format-patch --help`, and I hope it works as expected :)

I wonder what is the next step, should I repost the previous patch with
the line "Acked-by: Thomas Rast <trast@student.ethz.ch>" or it is okay
right now?

Thanks a lot for your help on this first patch,

-- 
Thomas "Enki" Badie
