From: Dill <sarpulhu@gmail.com>
Subject: Re: Translations [of Documentation] in Git release?
Date: Mon, 26 Jan 2009 12:58:24 -0700
Message-ID: <60646ee10901261158w65b539dida26d2bd3bae6903@mail.gmail.com>
References: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com>
	 <m3hc3mxn9d.fsf@localhost.localdomain>
	 <Pine.LNX.4.64.0901261426350.7798@ds9.cixit.se>
	 <200901261631.18157.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 21:00:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXcj-000633-9N
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbZAZT60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZAZT60
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:58:26 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:44917 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbZAZT6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:58:25 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6004809rvb.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 11:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AlbwA/0ks+dSzXnVXGhLTqET+8SyQYURmUTtepiTM90=;
        b=eigDYYKUE/u4+AGwUCfOn+Nq/eWnamx+iUEJl8eEuG5OK4Evc8TXosMHXxFiXDxzEk
         +d5UFvQQhqTsLHBVSm+ujdsXePahDDw2Ei7pCTZQ3lqZeJo1obBSYKJ5t+dzeEa+/BJ5
         C44eHmznWxJYgJRK7W/LiRosz0GaFCwWQeMjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jWRGc3XvjRRRMcCH2Uv95S5xKw/Q3qeEikymPGJO+bTFHiMHzMHbKDcKXeot0eWrlh
         l5s1V1XDsm/WmTT5Z1ERMHupM0XL4Ch+jFhMzNS+7XaME+OCqrnCC52DslhFG6FXhMNY
         1xL8cH+eKitVDmmPaNrnVCZpZ0dqFSQwoz3wg=
Received: by 10.141.180.5 with SMTP id h5mr1205088rvp.82.1232999904423; Mon, 
	26 Jan 2009 11:58:24 -0800 (PST)
In-Reply-To: <200901261631.18157.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107262>

I was thinking of handling it like the Linux kernel documentation...?

On 1/26/09, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 26 Jan 2009, Peter Krefting wrote:
>> Jakub Narebski wrote:
>>
>> > With GUI translations we just use gettext conventions. I don't know
>> > any such convention for docs:
>>
>> There is a lot of documentation being translated using PO files. po4a -
>> http://po4a.alioth.debian.org/ - is a nice starting point for that.
>
> I'm not sure if XLIFF wouldn't be better format to use to translate
> _documents_.  Gettext was meant to translate, I think, not very long
> messages in programs.
>
> Also I am not sure how much support this idea has. True, in last Git
> User's Survey[1] 63% to 76% wanted (parts of) Documentation... but that
> was out of 325 people who answered this question, with 3236 responses
> to survey in total, so numbers are more like 6% - 8%.
>
> [1] http://git.or.cz/gitwiki/GitSurvey2008
> [2] http://translate.sourceforge.net/wiki/
>
> --
> Jakub Narebski
> Poland
>
