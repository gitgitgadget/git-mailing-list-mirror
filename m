From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging area'
Date: Fri, 18 Oct 2013 06:26:22 -0400
Message-ID: <CAEBDL5UUyX5E6d3ewjZ_KxFuFZBqW=--kN81B1wXC2Re6KD2Bg@mail.gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
	<1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s3u_SMyZOe5jxkvoGn5MBJ_g70iHRT5v_3u1rZwFoqiVA@mail.gmail.com>
	<xmqqwqlbznfp.fsf@gitster.dls.corp.google.com>
	<vpqbo2m7vyz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 18 12:26:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VX7GV-000387-Ix
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 12:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab3JRK0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 06:26:25 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:53512 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599Ab3JRK0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 06:26:24 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so3466156wgh.13
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=y2wwrVTlWnsJUr+zVYJpoWQac7wpU654W3XexNXsqv0=;
        b=FJVVcqE84Lixu3QLLPpjQedynRa/WpogR2DqFh9yChUE6/h/UY9UkbhEDWdGn9YJlE
         zT4m3D0x19VzPCNNq98c8oOxxAgzvSdoOML2e8qeRPQDdAymE1cUqvz1fUSvd9nVb/iV
         XK+ofkJJwkTHmGzQjAqAc8d3gwD6U67lCoot078rUdVJHce74dF+J5D7eGKL9R3Fm9CL
         BbZMxceA1Xq92XDq3ylfKXT/UadTptO9o298NoX9RZRLAsUPb5ou5hX4GWcbO2e+lgVP
         qEmBeUgXcRqMwDpG+7EO6KZrRF3NEORv7gO9skD0z5tcRZmbIDjrbEHsXhc7Mh+xh5mh
         B4xg==
X-Received: by 10.180.20.46 with SMTP id k14mr1772427wie.39.1382091982953;
 Fri, 18 Oct 2013 03:26:22 -0700 (PDT)
Received: by 10.180.99.169 with HTTP; Fri, 18 Oct 2013 03:26:22 -0700 (PDT)
In-Reply-To: <vpqbo2m7vyz.fsf@anie.imag.fr>
X-Google-Sender-Auth: xyAdjYs9NRwbh-wiZo1OWhMNtrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236342>

On Fri, Oct 18, 2013 at 5:46 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I'm lacking time to read and answer in detail, sorry.
>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "It must be done" is different from "any change is good, as long as
>> it introduces more instances of word 'stage'".
>
> I agree. Something must be done, at least to remove the cache Vs index
> confusion. I'm not sure exactly what's best, and we should agree where
> to go before going there. The previous attempts to introduce more
> "stage" in Git's command-line (e.g. the "git stage" alias) introduced
> more confusion than anything else.

I definitely agree about removing the cache vs. index confusion.  I'm
curious about the confusions surrounding this "git stage" alias.  Was
it simply an implementation issue, or was it an issue surrounding the
name?

FWIW, I've trained my employees to think of it as a staging area as
well.  At least in English, it seems to be the best understood analogy
to the index's purpose.

>> The phrase "staging area" is not an everyday phrase or common CS
>> lingo, and that unfortunately makes it a suboptimal choice of words
>> especially to those of us, to whom a large portion of their exposure
>> to the English language is through the command words we use when we
>> talk to our computers.
>
> I do not think being understandable immediately by non-native is so
> important actually. To me as a french, "commit" makes no sense as an
> english word to describe what "git commit" does, but it's OK as I never
> really translate it. Even fr.po translates "a commit" by "un commit".
>
> That said, having something that immediately makes sense to a non-native
> is obviously a good point.
>
> Another proposal which I liked BTW was to use the word "precommit".
> Short, and easily understood as the place where the next commit is
> prepared.

I'm not sure what concept "precommit" invokes, but it's certainly not
where the next commit is prepared.  Two thoughts come to mind: the
precommit hook, and "what is a pre-commit?"  How would you talk about
preparing for a commit?  Do you "precommit a file?"  "Add the file to
the precommit?"  I'm just curious.

Thanks!

-John
