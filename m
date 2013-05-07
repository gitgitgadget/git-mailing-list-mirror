From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 23:36:59 -0500
Message-ID: <CAMP44s2-UNVMyTgUVMOagegB+_Gr9drXy-5s=3G+nTNKW=ZZ_Q@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
	<87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
	<518789D1.4010905@alum.mit.edu>
	<7v38u0t9va.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HASAuF0ECCvJr66WeqopDzLZQ12pKFsc-j5_VCDrizg@mail.gmail.com>
	<CAMP44s2KHH1n0vHB0Mdv-M2xV97KA9FMc6UrPyYyxD+2jsvfTA@mail.gmail.com>
	<518871A0.8030707@alum.mit.edu>
	<alpine.DEB.1.00.1305062331190.8213@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 07 06:37:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZeO-0002nl-2e
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760119Ab3EGEhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:37:04 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:33047 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760116Ab3EGEhB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:37:01 -0400
Received: by mail-la0-f51.google.com with SMTP id ep20so130866lab.38
        for <git@vger.kernel.org>; Mon, 06 May 2013 21:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qGfXb2dB3+LP8XVmMFMqzW2smElSEarR8b+YeYVORq4=;
        b=XSNjBw6OtXV+qSERNcpOvANpYfr5qlqGvCOhVivUO9ifWntRmidAgl40bUXRhQUz6Y
         666eL93IOb3sGpZnH4xkgkFDchGYXqqTN2vqQAos4f84N7NuzvtOglvB6AxrPLnItoW+
         ya6VdMgo9vWsh15xTL56STDcYtDqEyEoggvHFQMAJkbLk3/3mh+KLTFqV5+k9wGhxBdn
         M49gVfDKDWQwWp5gVL8WAmi0OOiR+epE1ferSHDrVZCEKQ0Z8hJkpI1VfiTa35QsE45X
         oydgAxbkuimuV8oQMEMhPRc1HwPUEepgQ0kpsP0fI5nFeFsaRXpJRdFqsxLYE9Rtj65I
         8dcg==
X-Received: by 10.112.135.70 with SMTP id pq6mr293117lbb.82.1367901419944;
 Mon, 06 May 2013 21:36:59 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 21:36:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1305062331190.8213@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223541>

On Mon, May 6, 2013 at 11:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Michael,
>
> On Tue, 7 May 2013, Michael Haggerty wrote:
>
>> I knew about the "type" command but I was under the impression that it
>> is intended for text files and can corrupt binary files.  Are you sure
>> that using "type" as you suggest is binary-clean?
>
> "type" is not binary-clean. At least on some Windows versions, "type" also
> has a limit on file size.

copy /b file1+file2 destfile

Then.

-- 
Felipe Contreras
