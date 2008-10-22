From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: how to configure Git to treat certain type of ascii files as binary files
Date: Wed, 22 Oct 2008 15:13:13 -0700
Message-ID: <ee77f5c20810221513td0b9620n4a7692dcc966e962@mail.gmail.com>
References: <65d12cb10810221458j14ef0009u679cdb0f73299d7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Weiwei Shu" <shuww1980@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 00:14:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KslyQ-0004tT-Bt
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 00:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbYJVWNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 18:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbYJVWNQ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 18:13:16 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:18728 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYJVWNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 18:13:15 -0400
Received: by yx-out-2324.google.com with SMTP id 8so7268yxm.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Zm9gjnsDpB+bY7SIFk1m83pNxb8oDLIzvbv7uVbbpyU=;
        b=KOeSChIhHCmB+qj1M7tU9MmP1UG8SlQLmrZL2ZSPR8EQ/t+jTDMUzsLWIS+JsmrL/J
         5qQJhc7UPBbICbA7fjW5UkRFfLrTuL68/jqQ9LufzzVcEPjvequBsQTXPqubNU1aZJMl
         BuzCif0fMa6fiUBriGzZgMSMz9zTdBvoN3y+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=k0Iu89gfPhmpn/SKpy4LHc3deoHtAeSF0CRPU7cC6PtI2PaJGP6D8+//8g5iQQcIeh
         wEoBpQTfjzOXagoNUPATuW5UobqCM0eVxKOYEnBGy4x8Q6fRHO+9uhX4xfxpKtuAiDpt
         3sA6fj8W4IcMUunIVk6ygl2s888nfAbYB6g7Y=
Received: by 10.142.186.15 with SMTP id j15mr4612533wff.44.1224713593124;
        Wed, 22 Oct 2008 15:13:13 -0700 (PDT)
Received: by 10.142.170.14 with HTTP; Wed, 22 Oct 2008 15:13:13 -0700 (PDT)
In-Reply-To: <65d12cb10810221458j14ef0009u679cdb0f73299d7f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98921>

On Wed, Oct 22, 2008 at 2:58 PM, Weiwei Shu <shuww1980@gmail.com> wrote:

> My first post in this mailing list. Could some one direct me to some
> document/manual pages to setup Git to treat ascii files as binary
> files? I'm using Git to do circuit schematics (SPICE files)
> versioning. I will not do any merging or editing stuff with external
> editors. The only way to change it is to use schematic capture GUIs
> (Cadence, ADS, etc). So I'd like to treat them as binary files to
> reduce the possibilities of messing them up.

Git doesn't futz with your file contents unless you explicitly ask it
to, such as the CRLF-munging stuff. By default, all files are
"binary".


Dave.
