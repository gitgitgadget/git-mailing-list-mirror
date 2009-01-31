From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: "git svn fetch" slow
Date: Sat, 31 Jan 2009 18:31:45 +0100
Message-ID: <bd6139dc0901310931l7ff5a3del35d51560fd04b3d5@mail.gmail.com>
References: <200901311414.58205.markus.heidelberg@web.de>
	 <bd6139dc0901310823lcced62frd61445cb80d56fca@mail.gmail.com>
	 <200901311801.56130.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat Jan 31 18:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTJiV-0000wD-5k
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 18:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbZAaRbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 12:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbZAaRbt
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 12:31:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:53932 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbZAaRbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 12:31:49 -0500
Received: by fg-out-1718.google.com with SMTP id 16so259981fgg.17
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 09:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=TC9GOZ30Ml/DB74uytRa2LLbLqHUX7BoZGe5QjAo1CM=;
        b=g6IeNMr5ynCIziVcYH7x2I3VHAg3kRcD8Ov5umcF7mM4LGydzNdqhC/yGUtWSZRyyW
         VJyPoNpLgzwlykFpTGqnLNHUwIjCgYD1JPWeYJsCns3fbgrAUpJuBchjZsC1oQkR7SLI
         NF4El3OzefPhJGDjZs763YVmI7hk2nDX3lhy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=fobLq3zTW/zwcTiUGFmuYKWDKAl9csxvkm/iqmRfe67Rtevra2ynMOV5lRF2NorFl3
         4DJw7I0NR1WRiBjy57wBJZm1hPD7F086LqDtOYKsPnkpVXq6rgc4M1AtxK5QdwiW89bl
         mBB+nAGGZPG3zZe3RnTOyB2FL+8PYRETojx3M=
Received: by 10.86.100.19 with SMTP id x19mr1344294fgb.29.1233423105876; Sat, 
	31 Jan 2009 09:31:45 -0800 (PST)
In-Reply-To: <200901311801.56130.markus.heidelberg@web.de>
X-Google-Sender-Auth: 23a45cf32d45c6f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107933>

On Sat, Jan 31, 2009 at 18:01, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> The following should work around it:

Awesome! I tested it and it does indeed work around the issue for me, thanks!

-- 
Cheers,

Sverre Rabbelier
