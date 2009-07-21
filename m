From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: how to reorder commits
Date: Tue, 21 Jul 2009 13:23:48 +0530
Message-ID: <f46c52560907210053k53c092c6t3268231ed08153d3@mail.gmail.com>
References: <f46c52560907200807heed4bbfkde15cccd2ae8151d@mail.gmail.com>
	 <adf1fd3d0907200837k63f21504v3d660f9503962fcf@mail.gmail.com>
	 <f46c52560907200901w67edbbdcpe405f28d98953354@mail.gmail.com>
	 <adf1fd3d0907200916x752cba3cw901965788acae0c5@mail.gmail.com>
	 <873a8r132o.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 09:53:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTAAf-0002o0-8e
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 09:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbZGUHxu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2009 03:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbZGUHxt
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 03:53:49 -0400
Received: from mail-px0-f193.google.com ([209.85.216.193]:55380 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbZGUHxs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 03:53:48 -0400
Received: by pxi31 with SMTP id 31so715750pxi.33
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 00:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=kxmr/zr2y0+wJ19H0K7VeH4oUUq4xQKMcHZI4Fly4dU=;
        b=aIL76B+5NlcXALu/8x6vXQDdlaKyCqEU3+HziygexR3tvq6O8vvqM4ZLLB+ko8MIui
         rjVeB202IOKdlK3G/KzGjHGLfDbi2cgKWLisKczOyUIfIChlWpcAPlMKKttFJMDdX1Uo
         uxake6c9oUp7beYSz72C43tlI+t5ts35dbzAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Kr81yi4h7pKjmUyBe/5Pkz2u8HSn5ZR4cFkBFy33vzQibVhEg4G3/2RpziiZgmN6N7
         a1Gunv/bn9AeupCV+si99AeoWwnrOTvv0G1Avq29qY2e0hMoF0iyWeR5GrLlmvP28XNU
         qcsiywUir3qPBsM3cpc+5EE0stp0YkrUwuR9w=
Received: by 10.114.109.5 with SMTP id h5mr8680385wac.69.1248162828378; Tue, 
	21 Jul 2009 00:53:48 -0700 (PDT)
In-Reply-To: <873a8r132o.fsf@krank.kagedal.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123647>

On Tue, Jul 21, 2009 at 2:31 AM, David K=E5gedal<david@kagedal.org> wro=
te:
>
> Latest stgit actually has it. You can push a patch with the --set-tre=
e
> flag. So your sequence of commands would have been (with the latest
> two commits as stg patches called "old" and "older")
>
> $ stg series
=2E.. example snipped ...

Thanks for the info but I gather that stgit does not run on windows?
I need git to run on both on linux and windows.
