From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-testgit: properly check for errors
Date: Tue, 23 Oct 2012 02:57:11 +0200
Message-ID: <CAMP44s2=yxXGzUoxu=6baPv-6oq+UA9g1JdyqSSUYHS2800S2A@mail.gmail.com>
References: <1350939394-21622-1-git-send-email-felipe.contreras@gmail.com>
	<CAGdFq_gOb3GX1iZshGZahZEbj3RqQSEk8AN_hHXKyD5aHwfxYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 02:57:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQSo8-0002Tu-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 02:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321Ab2JWA5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 20:57:13 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54734 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab2JWA5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 20:57:12 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3084595oag.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 17:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aglPuvbFzz8mRYDfeqio8X7sEyt0Gw7BVRX5w4j5Vn4=;
        b=xuk1rq3gnnP8tm4xfBJY8Nn/D/0dh0dUKPyZzNMLpfyMsfnlbEyW6dv9wOb5KfgN33
         /eOll+G5m1uYmrDkWsoYcAYhbwphw+hIm2W1fnjzCHTXjSE6+gi3aGCb/Ao91DWYhKvh
         BBpFft20pcsfqtYG9PzycSLsLL94VEcoa7dehcadQAyFdLbRRGsxWs0yms4gMjFmWeZo
         QvOW+UsqVjmsuEkh35QuBCamZPSSLw8edAsEpUiwN3prgUfcGV3y+7XmftkemSFG/4Ly
         5PKmFScwVElYjzF0q4xsHAcv+d+FEeSJWz42LPcqZ7C+b271DsNoID9AuKZzlQzx35V9
         Enuw==
Received: by 10.60.31.241 with SMTP id d17mr9605307oei.107.1350953831990; Mon,
 22 Oct 2012 17:57:11 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Mon, 22 Oct 2012 17:57:11 -0700 (PDT)
In-Reply-To: <CAGdFq_gOb3GX1iZshGZahZEbj3RqQSEk8AN_hHXKyD5aHwfxYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208210>

On Mon, Oct 22, 2012 at 11:01 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Mon, Oct 22, 2012 at 1:56 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> diff --git a/git-remote-testgit.py b/git-remote-testgit.py
>> index 5f3ebd2..b8707e6 100644
>> --- a/git-remote-testgit.py
>> +++ b/git-remote-testgit.py
>> @@ -159,6 +159,11 @@ def do_import(repo, args):
>>          ref = line[7:].strip()
>>          refs.append(ref)
>>
>> +    print "feature done"
>
> There's not enough context for me to see in which part of the code
> this is, import or export?

Isn't this enough?
>> @@ -159,6 +159,11 @@ def do_import(repo, args):

It's import.

> If you advertise 'feature done', shouldn't
> you also print 'done' when you finish writing the fast-export stream?
> If that's already the case feel free to ignore me :)

It's already there:
http://git.kernel.org/?p=git/git.git;a=blob;f=git-remote-testgit.py#l165

Cheers.

-- 
Felipe Contreras
