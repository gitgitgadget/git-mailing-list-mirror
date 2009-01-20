From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: gitk doesn't work w/o sudo.
Date: Tue, 20 Jan 2009 23:05:44 +0530
Message-ID: <c94f8e120901200935t75dba11fw3ce14b4ba965c878@mail.gmail.com>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
	 <3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com>
	 <c94f8e120901190637i294d379dke3a07a90da5076f8@mail.gmail.com>
	 <200901200912.14432.brian.foster@innova-card.com>
	 <c94f8e120901200851n21c6d67r3c43e3efd435e3db@mail.gmail.com>
	 <vpq4oztgaz8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Brian Foster" <brian.foster@innova-card.com>,
	"Reece Dunn" <msclrhd@googlemail.com>,
	"git list" <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jan 20 18:37:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPKXm-0004FW-GA
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 18:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762312AbZATRfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 12:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758918AbZATRft
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 12:35:49 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:59852 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762289AbZATRfq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 12:35:46 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1546417ywe.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WZoClDkhdw3R1TqkYPoFmMNIjTrPif6xH6MhHCVIdMA=;
        b=NGQsPd37xnbzx9pB2u9Pn7RZ2S14DPjvjXeQRoRspIFK+cIY1TgW4WCdOrgxjU8oMc
         jwZsngKw1AWqk0i4e8FecWB17JSv4YoiqdKIO4pZz/TZhLL/2aZ9lrcXtezgNKac/IJy
         d6D15A79fRpMppTwJeER5RtDxoiROz1DCDbm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=E+sm7OZX8hBp5f+JOhiWPp3GKurQ2aXLO8+BOgZE42wVr+lycqRiPVw9+tej5MQqFB
         fUI+THw2BkHj4ZMLqYvMhyIBCtZwhwdU1nMj0FhRHxqq9jUA6a/WKiRPuntDkMvCvCz5
         A3swd7ikfm4AWFJ45w2gDjSL/jwm3+v7xz4vQ=
Received: by 10.101.70.14 with SMTP id x14mr1405424ank.153.1232472945007;
        Tue, 20 Jan 2009 09:35:45 -0800 (PST)
Received: by 10.100.128.10 with HTTP; Tue, 20 Jan 2009 09:35:44 -0800 (PST)
In-Reply-To: <vpq4oztgaz8.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106501>

On Tue, Jan 20, 2009 at 10:40 PM, Matthieu Moy <Matthieu.Moy@imag.fr> w=
rote:
> "Dilip M" <dilipm79@gmail.com> writes:
>
>>>  repeating Reece's question, what is the permissions/owner
>>>  _of_the_directory_which_contains_ the '.git/' directory?
>>>  I can reproduce this behaviour (git 1.6.0.4) simply by
>>>  denying myself search (n=E9e execute) permission on that
>>>  directory, for entirely obvious reasons.
>>
>> It's the same issue....
>
> You didn't answer the question.

Sorry..I read it for .git directory...

=2Egit's parent directory is owned by user who us issuing gitk command
and permisssion bit of 755 is set.

dm-laptop:~/repos/atria> ls -ld .
drwxr-xr-x 6 dm dm 4096 2009-01-18 23:28 .

dm-laptop:~/repos/atria> ls -ld .git/
drwxr-xr-x 8 dm dm 4096 2009-01-20 22:22 .git/

>> Any ENV variable I can set to debug this...?
>
> GIT_TRACE can help.

I tried with that but it didn't help for gitk. But sure, it helps with
git command(s).

-- DM
