From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 12:47:16 -0500
Message-ID: <CAMP44s2YdG_pE7gnKfUJJP0SaO5pKu+kxPB=T74p14fuqXU9OQ@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
	<20130609171810.GA10858@goldbirke>
	<CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
	<20130609173342.GB2091@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulji6-0008Oa-PC
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab3FIRrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:47:19 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36571 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab3FIRrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 13:47:18 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so5675387lbj.28
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Rj+3rN7S2NojpXhY6Y+JLBWuqPNyzfGo5+pIRt32mEw=;
        b=W+1TJMwzP8DGAFqbisAAiz1kYu+K1eN0gtUs4COCZ5x5fNtc39KVAxhVLXEY2Iyx/9
         WRz0w2yxMUi4A6RZ9u98RBmBU9FEqkXdCQyOTniT83lt4sPIx+HBM5LjvwX3qk/D9GJO
         JSm+vAyLzFVE6DZs9CsTZHrxuqCxbrAtVVtXARBRI9c0di/Lrz1n9EDIFCp0AJAB/P55
         rIspJHnsMTX+5JRvD1KSf+dzSWfrUpgiU7RS1KVDJR123zzNKzSvTGD92V+dEmOklEGh
         tIljVJTXnNK5xGWvMALR0qCXCtr8BbGFqKeg2CjYXffJ/Qt7B53/CXU0B04BvMYY02mF
         t6MQ==
X-Received: by 10.152.7.74 with SMTP id h10mr3292433laa.83.1370800036474; Sun,
 09 Jun 2013 10:47:16 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 10:47:16 -0700 (PDT)
In-Reply-To: <20130609173342.GB2091@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227052>

On Sun, Jun 9, 2013 at 12:33 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Sun, Jun 09, 2013 at 12:23:01PM -0500, Felipe Contreras wrote:
>> On Sun, Jun 9, 2013 at 12:18 PM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>> > On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wrote:
>> >> We should free objects before leaving.
>> >>
>> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> >
>> > A shortlog-friendlier subject could be: "sequencer: free objects
>> > before leaving".
>>
>> I already defended my rationale for this succinct commit message:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/225609/focus=3D=
225610
>
> Your arguments were unconvincing.

That's your opinion. The commit message I write and send is my decision=
=2E

--=20
=46elipe Contreras
