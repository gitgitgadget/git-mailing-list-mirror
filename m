From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Mon, 18 Apr 2011 16:15:13 +0200
Message-ID: <201104181615.13548.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201104181534.31408.jnareb@gmail.com> <20110418135037.GE3258@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 18 16:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBpEb-0007fM-JK
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 16:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324Ab1DROPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 10:15:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59304 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab1DROPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 10:15:19 -0400
Received: by fxm17 with SMTP id 17so2845469fxm.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=7u2tjESOlgeSEmbGDEvtnCgD0U4OSc7HcIXkJEr96Ts=;
        b=CtZ3gkCBKyeCJVrqm8UCpttUcogyb6lacPJnFJkghd+czwzv0vt7nbhL89769jBVPE
         U1Is4bC5mckgggBojEkn61m36SLr20UrpLUUlmgXuBM8L/X7uGep3b/LrvyLizj1BRsM
         C3rwEc6mVJds6+C79EkzrfMLdB1N6jBxzx2OY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q3w2SiERWqR8KEkRTaRmbysnZTfryjvacRllghSHAwiv6Y0Sh9NaLZzyzbhKvKwoqz
         H4wxE+r7yUFiinFDFeARhLK5cviWRLwVN90Tu9rubB3xkYNHps+ZaxVcH23QoUTwpOhf
         c5/+EkpuhzV9TvrCtQ3l0HUKZFoZuyV5OKEVE=
Received: by 10.223.14.207 with SMTP id h15mr4059453faa.50.1303136117866;
        Mon, 18 Apr 2011 07:15:17 -0700 (PDT)
Received: from [192.168.1.13] (abvc126.neoplus.adsl.tpnet.pl [83.8.200.126])
        by mx.google.com with ESMTPS id c21sm1686020fac.22.2011.04.18.07.15.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Apr 2011 07:15:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110418135037.GE3258@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171746>

On Mon, 18 Apr 2011, Petr Baudis wrote:
> On Mon, Apr 18, 2011 at 03:34:30PM +0200, Jakub Narebski wrote:
> > On Sun, 17 Apr 2011, Petr Baudis wrote:

> > >   Girocco uses MooTools, and I also used it in an old private branch
> > > of gitweb. I have had pretty good experience with it. But since I wasn't
> > > able to find anyone to maintain Girocco's gitweb (or even keep it in
> > > sync with upstream) and the patch flow to core git has dried up, it's
> > > probably not too relevant argument. :-)
> > 
> > Thanks.  The information about MooTools is certain helpful.
> > 
> > Do you remember why did you choose MooTools from other existing JavaScript
> > frameworks, including more popular jQuery?
> 
>   Unfortunately, it was few years back so I don't remember clearly
> anymore - it certainly was not a very educated guess, however, since I'm
> not really a JavaScript hacker. Possibly I just stumbled on a nicer
> guide for MooTools than jQuery at that time. By now, it's quite possible
> that jQuery is a friendlier alternative.

Well, I am also partial to MooTools.  I haven't examined all JavaScript
frameworks, or did examination in much detail, but from jQuery, MooTools
and YUI I think MooTools looks best.  jQuery looks a bit too little,
being mainly about DOM manipulation (though it has lots of plugins), YUI
being a bit too much (gitweb doesn't need and shouldn't need all this);
MooTools look about right (and has More and forge / plugins)... and is
second most popular after jQuery ;-)

But I'm willing to be persuaded.

What gitweb needs currently (meaning existing JavaScrip and patches
in flight):
 * support for old browsers that might not have findElementsByClassName
   of querySelectorAll
 * formatting Date in RFC2822-like format
 * event delegation (live events)
 * support for onprogress for XHR, emulated if necessary
 * attaching / detaching simple floating menu

References:
^^^^^^^^^^^
* http://jqueryvsmootools.com/ (by MooTools developer)
* http://stackoverflow.com/questions/394601/which-javascript-framework-jquery-vs-dojo-vs

-- 
Jakub Narebski
Poland
