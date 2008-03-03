From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Mon, 3 Mar 2008 15:07:57 +0100
Message-ID: <1b46aba20803030607v726a6ba1y49ca8524e09c6eae@mail.gmail.com>
References: <47C98472.8000002@gmail.com>
	 <7vir05x2di.fsf@gitster.siamese.dyndns.org>
	 <1b46aba20803020437p2a5128a5wfee3e98c32c1a610@mail.gmail.com>
	 <7vbq5xqetq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>,
	"Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 15:08:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWBLL-0006Vi-Az
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 15:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbYCCOH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 09:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbYCCOH7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 09:07:59 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:37507 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbYCCOH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 09:07:58 -0500
Received: by wf-out-1314.google.com with SMTP id 28so48573wff.4
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 06:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hm891fJ+n16wA5hwRddcm2SukyRw5779qgtHnaBxrDE=;
        b=U2c/KPLQtiDlXYzBXAGu8kIn/y7GHBUrsNs0Z/Pp21c6jAv1BMXZ2jwSdBj/75sfnTngzpi/bD0QiC45cG93ZEeQ7REnC6FhZ+H4MoPgLzhp15kiaixJGElgaA3DKeMgqQWQC0/EEORVEulNppTPe43mA1tKxeRCmcViXUNnrb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uto2yvG5nQ5vUBj24GNErO1drGC0c4i+9NFOIrWXvON4s+ckZ/Zg8KQ9vCHGXcJDxWFnFUJBIRhC/We9g2ou9W8XhW6CNb4LBPLj6TY7R+VLrw4gy7P/q7Zyo9axF9tUDbI30B6u36D+9pHe9eqP0zNg3gn57bjMRiOZPAUxloQ=
Received: by 10.142.125.5 with SMTP id x5mr9042581wfc.40.1204553277828;
        Mon, 03 Mar 2008 06:07:57 -0800 (PST)
Received: by 10.142.99.13 with HTTP; Mon, 3 Mar 2008 06:07:57 -0800 (PST)
In-Reply-To: <7vbq5xqetq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75927>

On Sun, Mar 2, 2008 at 5:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  Although "--h" still favors "--hard" over "--help":
>
>         $ ./git-reset --h
>         HEAD is now at c149184...
>

Pierre, is there a way to give preference to --help over --hard
when someone uses --h in command line?
