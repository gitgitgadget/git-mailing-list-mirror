From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] log: add log.follow config option
Date: Fri, 10 Jul 2015 14:03:25 -0700
Message-ID: <xmqqpp3zk9nm.fsf@gitster.dls.corp.google.com>
References: <1436377321-8495-1-git-send-email-dturner@twopensource.com>
	<vpqfv4xafpp.fsf@anie.imag.fr>
	<xmqqegkhw8hf.fsf@gitster.dls.corp.google.com>
	<1436463511.4542.27.camel@twopensource.com>
	<xmqq615tw6vn.fsf@gitster.dls.corp.google.com>
	<1436550835.4542.69.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 23:03:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDfSH-0004Ua-B8
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 23:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359AbbGJVDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 17:03:30 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38102 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932736AbbGJVD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 17:03:28 -0400
Received: by igrv9 with SMTP id v9so21703465igr.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3X9igZ/mNVoXWpe/YF0XwDVkH1h2xT7dVBbibBgw7Rc=;
        b=xzKyaEJNpo3nUM0LnEZdBwyxWaMCPbqu9Zp+v0W4K6LF9x8z9P/bJ0pHs64WfvJJmQ
         WNvd81iHVmJUdFB6CVpvt2Ex9lONrP/gUQUwWmYpTSMjKW3ThzF8NU9EG76Gt/Sh41SW
         0Yb+FT8LqDDHmJkqWAE0+8RoqQCs7g+PrsCJY28fRO27dNYiT0QjrbPqlSgodX0Zzlfn
         kflS98m3aINO6IvTmrCQPvYCZ3L+UG91Rk1gIu7Tc1E8KA2gGoug+fAuQBrXVMFy+oWy
         IstJz1Q1UT3isp2SeDVv4hhZtoAsEOPaWnMIfEl45IazsUwzk90xIwlnW8cHPFlavGQp
         0fYQ==
X-Received: by 10.107.38.68 with SMTP id m65mr6539093iom.135.1436562207638;
        Fri, 10 Jul 2015 14:03:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6de3:8019:a2a4:79ec])
        by smtp.gmail.com with ESMTPSA id s5sm353373igh.6.2015.07.10.14.03.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jul 2015 14:03:26 -0700 (PDT)
In-Reply-To: <1436550835.4542.69.camel@twopensource.com> (David Turner's
	message of "Fri, 10 Jul 2015 13:53:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273836>

David Turner <dturner@twopensource.com> writes:

> On Thu, 2015-07-09 at 10:58 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>> 
>> > On Thu, 2015-07-09 at 10:23 -0700, Junio C Hamano wrote:
>> > <snip>
>> >> If I were David and sending this v4 patch, it would have looked like
>> >> this.
>> >>
>> >> -- >8 --
>> >> 
>> >> From: David Turner <dturner@twopensource.com>
>> >> Date: Tue, 7 Jul 2015 21:29:34 -0400
>> >> Subject: [PATCH v4] log: add "log.follow" configuration variable
>> >> 
>> >> People who work on projects with mostly linear history with frequent
>> >> whole file renames may want to always use "git log --follow" when
>> >> inspecting the life of the content that live in a single path.
>> >> 
>> >> Teach the command to behave as if "--follow" was given from the
>> >> command line when log.follow configuration variable is set *and*
>> >> there is one (and only one) path on the command line.
>> >
>> >
>> > Thanks.  That version is much better.
>> 
>> No, thank _you_; we should be thanking you for helping us improve
>> the system ;-)
>
> Do I need to re-send, or will you queue your version?

I think I've already queued this version to my tree.

... goes and looks ...

Yup, it is near 'next' and I'm planning to merge it down to 'next'
and then to 'master' as time passes ;-)

Thanks.
