From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH] Documentation: git-cherry uses git-patch-id
Date: Wed, 28 May 2008 17:07:46 -0700
Message-ID: <7f9d599f0805281707u319f444dl89d1fcb787966790@mail.gmail.com>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com>
	 <7v1w3muw8j.fsf@gitster.siamese.dyndns.org>
	 <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com>
	 <7vod6qtgfs.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0805281242w5769a100s1153c2101992ff55@mail.gmail.com>
	 <7v3ao2tawd.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0805281414x6b97070ag7a1cc36f5d3c5a36@mail.gmail.com>
	 <7v7idern4q.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 02:08:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VhA-0001zw-Gz
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbYE2AHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbYE2AHs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:07:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:4342 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbYE2AHr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:07:47 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3784481rvb.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=1bwc+Fh2xIdadqsD+s6YOqLncXgJxrmmGX2uIUZJRVs=;
        b=PZlBO2l12GwOTm30RfWShJmLq9P4y6lmEgIOmDXGyyi2siz0ZhO4DsOcZTZgA5V8ql4C/sHmkSfh1lfj0HpSELLwv7GebvyRkwkpn29wZiheeRFVn1eCVdvsecAh2Vzeguf4iGYxdC12F7hYrs7uyAPuZWPrFTGvbppzE3XOTIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=h5kmqDhyBuMYK6SB0eNA4HChIwdhB7+qQhFXve2tjARiXDfbPeFks4JK7UQd0jgtT3qPnuVqMHSfwbMnqQPlBZe/pjH+/0zaQE63wQCgavH9d0dc/hFDYYeqF9DeZ3oYPjgZ3RRl/oTf5Out6Wtdl8pfyO/Dmmck29m1XygGpng=
Received: by 10.141.15.19 with SMTP id s19mr1668167rvi.39.1212019666936;
        Wed, 28 May 2008 17:07:46 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Wed, 28 May 2008 17:07:46 -0700 (PDT)
In-Reply-To: <7v7idern4q.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: d6858f993198862e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83154>

On Wed, May 28, 2008 at 5:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Geoffrey Irving" <irving@naml.us> writes:
>
>> On Wed, May 28, 2008 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Thanks.
>>>
>>> In manual pages, "SEE ALSO" section is a more appropriate place to do this
>>> kind of thing.
>>
>> Here's an improved patch.
>
> Thanks, I'll do this instead...

Thanks!

Incidentally, my original source of confusion was not understanding
the order of arguments of git-cherry.  Everything works fine once I
use the correct order.

Geoffrey
