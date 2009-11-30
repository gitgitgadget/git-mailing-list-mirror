From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 09:35:22 +0100
Message-ID: <fabb9a1e0911300035o532153b7qdc2ecd768200ce09@mail.gmail.com>
References: <20091130075221.GA5421@coredump.intra.peff.net> 
	<fabb9a1e0911292355v260b9f0ck79d993e25f0c5c61@mail.gmail.com> 
	<20091130075927.GA5767@coredump.intra.peff.net> <fabb9a1e0911300004w36c5da45q354aa4ff3153b6f4@mail.gmail.com> 
	<7v4oocwh5o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 09:35:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1jY-0004MT-Gy
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 09:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbZK3Ifg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 03:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbZK3Ifg
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 03:35:36 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:46179 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbZK3Ifg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 03:35:36 -0500
Received: by vws35 with SMTP id 35so991208vws.4
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 00:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+krC1EGaehk2FWHyrC2A6xjk2IXvUHa0uN/2YLUdoWc=;
        b=ZpyrX3jgbRcpoplN2GJqLLRFZo1omukHBdH8XvR7mcM34i4UBVFmRF4YTTxCNNwxbh
         OxU//jkQV5aZRKj52fQ9cIhUCYXJGn6HMvzU3kU/1/NZh4pF6ueVouyvCnvmOFNuj99B
         Zis+dRG1sE3EjfR47Go810PgVc5vhYvqcxcIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XHD85FVGJ73Im4LltUSkf/ekR8mIhV+JgFg4l/AaYulcH2REVF/UuarqNYyqvMwOf5
         GTznfz60KUCj1plIfynBS7+yQHM28UcHMBx2g5MlFlJfREJT8OlKQ90/UbgmwqlbKvnV
         ZfsCYA+/2HmW1K+DrZFGXbBimYWMlc8AZwLzE=
Received: by 10.220.122.78 with SMTP id k14mr4736544vcr.97.1259570142090; Mon, 
	30 Nov 2009 00:35:42 -0800 (PST)
In-Reply-To: <7v4oocwh5o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134083>

Heya,

On Mon, Nov 30, 2009 at 09:28, Junio C Hamano <gitster@pobox.com> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> I don't think that's true, git.git currently does not have such a
>> structure (everything is just dumped in the root directory). The only
>> reason git_remote_helpers exists is to make it easier to create a
>> python egg out of it and install that.
>
> If that is the case, shouldn't each of the helper written in Python need
> to have a separate directory, not just a single git_remote_helpers
> directory shared among them?

I don't understand why that would be needed? The reason we added a
single git_remote_helpers directory is because we wanted to share
common code, having a single python package makes that easy.

-- 
Cheers,

Sverre Rabbelier
