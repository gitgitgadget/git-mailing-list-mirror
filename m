From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/7] completion: make the 'basic' test more tester-friendly
Date: Sun, 18 Nov 2012 10:38:08 +0100
Message-ID: <CAMP44s2JgNcKMmhohdg1Ynz1C6r+HVCLm8XCqs=hhjE2_8vs-A@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-2-git-send-email-szeder@ira.uka.de>
	<20121117230022.GA3815@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 10:38:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta1Ka-0001Mr-HX
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 10:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab2KRJiK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 04:38:10 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34833 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab2KRJiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2012 04:38:09 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4024358oag.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 01:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=F40lkakYmv10dw7TbpnaG9LYfk5/LlRbejvJs3M6AKA=;
        b=znrGWa16+MsxXp3NqeOLXF7xKRnTLg2LJU323YbZ2LprDVpOx4bTC/ETW0yEAVyg6j
         f3SMtdpkTGVtx4mg+WYCtr+JXzT+KPRzYG9Pd7B3uEQzIb//CTabnwR624TX7u7Nr2NB
         DU+cuaoK9yGr/mdZbkTQ9i7R10cHhH+QD7JjJLIbVLXCoTc3wE33FqPT3kDbfpmlPJYR
         XRZ8vFlhWWolrZ25L7m+9FUd/WgHm4MqHCaMPwO+hajQM+ozaz/QwhXaVWofXN72B4rz
         zCf1skx2+RCTRBotB7xLTwFSrBYgWgYvyxIUIOTIp5rwNefvSrH6BZEOkAP7oEvN2FSN
         Go1w==
Received: by 10.60.12.233 with SMTP id b9mr8125375oec.95.1353231488717; Sun,
 18 Nov 2012 01:38:08 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 18 Nov 2012 01:38:08 -0800 (PST)
In-Reply-To: <20121117230022.GA3815@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210002>

On Sun, Nov 18, 2012 at 12:00 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> SZEDER G=C3=A1bor wrote:
>
>> The 'basic' test uses 'grep -q' to filter the resulting possible
>> completion words while looking for the presence or absence of certai=
n
>> git commands, and relies on grep's exit status to indicate a failure=
=2E
> [...]
>> To make testers' life easier provide some output about the failed
>> condition: store the results of the filtering in a file and compare
>> its contents to the expected results by the good old test_cmp helper=
=2E
>
> Looks good.  I wonder if this points to the need for a test_grep
> helper more generally.

It does.

--=20
=46elipe Contreras
