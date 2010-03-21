From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sun, 21 Mar 2010 14:16:27 +0800
Message-ID: <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <4BA544FC.7050007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Sun Mar 21 07:16:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtESq-0007PJ-7U
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 07:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab0CUGQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 02:16:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:17696 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab0CUGQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 02:16:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so922242qwh.37
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 23:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=0gVLGvlzlL5LfVzLd6hroW49jFEFOwhLQuvcJyAXmrE=;
        b=k2/PMgxScr9xdvsAavh3CaBVk4TO/g5q3F9pt6qGV7nV4ZCgA7ZDt5iubA/mYtNZG5
         ZOm6BQ4swI8b5E1GUgVkoQ4EROMdpZojSFRdKcuus9XeVuJORT5+sGX5FCTuMQkCBQaB
         irz78y76MyOvljHL/U1JrdXK+hFxSFoVr14K0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VMWbVz59Ypj0Ql0+H4DuxUi10Q3sFFlhV/9ZM9EM/gHmkMzWaXsZwt3jn7cRmS+gkD
         qj9rQMIUkHeXzKdR1Z1NGH6cRn2P8ZALbM3N5I/uptDgkRSfG3Cq8qexKuB17FejS7VH
         pZWnm3I/qISutb9suyL2hRznY5YAyIUVBn7vE=
Received: by 10.229.10.132 with SMTP id p4mr1005730qcp.86.1269152187869; Sat, 
	20 Mar 2010 23:16:27 -0700 (PDT)
In-Reply-To: <4BA544FC.7050007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142793>

On Sun, Mar 21, 2010 at 5:58 AM, A Large Angry SCM <gitzilla@gmail.com> wrote:
> Alex Riesen wrote:
>>
>> On Sat, Mar 20, 2010 at 10:18, Bo Yang <struggleyb.nku@gmail.com> wrote:
>>>
>>> <line range>
>>> Its format should be <start pos>..<end pos> or just a <line number>.
>>
>> You might want to reconsider the line range syntax. Exactly the same
>> syntax
>> is already used to specify a commit range, so reusing it may lead to
>> confusion.
>
> I, actually, think the proposed line range syntax works because it uses the
> same _range_ notation. The issue is how to differentiate the _line_ range(s)
> from the _commit_ range(s); and, yes, I would like multiple ranges of each
> type as well as multiple files.

As what I said in previous post, I think we should adopt 'git blame'
way. Use a '-L <start pos>,<end pos>' to specify the line range. It
support both line number and posix regex.
For multiple ranges stuff, I don't think it is very useful to support
it for a history browser. Anyway, our users can only focus on one line
of thread history. I am very willing to listen what is your use case
for a multiple ranges?

Thanks for your precious advice!

Regards!
Bo
