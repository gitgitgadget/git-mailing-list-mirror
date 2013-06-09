From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 12:23:01 -0500
Message-ID: <CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
	<20130609171810.GA10858@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:23:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljKf-0007Qc-Iy
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab3FIRXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:23:05 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:40787 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab3FIRXD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 13:23:03 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so1453359lbi.34
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RjXq3fvPl0YOgt0aFfscqmdCoWe/3WYoRhu48xuComo=;
        b=b3hVXhKcZJalNg4T8DhTMffxEWavN6PBVHXmFLhDGKHN9wD/JqS4knZBx/nIRVToI4
         gja/+7LX8GMJ31s09Q+GeLXkmwCPFQ+8g+ozymF4grfslhziDskLX62RDis2QzBHDk8r
         hiZtWnw+zc+6qTt9QcvfWsdH3753lPaii+T7RfGaYAF412guJthKSunE4oWGQwbLLRjz
         RUZEzD/QEQ/ylYpHvLuicWowzvijYqV7AS4iFjN0ASf6A3W7GEBNvM2uHMrb5vamu+xY
         5sxxrOFGDvSrVKFmrGeiT8/SnovNL1zzKOA3qFAXav/lJi54FjLrNIFtde0HuGciSDh8
         SiRw==
X-Received: by 10.112.52.97 with SMTP id s1mr4965761lbo.8.1370798581224; Sun,
 09 Jun 2013 10:23:01 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 10:23:01 -0700 (PDT)
In-Reply-To: <20130609171810.GA10858@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227035>

On Sun, Jun 9, 2013 at 12:18 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wrote:
>> We should free objects before leaving.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> A shortlog-friendlier subject could be: "sequencer: free objects
> before leaving".

I already defended my rationale for this succinct commit message:

http://thread.gmane.org/gmane.comp.version-control.git/225609/focus=3D2=
25610

--=20
=46elipe Contreras
