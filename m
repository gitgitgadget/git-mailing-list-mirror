From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] log: add log.follow config option
Date: Thu, 09 Jul 2015 10:58:04 -0700
Message-ID: <xmqq615tw6vn.fsf@gitster.dls.corp.google.com>
References: <1436377321-8495-1-git-send-email-dturner@twopensource.com>
	<vpqfv4xafpp.fsf@anie.imag.fr>
	<xmqqegkhw8hf.fsf@gitster.dls.corp.google.com>
	<1436463511.4542.27.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 19:58:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDG5m-0005oU-1D
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 19:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbbGIR6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 13:58:22 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38256 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbbGIR6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 13:58:07 -0400
Received: by igrv9 with SMTP id v9so199439270igr.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=d5Rr6SaDBvQVl8u7z/z5f0JxUHzcvvNg2GQdUZqEmf8=;
        b=t87VdcA0/4r3zSg0IKl728psxdS1NP2Dr36cYBLE4bGN79pFCNfFeNqhJ+nSLpi2Z4
         +LHZdYc+gT8qeIz17t9Oz1fa9ee8jiYJ24IKfFkTfPi3bj0mO+jCewhfvQq6ce/1dUUK
         DgM05JrKGqM+loGNfuaN8i7POuQWINQT6aUuen/PeBA8ANOTIMiPcf3gWZZj6Mlp/HTZ
         NiBgD8wnzGy9fu0jTtlX3ONpglErgSrpaRNRlCBw+s5+nVeFpA8BhNiD0grbHaXxe60m
         fTTujPlw5Javab27DgmE3zMW4gBX9JOAZNRRYo2B35rTBZaulQWayE1cofesvfKoG2OR
         nWMA==
X-Received: by 10.50.4.66 with SMTP id i2mr102723064igi.40.1436464686427;
        Thu, 09 Jul 2015 10:58:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id b140sm4670692ioe.9.2015.07.09.10.58.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 10:58:05 -0700 (PDT)
In-Reply-To: <1436463511.4542.27.camel@twopensource.com> (David Turner's
	message of "Thu, 09 Jul 2015 13:38:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273764>

David Turner <dturner@twopensource.com> writes:

> On Thu, 2015-07-09 at 10:23 -0700, Junio C Hamano wrote:
> <snip>
>> If I were David and sending this v4 patch, it would have looked like
>> this.
>>
>> -- >8 --
>> 
>> From: David Turner <dturner@twopensource.com>
>> Date: Tue, 7 Jul 2015 21:29:34 -0400
>> Subject: [PATCH v4] log: add "log.follow" configuration variable
>> 
>> People who work on projects with mostly linear history with frequent
>> whole file renames may want to always use "git log --follow" when
>> inspecting the life of the content that live in a single path.
>> 
>> Teach the command to behave as if "--follow" was given from the
>> command line when log.follow configuration variable is set *and*
>> there is one (and only one) path on the command line.
>
>
> Thanks.  That version is much better.

No, thank _you_; we should be thanking you for helping us improve
the system ;-)
