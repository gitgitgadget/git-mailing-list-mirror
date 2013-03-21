From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Which file is older in history?
Date: Thu, 21 Mar 2013 17:29:39 +0530
Message-ID: <CALkWK0nRgzNYViKSx97OyHVOQmFN61Ex9EUvr1JK-0=GX=uX0w@mail.gmail.com>
References: <CALkWK0nTjoR9qBY-hnkrDKnyf8088ZDJ1LK_zNqAoAB7ndvaww@mail.gmail.com>
 <7vobeddcjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 13:00:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIeAd-0004JO-V7
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 13:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab3CUMAD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Mar 2013 08:00:03 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:43670 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab3CUMAB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Mar 2013 08:00:01 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so964958ieb.9
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=aPN3trEunGQ8i6CxJOr7K3nX5aMNj4sY80ro3yzLDxY=;
        b=a4aZTkZ4L+r5sTm7aIjHr6WaYWAGnWocgJBQC1p6hDeVVRFetu2FXL1W/4oXde1uqA
         xvVuqwsc1viY1ICXJjN6sTK4akxFuzRVYSSLFW4G0Yn0eXOX1hLziWoFN5FNhXfVYZME
         KL0HlAcOyQcwkMqAvyo0kfkt4SETBY53EOMZYdE5ALiUMTq54EY4Wj9E6oyItyMNnpmU
         YztR8hrciH0tZn5TZCyB/OgJ1RHYu2RLK86rpOpyz3P8rTpITPf7KskfHu8TNybHRVbA
         uQwNMHWoq7A/dCP45N4BYu9wB68XAqpANzrueyjz9PurG0xykpOrlgO4rzFyOmE8hTpj
         s8xg==
X-Received: by 10.50.119.102 with SMTP id kt6mr2015483igb.12.1363867201136;
 Thu, 21 Mar 2013 05:00:01 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 21 Mar 2013 04:59:39 -0700 (PDT)
In-Reply-To: <7vobeddcjq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218714>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> I want to compare two files in a git repository and tell which one w=
as
>> introduced into the repository earlier, assuming that they're in the
>> same history line (by ancestry, not timestamp).  The naive way to do
>> this is to find the individual commits that introduced the files
>> (`rev-list HEAD -- <filename> | tail -n 1`), and...
>
> This must be a trick question but the na=C3=AFve way I think of is
>
>         git log --diff-filter=3DA -- path1 path2

Thanks, I didn't know about --diff-filter.  I'll need one extra step
to figure out which commit corresponds to the introduction of which
file, no?
