From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 11:56:24 +1300
Message-ID: <46a038f90801211456h4b16ff2cl4378df88023bbc34@mail.gmail.com>
References: <478E1FED.5010801@web.de>
	 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	 <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
	 <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
	 <373E260A-6786-4932-956A-68706AA7C469@sb.org>
	 <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
	 <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org>
	 <alpine.LFD.1.00.0801211407130.2957@woody.linux-foundation.org>
	 <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5ZY-0007tk-37
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 23:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbYAUW40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 17:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597AbYAUW40
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 17:56:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:12442 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056AbYAUW4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 17:56:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so972576ugc.16
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 14:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GNDBpovnFXZF0EdEl5CnR8sLeSmCNgK5nea0UnK01eU=;
        b=Wkevtjdo3LV6y0HzI5m4QORNGFFS8kfBIPzBPJ4Q1ox1MdW4P1kY7nQUy6tUMbNssnBZyAEawusoTlxGT4FEdtS/k56wvOtfYxrPX5mZSf/uUX+kN+hPu7jm4vzyWrwJ3rTMEpufW02O0NRlj4pHOdPj5BCupwO/MJxcHHCjBWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MnvpXVBrRmwhrXKBDNNn8PsC/P96prD28NE2cgv66rVS8X9cXG3RADib1plsFCC79inPZ/gX9zOL+D+PHluZm0E54X28DbvXl0HbWDjuAe9rUN1YJsxIBVTtgaSsthk+AlS0J+T5N/Upupv+gfMVt0uMTE3EQuJyy354JfW/auE=
Received: by 10.66.225.9 with SMTP id x9mr5269261ugg.47.1200956184425;
        Mon, 21 Jan 2008 14:56:24 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 21 Jan 2008 14:56:24 -0800 (PST)
In-Reply-To: <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71366>

On Jan 22, 2008 11:46 AM, Kevin Ballard <kevin@sb.org> wrote:
> Again, I was talking about a system that used unicode top-to-bottom.
> On HFS+ you have to use UTF-8 for your filename or it simply won't work.

Hmmm. I m pretty sure HFS+ has a lot of problems if you run OSX as an
NFS server with clients in different encodings. It would never work in
real life. The "envelope" OSs have to work in is hugely varied -- much
more so than any other apps. You should try writing one someday ;-)

> other words, I was trying to illustrate that HFS+ isn't wrong, it's
> just different, and the difference is causing the problem.

Did you spot the rather nasty issues that Ted mentioned earlier in the
thread? I would say HFS+ is a bit "special" rather than "different".

cheers,



m
