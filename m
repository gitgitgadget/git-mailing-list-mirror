From: Richard Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: How can I specify the "sendmail" program for git-send-email?
Date: Mon, 11 Jun 2012 17:04:31 +0800
Message-ID: <20120611090431.GA23447@richard>
References: <20120611073232.GA5602@richard>
 <CABPQNSbwtP0hp8QYznwXjLAaoKVj_ZUWXQQCDG80Xb+TME1MWw@mail.gmail.com>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 11:04:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se0YF-0000PP-3Z
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 11:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab2FKJEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 05:04:39 -0400
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:44289 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab2FKJEi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 05:04:38 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 11 Jun 2012 14:34:35 +0530
Received: from d28relay03.in.ibm.com (9.184.220.60)
	by e28smtp09.in.ibm.com (192.168.1.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 11 Jun 2012 14:34:34 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5B94YsF14221812
	for <git@vger.kernel.org>; Mon, 11 Jun 2012 14:34:34 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5BEZBWI025163
	for <git@vger.kernel.org>; Tue, 12 Jun 2012 00:35:12 +1000
Received: from localhost ([9.123.247.68])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q5BEZBQ2025146;
	Tue, 12 Jun 2012 00:35:11 +1000
Content-Disposition: inline
In-Reply-To: <CABPQNSbwtP0hp8QYznwXjLAaoKVj_ZUWXQQCDG80Xb+TME1MWw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
x-cbid: 12061109-2674-0000-0000-000004DB079C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199633>

On Mon, Jun 11, 2012 at 10:23:21AM +0200, Erik Faye-Lund wrote:
>On Mon, Jun 11, 2012 at 9:32 AM, Richard Yang
><weiyang@linux.vnet.ibm.com> wrote:
>> Hi, experts
>>
>> I read the git-send-email manual and find the --smtp-server option c=
an
>> specify the sendmail-like program to send mail.
>>
>> Then I use this option in command line
>> --smtp-server=3D/usr/bin/msmtp
>> This works.
>>
>> While I found it not very convenient to write the option on command =
line
>> every time, then I wrote it in the .gitconfig file in my home direct=
ory.
>>
>> [sendmail]
>> =A0 =A0 =A0 =A0smtpserver =3D /usr/bin/msmtp
>> =A0 =A0 =A0 =A0smtppass =A0 =A0 =A0 =3D 123456
>> =A0 =A0 =A0 =A0smtpuser =A0 =A0 =A0 =3D weiyang@linux.vnet.ibm.com
>> =A0 =A0 =A0 =A0smtpserverport =3D 143
>
>The configuration-section for git send-mail is actually spelled
>"sendemail", and not "sendmail". Notice the additional 'e'.
Oops, a stupid mistake.

Thanks all :)
>
>http://git-scm.com/docs/git-send-email

--=20
Richard Yang
Help you, Help me
