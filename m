From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git diff with add/modified codes
Date: Fri, 27 Jul 2007 20:17:54 -0400
Message-ID: <9e4733910707271717q5ea33b55r227d8dbb1023de47@mail.gmail.com>
References: <9e4733910707271505x4eac928axe639308afed20cb3@mail.gmail.com>
	 <7vir85whxy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 02:18:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEa0Q-0002Ts-Mi
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 02:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758752AbXG1ASA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 20:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763800AbXG1AR7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 20:17:59 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:58683 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757831AbXG1AR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 20:17:59 -0400
Received: by nz-out-0506.google.com with SMTP id s18so860009nze
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 17:17:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mrnaBAys1JpNy18QL7EBT6MMDBMqqcC5p+/38A/02B4zfzu1VuJR8cSiqIybI1dkpfFJlcFQ7o4IXxfxoQIkzTM6t8GWgCMnz/civjcbmBMBHiSRT7XlhlyrENgLoqtM9fXLsan1y0Nno5CaOEZP2C79RKzX8Jt7C6m3HYvIfTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TQg9nf0H4qe11m9KF2jVQrl74Fv7t+eWK8GKlNpcfDv3zD3Yri+/0A4c4UkAq5i4qDFbHQJl22Om30eCsBcP97N88Bh7S+Ymz6VnJQGKrm6m9qTdjxISVWMEqoGu6UNWWKX85NrFaM6paFztItNAv+Y/aOW4VwSYq3naPYH5UJA=
Received: by 10.114.103.1 with SMTP id a1mr3439351wac.1185581874856;
        Fri, 27 Jul 2007 17:17:54 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Fri, 27 Jul 2007 17:17:54 -0700 (PDT)
In-Reply-To: <7vir85whxy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53976>

On 7/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> Would --stat --summary be satisfactory?

That's not what I want. I'm looking a report that indicates new files
vs modified ones in a single list. These old patches I am working with
often create 100 files and modify another 200.

Adding a code like (Added (A), Copied (C), Deleted (D), Modified (M),
Renamed (R))  to --stat would be perfect.

-- 
Jon Smirl
jonsmirl@gmail.com
