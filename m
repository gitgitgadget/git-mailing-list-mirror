From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make verify-tag a builtin.
Date: Tue, 24 Jul 2007 00:31:31 +0200
Message-ID: <1b46aba20707231531i4e05858foef3ee81479e559de@mail.gmail.com>
References: <46A3F43C.3030101@gmail.com>
	 <Pine.LNX.4.64.0707230141080.14781@racer.site>
	 <1b46aba20707231421k54ad2796i5c2f21cf11b4bea5@mail.gmail.com>
	 <Pine.LNX.4.64.0707232242430.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:31:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID6RI-0006yZ-Fj
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 00:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbXGWWbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 18:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbXGWWbg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 18:31:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:63899 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbXGWWbg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 18:31:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2183437wah
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 15:31:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YfcIhSqRoItjgOsyh6epwKaBHcaKESSBa+RWljkcwXW7uJpTXBeQLQd44m97M+SJW988zfRxj+BleNCR0jSKytmdNmrDhdMnTk+PwkfpSGTPXsLYOq995ZUb/doqCSqpjydJdPAlxdNFrsAxYqiX76fwHRy0Q5RTMRYKhARn8nU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FiPF9sl5Tj9RdEqJxPO5Dl8iUzG1fbmPvZJg2RbBV717zu9obzMyyjKp+4hwcrxgd//co0fmn1R7SShqUqV3Fbrw5c54+5t4UxnJdt9ZZQ49mEfeI5bYWthNJbDW4WVyXM1uGVIplvPMD+UWs0w36Y3yY8Redq2uTtmTKy79ztY=
Received: by 10.114.166.1 with SMTP id o1mr3428419wae.1185229891492;
        Mon, 23 Jul 2007 15:31:31 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Mon, 23 Jul 2007 15:31:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707232242430.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53493>

2007/7/23, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Just one request: please use lock_file, to prevent multiple instances from
> getting confused...  Even if that cannot be 100% secure: if you write to
> the file, and only then start gpg, there is still the odd chance for an
> attacker.  Even if you created the file with 0600 (very wise, BTW).

Why not using also a random name for the temporary file?
Something like "VTAG_TMP30946".
