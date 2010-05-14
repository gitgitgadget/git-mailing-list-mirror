From: Alex Unleashed <alex@flawedcode.org>
Subject: Re: git-blame.el: what is format-spec?
Date: Fri, 14 May 2010 15:13:35 +0200
Message-ID: <AANLkTikPArJ0s8BTN7QH3CeqU98BGHobKax3IrjMXPrh@mail.gmail.com>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
	 <87ljhi3cao.fsf@osv.gnss.ru> <87fx7q4p6h.fsf@lysator.liu.se>
	 <87einafojx.fsf@osv.gnss.ru> <87d42s3pv2.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sergei Organov <osv@javad.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri May 14 15:13:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCui4-0007Iq-1s
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 15:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440Ab0ENNNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 09:13:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab0ENNNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 09:13:36 -0400
Received: by pvh1 with SMTP id 1so516784pvh.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=eVfAThhbU3/qNksaWqw5FlTNbuNT3oU2KUsXaYV2N/Q=;
        b=OuluYyEBRE3Rn2MrV7svXtkhvuwrhuVf4jprSd44+v9wmhrHCKz7yDvPI7RgR+8+yK
         2W4yHYDgm/SX0e1lI32od8DRd2acs1baK5CKeXwKLNMRlwZBdfpyOimgv7mL4tEWpzQe
         lNfdHsbTqb1YhkuP1dyCQ7cFJLU5/O8l/VXiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=nKQjNGqfSHBusDF7kPS3SUGTdBlWexys/7SBx11oAR67Mxfp9Vge2hbg19dsitvcDC
         XU7Dx870KSIwY+C0zTl/A7aDVu9c/PMXFwusq1FwP9aoePg7pR+ErrvGciAIFZg+rKLY
         LV3kYCJywpUHExzesoP5p+dpuduCQDdEmfQAI=
Received: by 10.140.247.16 with SMTP id u16mr745193rvh.215.1273842815248; Fri, 
	14 May 2010 06:13:35 -0700 (PDT)
Received: by 10.141.29.2 with HTTP; Fri, 14 May 2010 06:13:35 -0700 (PDT)
In-Reply-To: <87d42s3pv2.fsf@lysator.liu.se>
X-Google-Sender-Auth: aq_U73PXs9hXgclEl5n6159jEtY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147088>

On Sun, Dec 6, 2009 at 8:43 PM, David K=E5gedal <davidk@lysator.liu.se>=
 wrote:
> Sergei Organov <osv@javad.com> writes:
>
>> Then there should be (require 'format-spec) in git-blame.el, right? =
Due
>> to:
>
> Of course. I must have missed that since I already had it loaded.

Has this oneliner been submitted for inclusion in git.git yet?
Yesterday I stumbled upon format-spec missing on a fresh install of
Ubuntu 10.04's emacs package.. Just require'ing it fixes the problem.

  Alex
