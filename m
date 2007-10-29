From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stg branch --create test v2.6.24-rc1 doesn't work
Date: Mon, 29 Oct 2007 17:11:33 +0000
Message-ID: <b0943d9e0710291011p11bd8901udeb758fa653610bc@mail.gmail.com>
References: <cc723f590710260342t5fd0bdc3nc1ea5198cea1a604@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com, "Git Mailing List" <git@vger.kernel.org>
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 18:11:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImY9U-0003BH-Fb
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 18:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbXJ2RLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753866AbXJ2RLf
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 13:11:35 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:6027 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbXJ2RLe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 13:11:34 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1624135rvb
        for <git@vger.kernel.org>; Mon, 29 Oct 2007 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TjvYWMWw9OjhXiA0fiiIlvz83Qyd9WAle8oXALzd/98=;
        b=oYO7Y5MTr56W7PMb7HwIzto84x445Q6d/SdS4jNuEXUbAnxtO6pxPskURQHy8nrsTTAbB4Z/fQPg0+alOVYjiXRxWVIMEiffC9ou6mZwXI8wQM1JNG5CFSMSJ5q2epHSp51ZuG0wO7NVq64ZDlPOPBh9GcR6xA29CU5rqcQrnLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lnNDq+Dnnp+7ydHzUtAxkq+3lZcqRXVUW0PLutEImm3E+Dq0wo36Hl2FcwXcKOkNnlqX1PSlrqrrtcrjG+Nnn/vt0bSNrrtd2nmCs3fzA7jsdiTZYjGKa8LBsph14T8pPeWvb94gE7C5tj4WHhe/k3XtW71NmaYT8hlnDbTB0V8=
Received: by 10.141.20.7 with SMTP id x7mr2868821rvi.1193677893598;
        Mon, 29 Oct 2007 10:11:33 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Mon, 29 Oct 2007 10:11:33 -0700 (PDT)
In-Reply-To: <cc723f590710260342t5fd0bdc3nc1ea5198cea1a604@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62622>

On 26/10/2007, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> $ stg branch --create test v2.6.24-rc1
> Checking for changes in the working directory ... done
> Don't know how to determine parent branch from "v2.6.24-rc1"
> Branch "test" created
> [test@linux-review-ext]$ git log
>
>
> Throws an error/warning in the above command.
>
> Also import then gives
>
> [test@linux-review-ext]$ stg import
> /home/opensource/patches/ext4-patch-queue/ext4_mballoc_freespace_accounting_fix.patch
> Checking for changes in the working directory ... done
> fatal: cebdeed27b068dcc3e7c311d7ec0d9c33b5138c2 is not a valid 'commit' object
> stg import: git-commit-tree failed with code 128

What version of StGIT are you using?

You could try 'stg branch --create test v2.6.24-rc1^{commit} but I
thought latest StGIT adds this by default.

-- 
Catalin
