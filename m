From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/2] clone --bare: Add ".git" suffix to the directory name to clone into
Date: Fri, 1 Aug 2008 17:34:47 +0200
Message-ID: <36ca99e90808010834q6bb2f0a7i52a7aafb8dbafb70@mail.gmail.com>
References: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
	 <alpine.DEB.1.00.0808011601200.9611@pacific.mpi-cbg.de.mpi-cbg.de>
	 <4893172C.1060203@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marcus Griep" <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 01 17:35:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOwfX-0000Dw-1z
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 17:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbYHAPet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 11:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbYHAPet
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 11:34:49 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:63833 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbYHAPes (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 11:34:48 -0400
Received: by an-out-0708.google.com with SMTP id d40so175031and.103
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=L/y2yeZtigNMWY5ZhGoOCx43cdry0N5P3SkxTCxbxvY=;
        b=b+PtH9TjHVUcSPhyMU9JrpmZTlvCzljqheZVe0jaWIoOsmPPa4hALn5XC5ft4LVBF9
         4cyTUg22Zb/cFKgK0Dpq7dhgfsn1CEIq9eK9UgN3tZ+MAsZNnovrDTgWoFe+v+XSj35Y
         qJ5qnbd26Ruf0+vjPwAHwhdaOy1MhChFpp/PI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tht5XFo7DM20z9EDPQOdITWiWOkasP/PaMm9lp03RN+BXnUxpxqQEgXCDGJ5e+val/
         il4dY6+lky9OD7c9nJtz8oYJO8wMmFS07fhGKCBiV9Fk/79GQzBJQxY33kRYYgJXUuD4
         YKCrJftuZLG9E15/JbrZmc6/GcXu/TTQCTiRI=
Received: by 10.100.216.12 with SMTP id o12mr16729080ang.117.1217604887473;
        Fri, 01 Aug 2008 08:34:47 -0700 (PDT)
Received: by 10.70.116.10 with HTTP; Fri, 1 Aug 2008 08:34:47 -0700 (PDT)
In-Reply-To: <4893172C.1060203@griep.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91073>

On Fri, Aug 1, 2008 at 16:01, Marcus Griep <marcus@griep.us> wrote:
> Does this patch forgo adding a ".git" suffix if one is already present?

No, the purpose of the guess_dir_name() function is exactly to remove
any present ".git", and more.

Bert
>
> Marcus
>
