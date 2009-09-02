From: Giulio Eulisse <Giulio.Eulisse@cern.ch>
Subject: Re: [PATCH] git-submodule and --upload-pack
Date: Wed, 2 Sep 2009 14:41:33 +0200
Message-ID: <C58D88DD-1AB7-4727-ABDA-9AC0DEA53A3D@cern.ch>
References: <9D7140EC-EAFD-4408-93E3-0E756BA363DA@cern.ch> <7vk50jtud8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 14:41:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mip9y-00084p-2d
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 14:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbZIBMkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 08:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbZIBMkX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 08:40:23 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:37409 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbZIBMkX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 08:40:23 -0400
Received: by ewy2 with SMTP id 2so760794ewy.17
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=X7FbHrt0aiOCJfVxrPxoUaLixfa1B+h+Fg74emMFDwU=;
        b=c14PE1k+u+vLeuMaQ8dIotHUEkGMgRNAqUgASShC/rEcpwuNHsrPUIrpqlZMfjt5Jw
         jYgG+JlVeGXYcqLvmY1pel5XDjj7VRMW5rBl92StFI9e9nq6BH3CPY2VnSsKJGL4dOKH
         fX8AQMwRclSHzB6WyJW314BPySqdB2XbB8eRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=mcJJGsPDrLZlR/t4cu97XKzLwO57q4mHONmpk97j3M/mRAIwXOeW6B+V4dEgi8bVcq
         JayHnufpOXmSSK7zDYbz5i3k7zbrCDdfg62f8vkOdnGOqtuWcM6D3MOp7ZaX4d4gR/dw
         pSd42cQrZPPQ0cD8TRdVh0ffNkXEaqoIqsq0g=
Received: by 10.210.131.5 with SMTP id e5mr7836012ebd.45.1251895223044;
        Wed, 02 Sep 2009 05:40:23 -0700 (PDT)
Received: from iguana3.cern.ch (iguana3.cern.ch [137.138.52.211])
        by mx.google.com with ESMTPS id 10sm2163eyd.36.2009.09.02.05.40.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 05:40:22 -0700 (PDT)
In-Reply-To: <7vk50jtud8.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127605>

>> There was a thread a while ago aboyt having --upload-pack support for
>> git-submodule.
>>
>> Given that there was no followup (as far as I can tell) and I needed
>> pretty much
>> the same functionality I ported Jason's patch to work on top of  
>> 1.6.4.2.
>
> Thanks.
>
> Can you point at the original patch with a usable commit log  
> message, in
> the gmane archive (i.e. http://thread.gmane.org/...) if possible?  I
> do not think we have that patch queued anywhere even in 'pu'.

Ciao,
sorry for the mangled patch... Looks like Mail.app did something  
weird...

http://article.gmane.org/gmane.comp.version-control.git/104188/match=git+submodule+upload+pack


> Given that it looks like a new feature, I do not think it would be
> appropriate for any of the future 1.6.4.X series, but if it is  
> useful we
> may want to have it in the upcoming 1.6.5 release.
[...]

Ok. I will try to follow your suggestion and post an updated patch.

Ciao,
Giulio
