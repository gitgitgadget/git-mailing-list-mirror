From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Working with remotes with (too) many branches
Date: Tue, 21 Feb 2012 16:43:03 -0600
Message-ID: <20120221224303.GB31934@burratino>
References: <CAKHWUka763XRWyMz2Xq1qQ2rfKqSYdTX0xtdVFm8zWJ_+6tGqA@mail.gmail.com>
 <7v7gzipkt8.fsf@alter.siamese.dyndns.org>
 <CAKHWUkY_bEtKoPOiWFz6i2bp-tbekapROOaCYR0k5Ymh0HYMdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"martin f. krafft" <madduck@debian.org>
To: Philip =?utf-8?Q?J=C3=A4genstedt?= <philip@foolip.org>
X-From: git-owner@vger.kernel.org Tue Feb 21 23:43:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzyQa-0007N1-JA
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 23:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141Ab2BUWnK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 17:43:10 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48007 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096Ab2BUWnI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 17:43:08 -0500
Received: by iacb35 with SMTP id b35so9487351iac.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 14:43:08 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 10.50.184.168 as permitted sender) client-ip=10.50.184.168;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrnieder@gmail.com designates 10.50.184.168 as permitted sender) smtp.mail=jrnieder@gmail.com; dkim=pass header.i=jrnieder@gmail.com
Received: from mr.google.com ([10.50.184.168])
        by 10.50.184.168 with SMTP id ev8mr22770175igc.29.1329864188363 (num_hops = 1);
        Tue, 21 Feb 2012 14:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mlQ0UVtsxvbS/AfI8ohuz8/3lM0lKU8upGBwFtaIgJk=;
        b=MeFHFbTxBvr5bzZjOGF0ioYej2IOrNVu0s8hi9JuIoYSij5R5QOJy3zmVUNlFQKEYD
         9YZEV7f13Jxp+UQci+2/RKIOMNCCRv9yHGCEvcRb5JJ72WcRQ30w8eDBT6kaN2Xi8/hU
         wNr/nvBPOSHMwca5QyiBaatWV0Re4TDI0Zigg=
Received: by 10.50.184.168 with SMTP id ev8mr18387739igc.29.1329864188323;
        Tue, 21 Feb 2012 14:43:08 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d15sm34362367ibf.7.2012.02.21.14.43.07
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 14:43:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKHWUkY_bEtKoPOiWFz6i2bp-tbekapROOaCYR0k5Ymh0HYMdA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191194>

Hi Philip,

Philip J=C3=A4genstedt wrote:

> It seems to me that if one starts out with all branches and then
> "set-branches main footopic", one really does want all other refs to
> go away on the next fetch.

I would expect set-branches to remove the remote-tracking branches
that are no longer relevant itself, actually.

Martin, does this seem sensible to you?  If so, I'll be happy to look
into it in the next few days (or I'll be even happier someone else
gets to it first).

Hope that helps,
Jonathan
