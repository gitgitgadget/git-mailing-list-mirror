From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Use list form of 'open "-|"' pipeline
Date: Tue, 11 Mar 2008 22:09:03 -0400
Message-ID: <76718490803111909p9684463j355c1f587bf31b13@mail.gmail.com>
References: <20080308165245.15343.62914.stgit@localhost.localdomain>
	 <20080311090100.GN10103@mail-vs.djpig.de>
	 <200803111830.58392.jnareb@gmail.com>
	 <20080311185916.GO10103@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Frank Lichtenheld" <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 03:09:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZGPZ-0000AL-Um
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYCLCJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbYCLCJH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:09:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:13430 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYCLCJG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:09:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3150910wah.23
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 19:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=unWVsaZWtlWnluerRQgPAkdT2WuNqjVlq2+jXYYjwdw=;
        b=lvwzvLunmPTuExnXv8rJm3WcBQqLghbN2xH5A3OCn0qv3PRGJ028ZdJnOnh/xs0OISG6NfbfzW94o7C8VZmSmAOBdlqCjkWCFJNyyOuPM2WyZzFnbqebTshTyvDFRj6flLcYkt+bVZApDnWpj0wJ5dqKTaj/dsdVrAE3XxRinPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rj1Wef80b6IfVXycMA6QHZZ5vIalpPSnFt5JL05FHZFYGyHkERyxRgipZfF79CLstexSmom+WMx2k+AkMEGT6jRgtbe4mIcl2+PPf1tQwTS/hQhIhNSnWAeRhOpoLqpDY2ITHzePnPKN8pOnqu8KLHeph8w4/SsIFYJrLPIGP60=
Received: by 10.114.146.1 with SMTP id t1mr6074931wad.20.1205287743965;
        Tue, 11 Mar 2008 19:09:03 -0700 (PDT)
Received: by 10.114.255.11 with HTTP; Tue, 11 Mar 2008 19:09:03 -0700 (PDT)
In-Reply-To: <20080311185916.GO10103@mail-vs.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76906>

On Tue, Mar 11, 2008 at 2:59 PM, Frank Lichtenheld <frank@lichtenheld.de> wrote:
>  After taking a look at the IPC::Run code myself I'm not really sure it
>  is really "worthwile", as I put it, to try to understand that.
>
>  Creating a less flexible solution that is readable might be better.

"man perlipc" - search for "Safe Pipe Opens".

j.
