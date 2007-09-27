From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 13:38:19 -0700
Message-ID: <94ccbe710709271338u79ba89beh5a637bf84f8edf44@mail.gmail.com>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
	 <20070927185707.GC12427@artemis.corp>
	 <94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
	 <7vhclfubh5.fsf@gitster.siamese.dyndns.org>
	 <94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
	 <7vd4w3ua2j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 22:38:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib07z-0002Pk-1J
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 22:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbXI0UiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 16:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbXI0UiY
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 16:38:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:61008 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbXI0UiX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 16:38:23 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1378532ugc
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=c4rG8WfWhWYjlP7LwK6R4egjFWLYxOiWn9yu/omhBVk=;
        b=cS8a3aTNTqtXcV0EIr06A3jhtbZY7ikFHI6c4ZSPZEGitSuvUhfDb6/eLP2VIU0mnMmCzUv0mPU7AeWOhMf67nqLDwN7bBNs+3165OswfMpRwMBoy82eDsd5H5YISO4DCl0pw4Z+dfoOaTcIPRg9qZ+tIIsax/sQaidW/LsAplQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=o+Bp864zrSfuiPwSyhZzbJdkUqMj8fJmM29xNEgCauax48+W+HeZncY7oaUMOnGuTiM7ZI/nxNygyXl3FEseRjrifpBrWMEm/2+59O0NKUUjWorQqZ6DjJWApwc5BdEbvevf/uIRRfGj1TZ0mJUG9itjobJ7dSC0797RGoig0IE=
Received: by 10.114.210.2 with SMTP id i2mr237241wag.1190925499659;
        Thu, 27 Sep 2007 13:38:19 -0700 (PDT)
Received: by 10.114.144.17 with HTTP; Thu, 27 Sep 2007 13:38:19 -0700 (PDT)
In-Reply-To: <7vd4w3ua2j.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: df1afd9288d98f72
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59330>

Egads, it's alive!

I was in a subdirectory (most of my work is in that one subdirectory
anyways :p), but running it on the top level did indeed work as
expected.

Thanks,
Kelvie

On 9/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Kelvie Wong" <kelvie@ieee.org> writes:
>
> > And then meld starts up, with the original file in the middle, and two
> > blank files on the side, LOCAL and REMOTE respectively.
>
> Wild guess.  Are you running this from a subdirectory?  I have a
> mild suspicion that mergetool is not subdirectory safe.  Can you
> try running it from the toplevel of the work tree?
>
>


-- 
Kelvie
