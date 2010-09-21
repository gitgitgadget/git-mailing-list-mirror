From: Graeme Geldenhuys <graemeg.lists@gmail.com>
Subject: Re: staging specific lines out of a hunk for a commit
Date: Tue, 21 Sep 2010 13:00:39 +0200
Message-ID: <AANLkTinJRT7x-TS0R1C00-djVk3rKOt_Axys+orBhZfx@mail.gmail.com>
References: <AANLkTin4U78N_8LV8fCWuinNH9AFeOsRBjnvHM0qt2ZH@mail.gmail.com>
	<AANLkTim=FQyBHcaHEX92YLgODrvpesuA7e4xwXuWcFg4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 13:00:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy0ac-000131-V6
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 13:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab0IULAl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 07:00:41 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33465 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab0IULAk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 07:00:40 -0400
Received: by qyk33 with SMTP id 33so5310358qyk.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=YIBZ3EP/lozJPfMArRyJdmRXx/w0GPWUGSBqQnQ0orc=;
        b=sPBt8LP4EJv0nLhdxT/Ru1kkYZC6jCFDswRE7HMlZMRBxuCAjqkDcM3uIhTY/9GCan
         ApMvMqDsv1NTECFf4RonLaxZeRAyZve4+8iLAgFrbpsxgtIy80Z/clkSKS9CViSsXQd5
         L4rnFoXCTjMRvuphgAU3YBwR/qUs03scxugrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=QkomCwstieLDVPHoD6l7BtuuOLguCAyD9xMGJg6qiuSMuYinatachJw4EamxKe7ja1
         1uvYI2mJBlBUmp2O7piPROyuPvtUeaS3QsbeXWCt/4OYuPi58TJIri8S2iQHxMn4NfzM
         kbxlmwAMoMSK44FUTfoz+xVgF97bL3vS1jyg4=
Received: by 10.229.2.3 with SMTP id 3mr6824870qch.266.1285066839681; Tue, 21
 Sep 2010 04:00:39 -0700 (PDT)
Received: by 10.229.212.129 with HTTP; Tue, 21 Sep 2010 04:00:39 -0700 (PDT)
In-Reply-To: <AANLkTim=FQyBHcaHEX92YLgODrvpesuA7e4xwXuWcFg4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156710>

On 21 September 2010 12:52, Bert Wesarg wrote:
>
> Just select the lines you would like to add, and than you can stage
> them at once.

I tried that last night on my home laptop and it didn't work. Trying
it now at work, it indeed does work. Clearly my git versions are
different - when I thought they were the same. Thanks for the help.


--=20
Regards,
=C2=A0 - Graeme -


_______________________________________________
fpGUI - a cross-platform Free Pascal GUI toolkit
http://opensoft.homeip.net:8080/fpgui/
