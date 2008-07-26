From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: git-scm.com
Date: Fri, 25 Jul 2008 17:59:58 -0700
Message-ID: <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 03:01:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMY9e-0007Nz-LQ
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 03:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbYGZBAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 21:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbYGZBAA
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 21:00:00 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:50419 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbYGZBAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 21:00:00 -0400
Received: by an-out-0708.google.com with SMTP id d40so768904and.103
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 17:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=odZzvdbKbygh2K2mnEYT3kau/1+0h76n+6vMI1SCUy0=;
        b=g/pDLpByNKwn9RjIZmmvh5x3H4+nnXsOJSy6kc0y1zQ47A7/pA+2aPVY310KRPY5UY
         4cVvoi3QQtZWiHXE4LezYVWjKdSQn2qC1pyfcsOJpe0qpkyCPn1Q7PRFzobHhvwqsBJK
         gEmpI7YCshvvgcSXMaOEG0MJCeBpUpVLFeHh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H5aC4wQoQIIr3dnQTK67T1VYEjb2CFNowoJznZTd5vWdDGrO7W5qZiay02v7OQtpmv
         JDk0Pqc2jhMAsoLKi0bo6KfN0seimWDmKQ1pX6Rx8dOj/xDBGFBNzkXSyLuuU+OPNVVL
         QmGbf/Nis/hQ/JvQLdR5If2e7ZjV6D/TsXUJY=
Received: by 10.100.120.15 with SMTP id s15mr979719anc.150.1217033999059;
        Fri, 25 Jul 2008 17:59:59 -0700 (PDT)
Received: by 10.100.165.5 with HTTP; Fri, 25 Jul 2008 17:59:58 -0700 (PDT)
In-Reply-To: <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90143>

Thanks Junio,

I fixed the things you mentioned here, except for the list ordering,
only because I kinda think you big contributors should be at the top
there, and also because it's slightly more difficult to populate an
html table that way :)  If everyone feels strongly about that, though,
I will change it.

Scott



On Fri, Jul 25, 2008 at 4:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think counting merges in "The Authors of Git" statistics give quite
> skewed numbers.  If you are generating it with "shortlog", you probably
> would want to give --no-merges to the command line as well.  Also it
> appears that you are not using .mailmap to avoid counting the same person
> as different people.
>
> I find a tabular list like this list easier to read if it were sorted like
> this:
>
>        A       D       G
>        B       E       H
>        C       F
>
> i.e. not like this:
>
>        A       B       C
>        D       E       F
>        G       H
>
>
