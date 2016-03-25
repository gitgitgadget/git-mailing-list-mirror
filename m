From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v9 2/3] t7507-commit-verbose: make test suite use write_script
Date: Fri, 25 Mar 2016 20:20:49 +0530
Message-ID: <CAFZEwPMxESunF2FojXY0AwBQuNqJuRrqWxnDwHESjypi5zJdXA@mail.gmail.com>
References: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
	<1458817259-11675-1-git-send-email-szeder@ira.uka.de>
	<CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
	<20160325154638.Horde.LzlsD6cZcQfmt894cll_0Tl@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 15:50:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajT4i-00057Q-CC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 15:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbcCYOuw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 10:50:52 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35568 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbcCYOuu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 10:50:50 -0400
Received: by mail-yw0-f195.google.com with SMTP id u8so1407964ywa.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=MT3p4x/rE7L4FaCeYEjRxZxpa8NcVOtkMPQ0WDgfSRw=;
        b=dreEefrRg2MwrOA39r0YzHFIUx3twi2DZiNfW2QAo0+BUq0cbh24J4ud7JUSQUzhE+
         ehvAbWkFO0iUTIihDVozXe8aGOQbb5R9KZMICzS/U/7e6cvpF7y9+xd0bxgAKJOi73C9
         vlJdEBxWzM2bwAC0b8rTipI1FhL+QWF5em3rvu8RkH494VJqeA4KMD0VjszrxSqM5MKn
         kXL6igGK2Je+LOzJTKBof526/AloNLAY+abQpymYsr7RZRw/WdJwWkMw0I4xVMxKDx+A
         sYHYwhjqCigs+8Kw+GriHRj694RwiBHZH3NN0D/9jZWy97laVeWrOyBxuKv2WeIdtZ4g
         OoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=MT3p4x/rE7L4FaCeYEjRxZxpa8NcVOtkMPQ0WDgfSRw=;
        b=NAonKSjNkBrENTy2RDTAp0fuRvpOD9ZyFTtC9uzO6aS5398Zv4E/RWZvLBpNmAGrcL
         0Kk7DKikR+tWL3zLXZgZ1fGOqpZBSswfYDK6qmXkBJJ1bI8zIkPj1mpTdH04N5HdquTc
         ZlIDvktKVFTj0zwRqfjWOl+z1hWUq+6C/GEOZ5oEjYWrtlW2BxgQvGHljTys7lsfDZmT
         GHzEMBI9rnF2WGqZMFKleKjB3i0kK3eRCpkzNP8aDhJpnUQJXizaz0FfO2nSVbesqP/x
         Oq3ZoSlaTSPeqO0ttAPgPm0gx01VWRGrubnLlXlmuxqkd4tSPVa8Cyvu85mxLnk5WloR
         +XPw==
X-Gm-Message-State: AD7BkJK25FmcFNN7yAOfQNiBVvhwZaq8EJ3iKFjCoUd/I/A9ZuxzoAmYprfLtpgBGZbN3hhIq/GW/uGKCwfbEw==
X-Received: by 10.129.94.7 with SMTP id s7mr8317923ywb.93.1458917449736; Fri,
 25 Mar 2016 07:50:49 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Fri, 25 Mar 2016 07:50:49 -0700 (PDT)
In-Reply-To: <20160325154638.Horde.LzlsD6cZcQfmt894cll_0Tl@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289894>

On Fri, Mar 25, 2016 at 8:16 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:

> By redirecting grep's output to a file in the editor script, like thi=
s
> patch wanted to, we can count the lines in the test script itself aft=
er
> 'git commit' finished.  This way we could use test_line_count, with
> all its error reporting benefits, and we could use the same editor
> script for all tests.
>
> And if you insist on doing the line counting in the editor script, th=
en
> why redirecting grep's output and 'wc -l' separately, why not 'grep -=
c'?

Nice way. Hadn't thought of this before. This will also eliminate
having 2 different scripts to test for 1 line and other to test for 2
lines.
