From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Tue, 19 Feb 2013 17:00:20 +0530
Message-ID: <CALkWK0nJbbA_wjo--LW9v7pP35LS4SUOhZjHVh4dbZqDjSJnew@mail.gmail.com>
References: <1360307982-20027-1-git-send-email-artagnon@gmail.com>
 <CAGL0X-rKnWBy-Ff=YmEdqgo8RFb40FXTxvUM5X77YaQvhAGHYg@mail.gmail.com>
 <CALkWK0kBjsHtK1_7imJx-7CATSKFzpUgGzH6Hs9DAQ8c7jRUPw@mail.gmail.com> <CAGL0X-qLikj3bKervpASEixnEVLjBGDN=8QX8K6SG-A2Z_dVUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Blind <stoycho.sleptsov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 12:31:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7lPd-00034E-8q
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 12:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502Ab3BSLal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 06:30:41 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:48832 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529Ab3BSLal (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 06:30:41 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so8326215iec.18
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 03:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ySqULxrf70Y1J2WMDCC0wxB3qOC004HoC2ZqtUgHvHc=;
        b=cv5UIHZeV3LoGUCbH0bPmEfdGyxdRlFVhqO5SnTZe5Rqbzuxig7NNCKBLiyTDqKtVK
         7myNLe9jmIVuCq/crjZdvAtG96Tsodh3iYoIvOVGyax0n7I/bSTyUY812Q9i5SUBhszi
         jPVxz45h968IAyDgJfmsMVnZjEVl53EJEln70IYbCxbzPZt0fKsXRX2FVYGhDex+jsQV
         17FwuKjhY+X4Vn/K+D729w9hR7P21pB+z/ioIvvrbv5vGcIHcgV9K9EGMp9k6gc8xKzV
         w14MdXAVj+NDGf12usBxTBDqpQKQ1oMZNeR2XfnqUlhFjtyIdx14dKYTs6gu2GjcaExG
         gcog==
X-Received: by 10.50.207.67 with SMTP id lu3mr9121288igc.12.1361273440716;
 Tue, 19 Feb 2013 03:30:40 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Tue, 19 Feb 2013 03:30:20 -0800 (PST)
In-Reply-To: <CAGL0X-qLikj3bKervpASEixnEVLjBGDN=8QX8K6SG-A2Z_dVUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216607>

Blind wrote:
> 2013/2/19 Ramkumar Ramachandra:
>> No.  I don't see why push.default is limiting.
>
> I just want to find a way to exclude a branch (or infact a group of
> branches) from $git push --all.
> so when I read your thing, I thought for a second that it could be a
> possibility... But seems its not the case.

What is your usecase?  If you have a local branch with the same name
as on the remote, why wouldn't you want to push-to-update it when you
make changes in the branch?  In other words, why doesn't push.default
= matching suffice for most practical purposes.

> ... or branch.<name>.pushremote can support some kind of a "none" value?

Not a bad idea at all, provided you tell me your usecase.
