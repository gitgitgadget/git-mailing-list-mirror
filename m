From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: [msysGit] Re: Weird filename encoding issue
Date: Sun, 19 Oct 2008 18:11:20 +0400
Message-ID: <c6c947f60810190711je910155y31652395228fd163@mail.gmail.com>
References: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com>
	 <48F852FC.2070506@viscovery.net>
	 <c6c947f60810172322o12beeb80xfd39b551b0db7c99@mail.gmail.com>
	 <200810181951.53962.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: johannes.sixt@telecom.at
X-From: git-owner@vger.kernel.org Mon Oct 20 06:27:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrZ1K-0005a5-53
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 16:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbYJSOLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 10:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYJSOLW
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 10:11:22 -0400
Received: from rv-out-0708.google.com ([209.85.198.246]:57538 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYJSOLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 10:11:21 -0400
Received: by rv-out-0708.google.com with SMTP id k29so2404701rvb.2
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=a0yPTpfPiIXZLbeq3vPuA3OZ+RfuXNAukYR6TgSIQlU=;
        b=ROtF1Ui9pnVL048OdksZzawFWdo77me56pC2TFH/kC/Sd7WtuTcqjHwbJBDvft4qUw
         GrKBkh8FCVS63spWDxx34Dkjg3t+0946javmGAkTx38VZ7pWomy0tpsbdyNbefLhkiX1
         QgHdef6ggFedzgSEEyyl6lfwabe+2D0+su2tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ug9UoAcE5zfuUO2TyFnzOHC0R4EP9x8eeZpS11cH0WIfQB4MPD9nwoUs5jHXLuOG2p
         YtoGDX7X3ujOdFD+ti2JCSNWaa2MGj80Xclc2rEKjjzuY4yfsQAg50J1pXBIDtQew+e6
         hQXKpXaZkbFgrGn+vbTTmVsKegBVu+VDYt1Fc=
Received: by 10.141.152.9 with SMTP id e9mr3118452rvo.76.1224425480438;
        Sun, 19 Oct 2008 07:11:20 -0700 (PDT)
Received: by 10.140.188.5 with HTTP; Sun, 19 Oct 2008 07:11:20 -0700 (PDT)
In-Reply-To: <200810181951.53962.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98609>

On Sat, Oct 18, 2008 at 9:51 PM, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> On Samstag, 18. Oktober 2008, Alexander Gladysh wrote:
>> 1. Git hooks do not work under msysgit.
>
> This is new to me. Why are you saying that? (IOW, please be more precise with
> your description. We can't help you if all you tell us is "Does not work" .)

Err. Sorry. I thought it is a known issue:

http://groups.google.com/group/msysgit/browse_thread/thread/956e555b8d515c66

I've got an impression that msysgit 1.5.6.1.1071.g76fb we use does not
contain this fix.

Of course, I may apply it by hand on each user's machine... Still have
to do it though.

Alexander.
