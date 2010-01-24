From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Advice for "pseudo public" repository on a USB key for a single  contributer project
Date: Sun, 24 Jan 2010 11:21:51 +0100
Message-ID: <3CFFC525-266B-4E98-9A99-83316B22978C@wincent.com>
References: <554f5f781001231027vd322045hf84e2a16208bcc9f@mail.gmail.com> <be6fef0d1001231817s265dac68v646d71b688e0ed1e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Maxime_L=E9vesque?= <maxime.levesque@gmail.com>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 11:22:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYzbt-0003ok-0r
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 11:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab0AXKWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2010 05:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611Ab0AXKWS
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 05:22:18 -0500
Received: from outmail128067.authsmtp.com ([62.13.128.67]:57194 "EHLO
	outmail128067.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753260Ab0AXKWJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 05:22:09 -0500
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt10.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o0OAM44a011228;
	Sun, 24 Jan 2010 10:22:04 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o0OAM0VR089002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Jan 2010 10:22:02 GMT
Received: from [192.168.1.2] (133.Red-88-5-247.dynamicIP.rima-tde.net [88.5.247.133])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id o0OALpcH027433
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 24 Jan 2010 05:21:58 -0500
In-Reply-To: <be6fef0d1001231817s265dac68v646d71b688e0ed1e@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: 500f9e17-08d2-11df-97bb-002264978518
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJDkVH aBodDFNVdwdEHAkR AmYBWVZeUF8/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSwUXcGEB YHweWhBydwcIeXx3 YUYsW3BbCk0vdEFg QkYAF3AHZDM2dWkY AhJFdwNWcgVOdxhN b1F3GhFYa3V2Mjw5 FAJ7MTcrdX9HMylI TgZFNU8YRUcAVHYm SggFBjQzGlcUDyI1 ZxVuF2U2VEUcIw08 NkFpUBoDMhkdDgAW V0pKBjNDJlMcWycx RRtAWkwTGyE1
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137889>

El 24/01/2010, a las 03:17, Tay Ray Chuan escribi=F3:

> Hi,
>
> 2010/1/24 Maxime L=E9vesque <maxime.levesque@gmail.com>:
>>  Since there are no servers involved, I have used pull command
>>  to move my 'HEAD' around :
>>
>>  after working on machine1 I do :
>>
>>    commit to machine1Repo
>>    machine1Repo  --pull--> USBKeyRepo
>
> I think you mean "push", since what you want is to make the changes i=
n
> machine1Repo available in USBKeyRepo.
>
>>  when I switch on machine2 I start by bringing it up to date from =20
>> the key :
>>
>>
>>    machine2Repo  <--pull-- USBKeyRepo
>>
>>   and when I'm finished  :
>>
>>   commit to machine2Repo
>>   machine1Repo  --pull--> USBKeyRepo
>
> I think you mean "push" here and s/machine1/machine2/ too, so that =20
> would read
>
>  machine2Repo --push--> USBKeyRepo
>
> When you make changes on machine2 and go back to machine1, you need t=
o
> fetch/pull in your changes, just like you do for machine2Repo:
>
>  machine1Repo  <--pull-- USBKeyRepo
>
>>   From what I have read my USBKey repo is like a public repo,
>>  so I have tried using a bare repo, because since I never work
>>  directly on the usb key, the souces on this repo are just
>>  adding unnecessary complexity. So far I had no success,
>>  because the pull command doesn't recognize my bare repo,
>>  it seems that bare repos must me accessed via a daemon process.

=46or this kind of workflow I generally use pull in both directions. =20
Push works only if it results in fast-forward merges in both =20
directions, and if you are a little forgetful like me it's fairly easy =
=20
to sooner or later forget to update one of the repos and end up making =
=20
commits in both of them, leading to a situation in which at least one =20
of the merges would have to be a non-fast-forward.

If you always pull, you are at least working in a non-bare repo at =20
that point and you can choose to either (non-fast-forward) merge or =20
rebase.

Unless you are really disciplined about synchronizing the repos before =
=20
you ever start any work, then I think "pull" in both directions is the =
=20
way to go.

Cheers,
Wincent
