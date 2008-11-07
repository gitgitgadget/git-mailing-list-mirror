From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH (GITK) v3 6/6] gitk: Explicitly position popup windows.
Date: Fri, 7 Nov 2008 15:39:12 +0100
Message-ID: <81b0412b0811070639q47244bc4t10791781fb0ec43b@mail.gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-2-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-3-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-4-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-5-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-6-git-send-email-angavrilov@gmail.com>
	 <1225652389-22082-7-git-send-email-angavrilov@gmail.com>
	 <18708.11537.229423.296701@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Alexander Gavrilov" <angavrilov@gmail.com>, git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 15:40:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KySVh-0001nd-AD
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 15:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbYKGOjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 09:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbYKGOjO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 09:39:14 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:32065 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYKGOjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 09:39:13 -0500
Received: by wa-out-1112.google.com with SMTP id v27so621255wah.21
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 06:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eTcRVRrFtCxm97QfvrSKAcEpYOX/YWXzUYjUiLnawjk=;
        b=ZGbMuKVBTKFITLlhtXj00NQcTzn3etmeipcvtBn2KNDfcDHXcTxrnFu+jM03Xrgc4Y
         0Cb3FTu0C2suzm7Wbekmd3/HT8u8qMbc/XcoxVua98k6A7Z+frEt/6t84X7ItKPswd0x
         QhuAJH3f3yhu6H1HzazqxydFvzFN4HjjSKAaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EzaC0ItvqPnPjZ9u3vgbiXyHFBcSiP9sTWfNZAzuFtBuU/Iw9KhZu3GIMoUeXS0eO4
         NV4Tk9ROFK6mkzaCstrigSozGYdxP+w81sHRiubKFsKmys7LIX4n4T31ZUHs/vlNLbBn
         HhLawRKkk1rOkjBOO2+EDCeNzlfDlGSB7QF+s=
Received: by 10.114.193.15 with SMTP id q15mr1403273waf.199.1226068752415;
        Fri, 07 Nov 2008 06:39:12 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Fri, 7 Nov 2008 06:39:12 -0800 (PST)
In-Reply-To: <18708.11537.229423.296701@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100316>

2008/11/7 Paul Mackerras <paulus@samba.org>:
> Alexander Gavrilov writes:
>
>> For some reason, on Windows all transient windows are placed
>> in the upper left corner of the screen. Thus, it is necessary
>> to explicitly position the windows relative to their parent.
>> For simplicity this patch uses the function that is used
>> internally by Tk dialogs.
>
> Is there any reason to call tk::PlaceWindow under Linux or MacOS?
> If not I'd rather add an if statement so we only call it on Windows.
>

Yes, please. I rather like the smart placement in compiz.
