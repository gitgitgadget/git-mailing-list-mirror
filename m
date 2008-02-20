From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 15:22:08 -0500
Message-ID: <76718490802201222y5bbe09d5j541690669a96672f@mail.gmail.com>
References: <alpine.LNX.1.00.0802201337060.19024@iabervon.org>
	 <7vzltv4ey8.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0802201418590.19024@iabervon.org>
	 <76718490802201149w5a7c0b88udef968f4083190ea@mail.gmail.com>
	 <7vfxvn4cyh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 21:23:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRvTG-00073i-DU
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 21:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933399AbYBTUWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933359AbYBTUWM
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 15:22:12 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:60808 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933328AbYBTUWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 15:22:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4161869wah.23
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 12:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=w6+ominMVXVGnCIZOCTvoe6oGlP0dos/GuzSYdny9tQ=;
        b=ayP5pv1O8OuMa+JSoIf7zWVWFy7iL+rCn5wnU5B+zN4ppLzxjz9Ee3oE/F38+3xvcbuD+hfJWzMbaVRD7MpEiX6kUXKlM6EfFdm+fKnkd1DvXhtjeIyzF/pU1rN+aRZFItcUrjMP/9MqGidxCMGe1uBDIHNOi53jAjRfUC15X+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BO+uU7rfMSvBx69JQfJrhuJIHgRRXS1wM7ajA6ROZ2kSw/oWFEXHuKvw1FYGM4hTjMPLduI+tCWplUchHm4jHBT4LPAGABKARsFmlSmbMX7rGC/zy3yeRUGZ71AKfl97rsQTf4e3jgBsc71GF1yJNHXAXH9pveBS5YwRYKMYE5k=
Received: by 10.114.53.1 with SMTP id b1mr5797188waa.134.1203538928852;
        Wed, 20 Feb 2008 12:22:08 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Wed, 20 Feb 2008 12:22:08 -0800 (PST)
In-Reply-To: <7vfxvn4cyh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74545>

On Feb 20, 2008 2:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Jay Soffian" <jaysoffian@gmail.com> writes:
>
> > On Feb 20, 2008 2:24 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >> This order of values is definitely the right thing, for the mapping
> >> reasons you saw. And I think "aka" is generally used to indicate
> >> additional non-canonical names for something with an official name (see,
> >> for example, IMDB's usage). I haven't been able to come up with anything
> >> better to indicate "this is a name that I will recognize but not use
> >> myself".
> >
> > I think the word you want is "alias", isn't it? I've never really seen
> > aka used in a technical sense, whereas alias is used quite often (URL
> > aliases, DNS aliases, etc). So:
> >
> > url.$canonical_name.alias = $local_name.
>
> Read the first line you quoted, and think again.

Well I'm just not seeing it, but you could you do it just like the
[alias] section?

git config url.local canonical

[url]
  local = canonical

git config would have to be extended to deal with a URL on the LHS.


?
