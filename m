From: Jeenu V <jeenuv@gmail.com>
Subject: Re: Ambiguous ref names
Date: Fri, 20 Nov 2009 17:25:45 +0530
Message-ID: <5195c8760911200355x1aff9781l848f974c9f09f416@mail.gmail.com>
References: <5195c8760911200218v5b75d690hbaaf00b44c8df6af@mail.gmail.com> 
	<7vzl6h3319.fsf@alter.siamese.dyndns.org> <5195c8760911200248v1f3d6b56q78987edfceae5541@mail.gmail.com> 
	<7vpr7dzckl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBS60-0008Tc-FA
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 12:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbZKTL4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 06:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbZKTL4A
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 06:56:00 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:62452 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbZKTLz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 06:55:59 -0500
Received: by vws30 with SMTP id 30so892997vws.33
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 03:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=x6JdOsHtw4mGAyUrBL0Vrmt/2Pc41tJhDrbs/TiuOXI=;
        b=Gr3fMgxb8eHLr+o0tamqdrDnFDvg84aq3OvpyBsKhXqT11KyOcmbK5kmw9G603yUdV
         +z3ueAzg3V2O8U+J1oJIs1MkKK4VpqrMpaGJKwWHEZyOK1MtplET2xz9yH+wfzZc8toH
         PpvMgRn/YpJv8P/W7TBOUW6MznRywrT0X7e7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=QjiyzvYHUYQOdTWc2GzyyYdvA2s3/01u4OgmzGyo+EYAAxTg3uRP0iHkQ0v5QcO83D
         YFXUpiz7YkdXoPjJ/KNaseMKFWhQ5074APMFLLP7ESgPynlbg58xY74OwiOI0tT9mYsa
         DsY2vvTMnBHS/8qynPKtiKo7IbwThTnW4rJMo=
Received: by 10.220.125.40 with SMTP id w40mr1760073vcr.17.1258718165272; Fri, 
	20 Nov 2009 03:56:05 -0800 (PST)
In-Reply-To: <7vpr7dzckl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133340>

On Fri, Nov 20, 2009 at 4:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeenu V <jeenuv@gmail.com> writes:
>
>> On Fri, Nov 20, 2009 at 3:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> [...]
>>> It could be that you have a tag and a branch that are both named a.b.c,
>>> though.
>>
>> Hm, right. But I'm getting this from an existing local repo of mine. I
>> can't see any tags; 'git tag -l' is empty. Is there any more info that
>> I can provide?
>
> man git-for-each-ref?

It does list all refs that I know of, but I don't see any duplicate entries.
-- 
:J
