From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: merging unmanaged working tree
Date: Mon, 15 Mar 2010 15:01:55 -0500
Message-ID: <32541b131003151301i69e5df1doc463406738086a89@mail.gmail.com>
References: <87ljdtkedl.fsf@dasa3.iem.pw.edu.pl> <46a29168.6d880e7c.4b9e296c.483a1@o2.pl> 
	<87d3z5k3yb.fsf@dasa3.iem.pw.edu.pl> <a038bef51003151258q2a4ba7dfwe84b29854c03d7eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-2?Q?=A3ukasz_Stelmach?= <lukasz.stelmach@iem.pw.edu.pl>,
	git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 21:02:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrGUZ-0007Gm-5U
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 21:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936665Ab0COUCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 16:02:17 -0400
Received: from mail-yw0-f189.google.com ([209.85.211.189]:35559 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936641Ab0COUCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 16:02:16 -0400
Received: by ywh27 with SMTP id 27so1738194ywh.22
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Kp8y4XqYwy3ASiQ7xQomFcNoxD0teXF+fUZEXVYxz04=;
        b=QukqPYD8SZXn2/nHrHGNPg6AlUbZ22FE7KdsYyjNOLy88kVD7YboHpwi5TF1vrNrEZ
         +lLER6Gkld613YtcRe2jxSBNQSiCRtY0PfASTfFN54WmmK5GfSr1X40/UqJEtJrhb5Zr
         SpEFQSgP8i5JxlQA2iguuskypSaC9BvZC48dM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FVHIHGAOh9LFyOCOw+uFFrqt7QzdnOEsUBUt3wvbHZTa72+nS12BTk0UFaOQ70BL7O
         nDeCK4s72XhqrC4a/NVQrZWKcAHkJq+Wt2cOoRsNeAqzsTxRTz/eITn+1sqNtseKJ64p
         08k9AZuf4jhGtzDQbYHxTl5r3guXYfnKysJTI=
Received: by 10.150.172.13 with SMTP id u13mr3535339ybe.224.1268683335098; 
	Mon, 15 Mar 2010 13:02:15 -0700 (PDT)
In-Reply-To: <a038bef51003151258q2a4ba7dfwe84b29854c03d7eb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142248>

2010/3/15 Chris Packham <judge.packham@gmail.com>:
> The downside with this is that it is very likely that your files will
> pick up an executable bit from the file system on your pen drive which
> will need to be fixed up before you commit them.

If you have this problem, you might want to look at the core.fileMode
option.  (See 'man git-config').

Have fun,

Avery
