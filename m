From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Thu, 5 Apr 2012 21:47:22 +0600
Message-ID: <CA+gfSn8_x7OPUmQ96we3YFhCG8EybKENBY0f+D+dAYQjb8Skzg@mail.gmail.com>
References: <11292500.AVmZFUUvNi@flobuntu>
	<2148933.pnpYo0xMAP@flomedio>
	<2487557.B8qfnaixh3@flomedio>
	<1421035.yALBSXSHGd@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 17:47:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFouH-0006wy-Gu
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 17:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab2DEPrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 11:47:24 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59722 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab2DEPrX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 11:47:23 -0400
Received: by lbbgg6 with SMTP id gg6so127230lbb.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p7DWVd4DMI6Fe+d9qa4J7GnQP2qXp/kIWW6LU37WygA=;
        b=fEhcr+UXDp+17PMo2isVWbaw/oYmXTGHXvbrPUnwChwTJQdy6/2OCtSLGRXAGGOLEh
         UOY3MZQwxb93OKW2GdD0KVB6JYnvnNXb48xIz1O3yFkNK10JPEtf0vuIWyM+ukbgioIg
         N0bHSrzv6gTCl9ehcYISHEfWCa9G3cRJ0PqzWnq5/mdhuwZTcUAOcSRulFD/MV0KGQbN
         o/NuegJkEfsqppISKG5L42/RtHY5YS2f2P3whDOTzLKWvapMSvKEyrtOkuUE9hOpWHfn
         pwyfaarL+Z5667cuqmH2zDHVAxxfgSc8a0OyDgZIcDlQWssdDU168CZYd84S8p8JCGiL
         pxfg==
Received: by 10.152.115.38 with SMTP id jl6mr3729082lab.24.1333640842231; Thu,
 05 Apr 2012 08:47:22 -0700 (PDT)
Received: by 10.152.11.231 with HTTP; Thu, 5 Apr 2012 08:47:22 -0700 (PDT)
In-Reply-To: <1421035.yALBSXSHGd@flomedio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194782>

Hi!

On Thu, Apr 5, 2012 at 7:36 PM, Florian Achleitner
<florian.achleitner2.6.31@gmail.com> wrote:
> Hi everybody!
>
> Thanks for your inputs. I've now submitted a slightly updated version of my
> proposal to google. Additionally it's on github [1].
>
> Summary of diffs:
> I'll concentrate on the fetching from svn, writing a remote helper without
> branch detection (like svn-fe) first, and then creating the branch mapper.
I think that the general goal should include a possibility to clone
"svn:// clone" (not necessarily exactly "clone", special easy to use
command/script looks fine too) so that this new clone is able to fetch
and push too. This is a new feature compared to git-svn.perl and
allows to share svn->git conversion result. Not completely trivial,
but cool to have. At least I recommend to keep it in mind during
design phase(s).

Though it is not a must as there are many many other cool things to
implement in git-svn area :)

>
> [1] https://github.com/flyingflo/git/wiki/
>
> -- Florian
>
> On Monday 02 April 2012 10:30:58 Florian Achleitner wrote:
>
>>
>> ==Remote helper for Subversion==
>>
>
>
