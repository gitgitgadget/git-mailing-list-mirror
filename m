From: dhruva <dhruvakm@gmail.com>
Subject: Re: timestamps not git-cloned
Date: Fri, 28 Nov 2008 08:38:06 +0530
Message-ID: <e3f230850811271908g1be6b3f9t3e678081088de06b@mail.gmail.com>
References: <87ej0wwptn.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Nov 28 04:10:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5tk0-0003mZ-4x
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 04:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbYK1DIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 22:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbYK1DII
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 22:08:08 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:25363 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbYK1DIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 22:08:07 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1258239wfd.4
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 19:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=z1h3k5C2qey1rF3zfUGxqjdF33KvtPChOhjMrxNA080=;
        b=A1gb+Ugarz9MGSRHgRRXLaq17Nqsk3d/0jAgtNlB/WXVeQgR5qivUH5YrSdUvGlYd3
         2Ltoku9tcc4gXsIwr/p5KIlWa644iO94qnFlQIf3KPMiE88kXy44UuEB+mpW4gF1tVmX
         GGNi4LZB3l53yOOS0xEL04/OV9D5b9LkeHIco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dXQsSp13pyhBexjJTlP6xAm+O5KbcqPL/LnKHVnOSZoKYw4ZZ6kVCuUR1OsQr1YzdX
         ImIswi27/xl3K295wLftEMez8816NS83OifIW2zDwSci7d4gj5lYJsGPYk59nywm2ZGq
         PtbM9UDbohbDZ3PdT28jaEEk2XYFEtQkGos1g=
Received: by 10.143.41.5 with SMTP id t5mr3181681wfj.134.1227841686396;
        Thu, 27 Nov 2008 19:08:06 -0800 (PST)
Received: by 10.142.110.21 with HTTP; Thu, 27 Nov 2008 19:08:06 -0800 (PST)
In-Reply-To: <87ej0wwptn.fsf@jidanni.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101860>

Hi,

On Fri, Nov 28, 2008 at 7:54 AM,  <jidanni@jidanni.org> wrote:
> Gentlemen, it's my first git-clone,
> $ git-clone git://git.debian.org/git/pkg-fso/files.git
> and I'm disappointed to find the timestamps of the files created are
> all now and not the date of last edit. At least mention something
> about this on the git-clone man page.

I do not think there is an VCS that records timestamps. Only file
contents are tracked. Also, if you clone from systems across time
zones, what time do you expect to set on the files. IMO, it is not
practical to track timestamps.
 Are you concerned of 'make' doing a complete build when you switch
branches? I guess it makes sense only in that scenario. I wish 'make'
had some feature to track changes instead of timestamps alone...

-dhruva

-- 
Contents reflect my personal views only!
