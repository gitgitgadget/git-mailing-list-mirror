From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Subject: Problem with "From:" line on "git format-patch" generated patches
Date: Tue, 3 Nov 2009 14:30:43 -0200
Message-ID: <b8bf37780911030830l42ea6dc2v3ef66e2a9e1ca281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 17:31:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5MHo-0001R8-S1
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 17:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbZKCQa7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 11:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZKCQa6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 11:30:58 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:53757 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZKCQa6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 11:30:58 -0500
Received: by vws30 with SMTP id 30so1643844vws.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 08:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=/zBNgTKjc7UnFb0BjJ05CcTE45QaDek6hqkCeyQDg7Y=;
        b=g8AMdqibEidLbmjeiIqyhtXBTkyZQ9neRT6uChelh5h6C5HQ94rwsNjp7wBykP903T
         AicM086Fz/2+3kiSdk8WFm4WLJAXRai01V0kwPZkehRWiMPRWkT7XMtTXDzTrN6VvuV5
         QlyMASNte9OJqj1KQZxO7oBikKY+LgmU6XWDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=HiXi/ttnfACUS4WrOnHax/ZZXfIPiSDG0mGtyS1oclDE3BbVwXP8/DWDpVtcZUKTdZ
         F31sLbN8xVMlyMUors4rE6FMeN69SswCoOwGCT1We01tSEh16fCC0aCzJY4wMq2E2Yoz
         91mzEVYDGGipVpkHMWDZkORJq0k3geXnDrAiM=
Received: by 10.220.122.205 with SMTP id m13mr233061vcr.40.1257265863462; Tue, 
	03 Nov 2009 08:31:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131977>

Hi, everybody!

    When I generate patches using "git format-patch" it always makes
my name garbled in the "From:" line
as shown below. I'm using openSUSE 11.2 RC 1 (x86_64) with the
following settings:

        # locale charmap
        UTF-8
        # echo $LANG
        en_US.UTF-8

    I've tried changing my environment to use another encoding like
ISO-8859-1, but it didn't work as well.

    Does someone can explain why does this happens? Any suggestions?

P.s.: the problem never occurs on the commit message (Signed-off-by)


>> >From 584d9bfc7c1d41b76a05655b4562b98fcbef6ee4 Mon Sep 17 00:00:00 2=
001
>> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Goddard=3D20Rosa?=3D <andre.god=
dard@gmail.com>
>> Date: Sun, 1 Nov 2009 14:09:06 -0200
>> Subject: [PATCH v2 7/7] vsprintf: factor out skip_space code in a
>> separate function
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>
> btw., for reviewability's sake, could you please fix your patch
> submission method to not include such garbled headers in the mail bod=
y?
>
> (Also, it would be nice to reply-thread the 7 patches on the 0/7 mail=
,
> as git-send-email does.)


Thank you,
Andr=E9
