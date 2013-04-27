From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 12/20] remote-bzr: split marks file
Date: Fri, 26 Apr 2013 19:35:29 -0500
Message-ID: <CAMP44s3jw-uy_BJyWjkGEPPeEiD4A8M3ywAAbmWRn44vfvDTvQ@mail.gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
	<1366938488-25425-13-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2dzV428+_ZENg_Z5n=rnvqz1ZNAxnjsqCtLSJK-9PZZg@mail.gmail.com>
	<7v4nesvncw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 02:35:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVt71-0002JI-Dx
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 02:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809Ab3D0Afb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 20:35:31 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:51510 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab3D0Afb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 20:35:31 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so4227922lbf.4
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 17:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mFvjE4Jr45MB+ceR5233fGIrQZD+CujejShU37kBtTU=;
        b=n9Q9ZPb/JZeQ1CaZ9qBebPYkyDkdLqGlCk6aL+XRhENKA7j7RRR98e8zPFuOSXAzEy
         kyT/DaVXMhvc8uDIydFHPSCH/rXSUaaUZQn3iK0/krAZ8bc3lukMzfYoaJap8VL1VZzy
         s22u8Pisgw3pA9xdlCYBhdhUlRkYHGtpR+wXkMuZJqTUgvKuJMr5BZ1a9yBCmu8NmlAX
         zP5f+i5/5Avjn9/QPydE85BmhqYIuMJTt8WfQ5mHniT/eKZzbaGsIEUFd5BPWF/ItQX7
         r40RpEh2zoEP+GJ75elMBRG861OXJ/Rhfp5epS4UXcMI4kKZroIiNFDJJAbtGAGOlozT
         LkVA==
X-Received: by 10.152.20.134 with SMTP id n6mr11358582lae.19.1367022929628;
 Fri, 26 Apr 2013 17:35:29 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 17:35:29 -0700 (PDT)
In-Reply-To: <7v4nesvncw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222612>

On Fri, Apr 26, 2013 at 7:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> And in case anybody is thinking that remote-bzr is really a too fast
>> moving target; even if this managed to land in 'master', it's likely
>> that people were not able to push at all, and in fact, many were not
>> even able to clone in 1.8.2. So, hardly could be considered a
>> regression. Nevertheless, I caught it in time.
>
> You didn't.  I am already way too deep into today's 1.8.3-rc0
> integration cycle and I won't waste a couple of hours work just to
> revert this.

All right, if you already merged this patch series, you could do what
I did in my public branch: revert it, it's a single command, doesn't
take hours.

But I don't see this series in origin/master, am I missing something?

> But from your description it sounds like with or without the patch
> the helper is equally broken and it does not make that much of a
> difference.

Indeed. Many people would need this patch series to push, and this
patch breaks the push for more than one remote. So if you merged the
whole thing quite likely their situation would improve; they could at
least push to one remote, instead of zero. Of course, if you remove
this patch, they would be able to push to many.

But I don't see it merged.

Cheers.

-- 
Felipe Contreras
