From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 6/9] remote-bzr: store converted URL
Date: Thu, 25 Apr 2013 20:12:08 -0500
Message-ID: <CAMP44s0csoD7y-YND-VyVWuZc+GxK7JPf5DLibXZxnFHNakjDw@mail.gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
	<1366934902-18704-7-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XmrxV3SdtdyjJq=HxUqVcLCMz_Fcq9=POm=oaWtrO4LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Apr 26 03:12:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXCz-0006Cj-9g
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758773Ab3DZBML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:12:11 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:63763 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757652Ab3DZBMK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:12:10 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so3150709lab.31
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=2Ny1ggbBzjxC338ATpLOoIekzEk5BLgl5+HkpeNlpYg=;
        b=tr6KNKR7iQHhbKn0SUF0oAY25DqYLSwtdpcq22pZB2/6UeFOlOoNoMDJ7orPhm8rOf
         FZEnACw/5jvVQOlvan4Sio+vGN4xxfEIRbcrOvyQYe+X6dB1cmnlvVPy2VuN4hEN+H7S
         q/fiifHum/+BnlNwMyubo7/2vdmFpkgxoMrcY/h4J3XchA9RZR0ngu0s+d9nFA4YLFLm
         r7J94iKrokY1UiCAgVb6Z9DZHumv8paPT+heSTvlohjQpkl3BOPZEYHCQlJrBL/dGzxQ
         Rp57o9rcvst+95H61f5ZFzCQlEYRb6gLmioppeiOrgVlSPQuhQ828TRoSmVuzyhXGbHD
         76hA==
X-Received: by 10.112.139.226 with SMTP id rb2mr20102207lbb.12.1366938728522;
 Thu, 25 Apr 2013 18:12:08 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 18:12:08 -0700 (PDT)
In-Reply-To: <CAEBDL5XmrxV3SdtdyjJq=HxUqVcLCMz_Fcq9=POm=oaWtrO4LQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222503>

On Thu, Apr 25, 2013 at 7:58 PM, John Szakmeister <john@szakmeister.net> wrote:
> On Thu, Apr 25, 2013 at 8:08 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Mercurial might convert the URL to something more appropriate, like an
>> absolute path. Lets store that instead of the original URL, which won't
>> work from a different working directory if it's relative.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/remote-helpers/git-remote-bzr | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>
>
> FWIW, it feels weird to be talking about Mercurial when you're
> patching git-remote-bzr. :-)

Yeah, it happens all the time in my local repos. I'm surprised it took
so long to send a patch with this mistake =/

-- 
Felipe Contreras
