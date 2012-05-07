From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v4 1/6] completion: add new __git_complete helper
Date: Mon, 7 May 2012 22:53:40 +0200
Message-ID: <CAMP44s15BbH2-kVQCO9s9ZEQLDTLcNRUw=4XiTmHoABa06kwUQ@mail.gmail.com>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
	<1336353800-17323-2-git-send-email-felipe.contreras@gmail.com>
	<7vfwbb6czu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 22:53:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRUwF-000790-Oy
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 22:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411Ab2EGUxn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 16:53:43 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33815 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189Ab2EGUxm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 16:53:42 -0400
Received: by eaaq12 with SMTP id q12so1533148eaa.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7Gzh9r2L46NWCzwThG3yt+Dsazt7hhytBBPoGD8dngw=;
        b=exYNQdbA/FI8ctZxVd7kTe2XYuhW6lnAYEOLbllVi36IePkeLiuHLacwqgVlT0KYHd
         pwEmUBEul7qgF07XySsV5lM6c0Et4wY1Z8wuQiR8DF57ODFjOHYBUZEs/ZhHahh3WdfN
         hp+6e2aLZFiiKXHFttN0maEvwXOpCwmZILJ1gFX5G8jaFOhsnmAOn9zUfgkw+a2E5WiU
         9UnH0kutaNBVkGdIYp9H1GQGA6Vq1LrVM9Zeq2JtW1zMzF4qsIAe0nR+B1mecXJS4NR1
         W4FMltoMARS5VC7JtzfR5cA1rt2a0gYm/L3k3FNv6Vx3BwhSdT7NGVEJNy9Cny8TJoky
         acgw==
Received: by 10.213.113.14 with SMTP id y14mr482845ebp.12.1336424020910; Mon,
 07 May 2012 13:53:40 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Mon, 7 May 2012 13:53:40 -0700 (PDT)
In-Reply-To: <7vfwbb6czu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197304>

On Mon, May 7, 2012 at 8:51 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>
>> +# this is NOT a public function; use at your own risk
>> +__git_complete ()
>
> The comment is enough to scare away people who might use it and then =
come
> back to complain when this changes its implementation detail, but say=
ing
> "This is not X" without saying "This does Y" does not help those who =
want
> to contribute updates to git-completion script. =C2=A0Is there a shor=
t and
> sweet description of what this is for and/or what this does?

No. And this patch is not meant to help those people; I don't even
need this, it's not my itch, I just did it because other people
complained. Those people would have to scratch their own itch if they
want some description of __git_complete (), I only want to reorganize
the code and already did more than my fair share.

--=20
=46elipe Contreras
