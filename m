From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: [PATCH] Fix typesetting in Bugs section of 'git-rebase' man page
 (web version)
Date: Fri, 10 Jan 2014 20:25:12 -0500
Message-ID: <CAEjxke-fPwTctUt9x_o1YwTKK2fX5TOPA7LStXUh+ejUVxZtpg@mail.gmail.com>
References: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu> <xmqqwqk37kdy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 11 02:41:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1nZm-0006V9-Fl
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 02:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbaAKBlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 20:41:23 -0500
Received: from mailhub246.itcs.purdue.edu ([128.210.5.246]:41864 "EHLO
	mailhub246.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbaAKBlV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jan 2014 20:41:21 -0500
X-Greylist: delayed 948 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2014 20:41:21 EST
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com [209.85.216.44])
	(authenticated bits=0)
	by mailhub246.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id s0B1PW39012233
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 10 Jan 2014 20:25:32 -0500
Received: by mail-qa0-f44.google.com with SMTP id o15so4758048qap.17
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 17:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iiWCicp+fhn6YrBd8nUcy9kgq0y9Jkg/6uWBesrsNcM=;
        b=EtMt4uvlmqE3bJLOWWGFFdRHwyQAhMRq/mz2vvNtoZAEzig3JVFr1jJwYT95D09w/P
         8gE6SjsY6NaaOxC0TPxl3z/V6YpGIDiqg+TPTn7Vj0Uof+Qpa6EMKZ+i9TMzhHV8JrBb
         7FEmevjNTe/V6PNyrp7VyCrsBEjweMU+BJdSrXFgzxu/BVIIqzy9BkpzPAFCk74BPXsD
         Mts4Z6sNCFWypQhEQdnA5xJWlRwcLvPndzQtMTewSr6927vMKfMgiwVRD+EyJVybQ1BR
         mM8vNADxQUapuPMyvzg3fMfioXto2A6HCCN/RwgqX/7E9JJfsLLHY+c3SjtJfE2MOg/f
         xd8A==
X-Received: by 10.224.76.70 with SMTP id b6mr13648805qak.19.1389403532153;
 Fri, 10 Jan 2014 17:25:32 -0800 (PST)
Received: by 10.224.59.134 with HTTP; Fri, 10 Jan 2014 17:25:12 -0800 (PST)
In-Reply-To: <xmqqwqk37kdy.fsf@gitster.dls.corp.google.com>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240325>

On Tue, Nov 19, 2013 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Jason St. John" <jstjohn@purdue.edu> writes:
>
>> Documentation/git-rebase.txt: add a blank line after the two AsciiDoc
>>     listing blocks
>
> That looks funnily formatted, out of place and redundant.
>
>> Without these blank lines, AsciiDoc thinks the opening "-----" is a
>> section heading and typesets the word "to" as such, which causes
>> cascading formatting/typesetting issues until the end of the document.
>
>>
>> Signed-off-by: Jason St. John <jstjohn@purdue.edu>
>> ---
>> You can see the carnage here:
>> http://git-scm.com/docs/git-rebase#_bugs
>>
>> This fixes GitHub issue github/gitscm-next#281
>
> Hmph. https://git-htmldocs.googlecode.com/git/git.html has HTML
> documentation pages I preformat, but as far as I can see, the bugs
> section of git-rebase(1) does not have such a "carnage".
>
> Perhaps git-scm.com uses some buggy formatter?

This does seem to be an issue with git-scm.com only, so this is
probably an issue with the AsciiDoc formatter they use.

What AsciiDoc formatter (and version) do you use?

Sorry for the long delay in replying!

Jason
