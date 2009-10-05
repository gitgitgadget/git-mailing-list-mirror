From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Mon, 5 Oct 2009 08:08:49 +0200
Message-ID: <6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com>
References: <4AC8F22F.5070101@gmail.com>
	 <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 08:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuguE-0008F8-GU
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 08:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbZJEGJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 02:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbZJEGJ3
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 02:09:29 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:54704 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbZJEGJ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 02:09:29 -0400
Received: by bwz6 with SMTP id 6so2238395bwz.37
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 23:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BAei1hLPlfSKeLw0L8RDuepv2E/F3tRl+TmDYF14jAY=;
        b=a7nh5zPtJl8FuGWdVjq2vzee72l0bGxqZ8tZ+d9FsyPpRJVXuFlzFiTJIuLJwqZQSj
         Q1z3rADrBlSA1vnDZwLE36X67Hq1NTc7ILKKbZzCHvPs0/c8rvbZBK0ovBpPY4abS0+v
         Nb+tRA2hNOt/bwvZxo5f7rxy6bA1thuagT4GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CU0pbAwHlu93d/cEdg0Uo0lP983MIbIo6A0aRDutFfYml2k+/oahjuKlntuqqnkDE/
         XifnfqkC2AelW3pSVgB2+z4syS1YdT/wwCT62WcR4I8gT3VKlLlPEe9JbpeSHxFR4ak8
         6zd4JGoGZA2zWU3U2vkahv5I17d8kO6MQgQqs=
Received: by 10.204.34.75 with SMTP id k11mr3687276bkd.105.1254722930893; Sun, 
	04 Oct 2009 23:08:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129530>

2009/10/4 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> I thought that we had a discussion about this and that the consensus =
was
> that "amend" would be misleading. =C2=A0Maybe you can find that threa=
d in
> GMane?

I found this thread from January 2009:

http://thread.gmane.org/gmane.comp.version-control.git/105738

Having read the thread, I agree that "amend" would be misleading.

There were several suggestions for alternate command names
in that thread, for example:

"msg", "msgedit", "message", "reword", "rephrase"

It think that "msgedit" was suggested by several people. ("editmsg"
was also suggested, but it is not possible as the abbreviation "e" woul=
d
become ambiguous.)

Would the patch have a chance to be accepted if I renamed
the new command to "msgedit"?

/Bj=C3=B6rn

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
