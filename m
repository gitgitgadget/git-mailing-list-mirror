From: Uri Moszkowicz <uri@4refs.com>
Subject: Re: tag storage format
Date: Tue, 23 Oct 2012 13:28:15 -0500
Message-ID: <CAMJd5AQxowh+XHbZzt9-=DhbYpKkozxNacxxi_KmVDuxMXsD7A@mail.gmail.com>
References: <CAMJd5ATiAx09eAEo1=6+=hPv=5c6qtOiLRG5jrQn5dfCKUrvMQ@mail.gmail.com>
 <m2vce2xh06.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 20:28:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQjDc-0003gX-QS
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 20:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933314Ab2JWS2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 14:28:37 -0400
Received: from mx71.nozonenet.com ([204.14.89.24]:54182 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933276Ab2JWS2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 14:28:36 -0400
Received: (qmail 13309 invoked by uid 399); 23 Oct 2012 14:28:35 -0400
Received: from mail-vb0-f46.google.com (smtp@4refs.com@209.85.212.46)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 23 Oct 2012 14:28:35 -0400
X-Originating-IP: 209.85.212.46
X-Sender: smtp@4refs.com
Received: by mail-vb0-f46.google.com with SMTP id ff1so4619484vbb.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 11:28:35 -0700 (PDT)
Received: by 10.52.37.103 with SMTP id x7mr17891589vdj.61.1351016915285; Tue,
 23 Oct 2012 11:28:35 -0700 (PDT)
Received: by 10.59.0.70 with HTTP; Tue, 23 Oct 2012 11:28:15 -0700 (PDT)
In-Reply-To: <m2vce2xh06.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208237>

That did the trick - thanks!

On Mon, Oct 22, 2012 at 5:46 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> Uri Moszkowicz <uri@4refs.com> writes:
>
> > Perhaps Git should switch to a single-file block text or binary format
> > once a large number of tags becomes present in a repository.
>
> This is what git pack-refs (called by git gc) does (by putting the refs
> in .git/packed-refs).
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
