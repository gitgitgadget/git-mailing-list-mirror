From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug: file named - on git commit
Date: Mon, 28 Jan 2013 12:41:40 -0800
Message-ID: <20130128204140.GA7759@google.com>
References: <51065540.1090007@renemoser.net>
 <87txq11sbk.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Moser <mail@renemoser.net>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:42:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzvX1-00055U-GA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab3A1Ulv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 15:41:51 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:46244 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab3A1Ulu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 15:41:50 -0500
Received: by mail-pb0-f45.google.com with SMTP id rq13so1695603pbb.32
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 12:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gnPHNDaYdq1tQP/JzEfjsAaPjrIlR9WziSrCNMSw3NQ=;
        b=htG5VShoFn+Wal3f8aPuYuBvG3seH2L/jQm9sJzB3g1rJk5KCiZZzhH8NP37u+1Hqk
         bUHJ1W2qLt66Dw+0PebC2rDcvDRYv2ebXCExOsw1Xax42ygZzpqvOMHRlmC2oVPQjdBy
         Y5N+Wly9Iskm7qdc8M+4ubE14XvUYTnwsAUGaOXsyeBC1CLRWd5PcCqWn9Etk3vG3qp1
         Wn1VT1RQp5mzv2i38sZFMq2YhrjulmXYJ0qWl696B8cdvJBwQx4WvLC8EGHyAJYajQ0t
         O5nciY4eQL7TKHzWdicauVP5KJSpP8TvxOWmWsTCIe44yy9AcFUamiOCRJGisNZLQk+s
         kbdw==
X-Received: by 10.66.80.202 with SMTP id t10mr38734078pax.81.1359405710008;
        Mon, 28 Jan 2013 12:41:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id bi8sm7372672pab.15.2013.01.28.12.41.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 12:41:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87txq11sbk.fsf@pctrast.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214868>

Hi,

Thomas Rast wrote:
> Rene Moser <mail@renemoser.net> writes:

>> Found a little issue in git version 1.7.9.5 if a file named "-", causing
>> "git commit" to read from stdin.
>>
>> (So you must hit ctrl-d or ctrl-c to finish the commit.)
[...]
> This was fixed by Junio around 4682d85 (diff-index.c: "git diff" has no
> need to read blob from the standard input, 2012-06-27), which is
> included starting with v1.7.12 and the v1.7.11.3 maint release.  Please
> upgrade.

Should upgrade-averse folks stuck on 1.7.10.y (like Debian 7.0, which
is currently in the release candidate stage) take this fix?  Do you
happen to know of any other fixes such people would want?

Thanks,
Jonathan
