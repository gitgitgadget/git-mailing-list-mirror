From: Sebastian Setzer <sebastianspublicaddress@googlemail.com>
Subject: Re: How do you best store structured data in git repositories?
Date: Mon, 07 Dec 2009 22:20:21 +0100
Organization: privat
Message-ID: <1260220821.3545.12.camel@nord26-amd64>
References: <1259788097.3590.29.camel@nord26-amd64>
	 <32541b130912021317y705d1d4cj28e230a3e727df2e@mail.gmail.com>
	 <20091204001359.GA6709@gmail.com>
Reply-To: sebastianspublicaddress@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 22:15:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHkvH-0007c0-2j
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 22:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbZLGVO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 16:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbZLGVO5
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 16:14:57 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44960 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965023AbZLGVO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 16:14:57 -0500
Received: by bwz27 with SMTP id 27so3917270bwz.21
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 13:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=pXgYJQMKze51llOsAt+HlAvaP5SD54rEEmjsrd8Pbfs=;
        b=u4zM2dYm2AKWDpx3RgXi5sEKaFv4JsxzGzvs1o4cmFRIRNJQ+LO7MkOfg2sCaq/Eaa
         fASZpWTurzZyPj4s45OLIxj5tF25wYCqXSSwgq5sVuXrfUkACGwYTdEY8BIGeTD2ICxy
         h6dGusLN4UzTRs7GULFToB5WpNmVLd3IN+F4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=subject:from:reply-to:to:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=iWMkClzd5GA/1DXHWMzYac3pqzzt+0WI9vc8atEiu0RXhBIQyUR4MxxwlTSl2YdgUY
         Y+2AJga/TuZx2Vp2wDcTxyiFK4tEH6LLnAtXWs2fVLAlxyhZeH4UhMwj+3yjtaYuLQhi
         oFDuAUBStPbfCLsqQhFxqVutFfa0WvPiokp7g=
Received: by 10.204.155.82 with SMTP id r18mr7660522bkw.180.1260220502669;
        Mon, 07 Dec 2009 13:15:02 -0800 (PST)
Received: from ?78.51.150.181? (f051150181.adsl.alicedsl.de [78.51.150.181])
        by mx.google.com with ESMTPS id 28sm7399699fkx.58.2009.12.07.13.15.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 13:15:01 -0800 (PST)
In-Reply-To: <20091204001359.GA6709@gmail.com>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134786>

On Thursday, Dec 03 2009 at 16:14 -0800, David Aguilar wrote:
> On Wed, Dec 02, 2009 at 04:17:10PM -0500, Avery Pennarun wrote:
> > On Wed, Dec 2, 2009 at 4:08 PM, Sebastian Setzer
> > <sebastianspublicaddress@googlemail.com> wrote:
> > > Do you use XML for this purpose?
> > 
> > XML is terrible for most data storage purposes.
> 
> I agree 100%.
> 
> JSON's not too bad for data structures and is known to
> be friendly to XML expats.
> 
Sorry, I didn't want to start a flamewar against XML. I'm no big friend
of XML myself, but I don't know of an (open source) diff-/merge tool for
any general purpose file format other than XML or plain text.
When you mention other formats, I'd be interested in
  - why this format is good for storage in git
  - if there are merge tools available which ensure that, after a merge,
the structure (and maybe additional contraints) is still valid.

Thanks for your comments,
Sebastian
