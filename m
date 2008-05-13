From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Tue, 13 May 2008 15:37:32 +0200
Message-ID: <bd6139dc0805130637saf704e1v2ab67c99da3078c3@mail.gmail.com>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com>
	 <200805121440.12836.jnareb@gmail.com>
	 <bd6139dc0805120604m349b1fbbr39c6dcb8d893e771@mail.gmail.com>
	 <200805131507.04912.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 15:40:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvuiI-0004CW-7b
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 15:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166AbYEMNhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 09:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757318AbYEMNhf
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 09:37:35 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:11124 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756213AbYEMNhe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 09:37:34 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2738209wfd.4
        for <git@vger.kernel.org>; Tue, 13 May 2008 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=9W5G+loUjyQ8MWZwOG4hoNnmTU2oMf/u38paylDtsP8=;
        b=pRD/bmUg4/XnAniDnC5TgCvY2cPEVQyKbuxdDz7Ew4hxc7uvQfB9eNOOYjr9v6riB3KGCLnxv0utuog2X7EnsmXi3E90WM8IYuxJ4RcmpzeuNgXE3D7WmSNt5/xP6d/pJA9pacbyRFFk1h47RT6frZKchU0PSuF6On/EBJk9RY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=EtaETWong6tv8gN/IPWvW4PhZAkfXWIhm96VQ9Jmgp6XSskiMshtSxfhO0oNcKvfBXI197EsPyNeiq8Qa1F3/SbulKw2haR2d9pBbFMiDZ97SaYIwn9OUIYhW6CEK0k8zsXwUWbArIuLg6UrV3/DYbHlqvYpX7yAX/rQK4Bjyro=
Received: by 10.142.230.11 with SMTP id c11mr3794659wfh.334.1210685852499;
        Tue, 13 May 2008 06:37:32 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Tue, 13 May 2008 06:37:32 -0700 (PDT)
In-Reply-To: <200805131507.04912.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 80aea25c839b1e6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82029>

On Tue, May 13, 2008 at 3:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>  And now you apparently forgot to add git mailing list to receipients...

I guess mailinglists are not my thing huh?

>  > On Mon, May 12, 2008 at 2:40 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>  > Ah, there is a lot more to this example than I thought. Perhaps this
>  > data could all be shown and then, using some "importance" metric per
>  > item a "grade" can be calculated?
>
>  Weighting different statistics, bayesian hypotesis/filtering, expert
>  system, machine learning... I guess that would be quite a work to do
>  it well.  Probably would require to calculate and adjust scoring of code
>  (difficulity) and authors (skill), and matching them...
>
>  This is certainly in the "wishlist" scope.

Yeah, I think it would go in the 'c' of 'MoSCoW', but it could be very
useful when done right.

>  >>  Details I think need to be provided by maintainer...
>  >
>  > Do you mean Junio, or the user of the program?
>
>  I mean that all I can provide is speculation.  I'm not, and never was
>  a maintainer of OSS project, and I don't know what criteria one use
>  (perhaps unvoiced criteria) to decide whether given patch needs to be
>  examined more closely, or the cursory browsing should be enough.

I reckon more input from actual maintainers would be needed then.
Junio: aside from the original list with suggestions you provided,
could you shine your light as git maintainer on this?

>  I mean, given the code at given version, what happened to this code?
>  Filtering "git blame --reverse" by user might be one way of solving it.

It sounds like it would not be too hard to implement' maybe another
'C' in 'MoSCoW' (or perhaps that first 'C' should be a 'W'...)

>  What I had in mind here, but didn't explain clear enough, was an
>  extension to pickaxe search.  You want to find when current error
>  message was created, even if the way of handling it (fprintf vs. die)
>  changed, or if code was indented, or was moved.

I'm not familiar with pickaxe, what you suggest sounds like grepping
the content also throughout history?

>  Or find all error messages, in the order they were created, for example
>  in git case to find ancient error messages and replace it by something
>  more user-friendly (or less selective about choosing friends ;-).

I understand what you want, a search for specific content, from old to
new, stopping when you have a match?

>  > Interesting article, I think integrating statistics
>  > (http://www.statsvn.org/ for example) can be a very powerful tool for
>  > project management.
>
>  You meant http://git.koha.org/gitstat/, didn't you? ;-P

I used the former, never tried the latter :).

>  Seriously, what I had in mind was to integrate author dates and commit
>  dates into project management system scheduling.

I'm not sure what gain that would bring though, as it can only provide
end dates, not 'starting work now' timestamps...

-- 
Cheers,

Sverre Rabbelier
