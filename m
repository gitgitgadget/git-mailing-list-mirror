From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: problematic git status output with some translations (such
 as fr_FR)
Date: Thu, 19 Dec 2013 12:50:49 -0800
Message-ID: <20131219205049.GE20443@google.com>
References: <20131008085036.11434.25160.reportbug@x230-buxy.home.ouaza.com>
 <20131219104613.GA18379@x230-buxy.home.ouaza.com>
 <20131219194319.GB20443@google.com>
 <xmqqk3f0efhe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Raphael Hertzog <hertzog@debian.org>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 21:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtkYe-0001G4-9e
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 21:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab3LSUu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 15:50:56 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:60939 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab3LSUuz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 15:50:55 -0500
Received: by mail-yh0-f46.google.com with SMTP id l109so440845yhq.19
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 12:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=16swiuRBuwxdnobVGZyY0CXkBWRnRfkLqyQoAwOaJ28=;
        b=uSkq8MC47EcBlrIO0PfojoZuiDBrobOcGva9lMiUKON970is7U0vrkMDIJ4zU69TzF
         b5t1jvbgRuXwhUWa4MdjQp+cGe7Psp331MdhlwUhwTNc2a6lby+6ckg8miTpfAmAgSQo
         8npdqOt5dNwVdEy8bkE2DoZoU8kp3HE4qI/D/xgPq7fJOlEf7Ns8CI84MUQw1MhRiPgf
         7Bpx4JoD3VVJSUgbe0mfgB9RAGsEogdkDkTOVOvFcngNUCZ22oDCVB9NfuL4iSmBhUSI
         Y8u0/u5G8VKEfY/b8QkeFGARybpXivM95a3SVepOBoy1VLPJd5zJmgMNCwakOR+Yfa3/
         KJEQ==
X-Received: by 10.236.149.176 with SMTP id x36mr2985900yhj.27.1387486253882;
        Thu, 19 Dec 2013 12:50:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c44sm7799889yho.20.2013.12.19.12.50.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Dec 2013 12:50:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqk3f0efhe.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239546>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> This includes the colon in the translated string, to make it easier to
>> remember to keep the non-breaking space before it.
>
> Hmph, recent 3651e45c (wt-status: take the alignment burden off
> translators, 2013-11-05) seems to have gone in the different
> direction when it updated similar code for the non-unmerged paths.

Yes, if this seems to go in the right direction, I'd add a follow-up
for that when rerolling.

Alternatively if there is some library function to append a colon to a
string in a locale-appropriate way, that could work, too.  Pointers
welcome.

Thanks,
Jonathan
