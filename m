From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH] git-add -u: match the index with working tree.
Date: Fri, 20 Apr 2007 13:18:25 +0200
Message-ID: <dbfc82860704200418o4d27b5a6pc3ea2f5abe25be8e@mail.gmail.com>
References: <11770585393395-git-send-email-junkio@cox.net>
	 <20070420104930.GB13560@diana.vm.bytemark.co.uk>
	 <7virbrz47b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 13:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Her8I-0004Be-Ge
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 13:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992549AbXDTLS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Apr 2007 07:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992896AbXDTLS1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 07:18:27 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:46960 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992549AbXDTLS0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 07:18:26 -0400
Received: by nz-out-0506.google.com with SMTP id s1so714195nze
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 04:18:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=UlcWHV9SGP7Iy30UGvrJoGbLWUCceAj8ZrtuOTtbCPvxQ9v5Ss962Q5MjC03InXCaCu62gUQUPHOm4e04uHj2lsqezVGp8fSY1HJiVOCSBIAsjIx40g99ciJ43BmLWMlb5O4k3Dx1VnsUYugGwf0vjuM1GiwortCtpF23bwIEbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fviZBzT3PTb8T9W+O53yJaU68UNUkBruv5ooo+CQuQgKtR3Y6kcSFYdRd2E/el9O4586dojgosF6x5sBr8dgLXskpJrCfh5GXQscrgbUQ1d5kh4yF5JEZWuqCkeE2Xj+Zq6ZogKvseIHlNh8Zvd/P8yEEqpMRZ1ROGNZN4pumCQ=
Received: by 10.114.181.1 with SMTP id d1mr1193838waf.1177067905829;
        Fri, 20 Apr 2007 04:18:25 -0700 (PDT)
Received: by 10.114.193.4 with HTTP; Fri, 20 Apr 2007 04:18:25 -0700 (PDT)
In-Reply-To: <7virbrz47b.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: 00717dab9e5d1401
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45089>

On 4/20/07, Junio C Hamano <junkio@cox.net> wrote:
> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > On 2007-04-20 01:42:18 -0700, Junio C Hamano wrote:
> >
> >> This is a shorthand of what "git commit -a" does in preparation
> >> for making a commit,
> > [snip]
> >> -"git-add [-n] [-v] [-f] [--interactive | -i] [--] <filepattern>..=
=2E";
> >> +"git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--] <filepatte=
rn>...";
> >
> > Any particular reason for choosing a different letter than the
> > -a/--all that git commit uses?
>
> Haven't I explain that elsewhere already?

Yes, in <7vzm531ly3.fsf@assigned-by-dhcp.cox.net>.

Specifically:

> I picked "-u" instead of "-a" because I wanted to stress that
> this is about "updating" (which has connotation that it is
> relative to something, and in this case it is relative to the
> current "index"), and not about "all", which "-a" would imply.

  nikolai
