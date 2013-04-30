From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: verify signature hook
Date: Tue, 30 Apr 2013 07:54:42 -0400
Message-ID: <CAH_OBidNMOx7nAU01Tfpe6FBPnu4n_GhdSUctp4zF9pJACPEjQ@mail.gmail.com>
References: <CAH_OBieXyHuQBpG7Ge1wA4Q+MKBEy7MD-TpZmMLZjEF0jAzLwg@mail.gmail.com>
 <7vy5c1jnl0.fsf@alter.siamese.dyndns.org> <CAH_OBifz0k-mNw2fkzkSKozDTuaWMYX=vJD1U8aOdJuU4kMKRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Apr 30 13:55:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX99M-00041p-0l
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 13:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760370Ab3D3LzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 07:55:05 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:51525 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759848Ab3D3LzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 07:55:04 -0400
Received: by mail-vc0-f170.google.com with SMTP id hv10so324784vcb.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:cc:content-type;
        bh=CY7g5KbNH4uUyfua4DDzGLlGC1Bg9x6kwpUP5j9oT34=;
        b=VfMb2P6W3DFQiMJ7zfPBm/seRb/lP4CNzNV2YD3vfU+qCauMw03zYmFcEalni6btLw
         kuXHLZeAUxNQYgsWo+kgtEXIisadONEXBhM81hvAOXJ1/aTLEV41kGeAoPhCi5cQMQKv
         2J4hTP3BM7xTUxl+Tx4XZoPy5bi9wAZ9qVDMXkPZGmpUix4oO2eLh0ADazbBVFoZHQzG
         oyN/5Gz0m44NQmV8hBGSlGOmLJxNtO7fxcXULMrJy0/OMU2+VmVSjYoaKjS20ya4tPNR
         WCYJR4yYZYpkPRf+f4JF0zcPLnFvh4v/CBQpq0n2dArSjofjBcO/sAgNhVWCVKF9pXrt
         ybIg==
X-Received: by 10.220.202.138 with SMTP id fe10mr32234192vcb.26.1367322902773;
 Tue, 30 Apr 2013 04:55:02 -0700 (PDT)
Received: by 10.52.103.14 with HTTP; Tue, 30 Apr 2013 04:54:42 -0700 (PDT)
In-Reply-To: <CAH_OBifz0k-mNw2fkzkSKozDTuaWMYX=vJD1U8aOdJuU4kMKRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222930>

Apparently GMail for Android only sends HTML encoded emails (and the
list rightly rejected it).

On Mon, Apr 29, 2013 at 4:31 PM, shawn wilson <ag4ve.us@gmail.com> wrote:
>
> On Apr 29, 2013 12:42 PM, "Junio C Hamano" <gitster@pobox.com> wrote:
>>
>> shawn wilson <ag4ve.us@gmail.com> writes:
>>
>> > How do I complain when a commit/merge/tag/etc aren't signed?
>>
>> At which point?  A natural place would be to detect this just before
>> accepting a suspicious history being pushed in pre-receive hook, I
>> think.
>
> I was thinking of adding it to a post hook I've got that emails a report
> but
> I'm not opposed to just stopping it from happening.
