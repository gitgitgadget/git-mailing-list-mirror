From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Tue, 13 May 2008 00:31:57 +0800
Message-ID: <46dff0320805120931u7609a5a2x5433d78e35a62c48@mail.gmail.com>
References: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
	 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
	 <alpine.DEB.1.00.0805060954470.30431@racer>
	 <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
	 <alpine.DEB.1.00.0805071223450.30431@racer>
	 <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
	 <20080508103436.GB3300@mithlond.arda.local>
	 <46dff0320805100202j54b0922cy50a2c93c4eff1757@mail.gmail.com>
	 <46dff0320805110616s6df19657r1e4c80634267fd81@mail.gmail.com>
	 <7vod7c6c24.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 18:33:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvaxx-0008P9-S5
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 18:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbYELQcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 12:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbYELQcU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 12:32:20 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:49274 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875AbYELQb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 12:31:59 -0400
Received: by an-out-0708.google.com with SMTP id d40so485026and.103
        for <git@vger.kernel.org>; Mon, 12 May 2008 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lMkswMKscjYGgbiGZTknzAJoJpMTVS8rSmNsn4sqhoE=;
        b=CG6/Tk9byKs8ua/Uy9DgvPV8JnA3X9UotUVJtqGaS71aTTtKxrdCZhqcqhYqhqEU4AKPEMRMxEtRjHq0ZhufIhF1xxfDTilVycAdywhIlWRmSwijx421fsvfAGVGVR6Lm0myT+CgW3gK95kzut7irhQxvMMFy0v5sTYziy0N32c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=avQiv5gPaq+I7CCsxekfiaDlIwUSdUjpna8wvR3mR/NGgUtaY3Q4o9i/gwEYXcqbVBd/Ls9KgR8KkuvJY9uS03ji+nLA2vVfHS0FOnT4kdLy+HvZiMr4r0S1y81qSvTsmo3l18eNxPBknnd9gKNwnMqcWtaGZupgFRK9vL4W+TI=
Received: by 10.100.41.15 with SMTP id o15mr8457047ano.48.1210609918044;
        Mon, 12 May 2008 09:31:58 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Mon, 12 May 2008 09:31:57 -0700 (PDT)
In-Reply-To: <7vod7c6c24.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81879>

On Mon, May 12, 2008 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>  > With following patch, the diff output becomes (i don't know which one is better)
>  >
>  > OpenOffice.org has {+a }user setting for defining the minimum length for
>  > words to be hyphenated. By default the word length is counted from the
>  > whole word - even for compound words. For example the {compound +}word
>  > 'elokuvalippu' is {+considered }12 characters long. The word will be hyphenated like
>  >  'elo-ku-va-lip-pu' in all cases when the minimum word length is set to
>  >  12 or less. If the minimum length is set to 13 or more the word is not
>  >  hyphenated at all.
>
>  Yeah, after playing with it a bit, I realize that my original stated goal
>  of not playing games with "newline suppression" goes very against what
>  color-words, which is a word oriented diff, tries to achieve.  It appears
>  that it is necessary to reintroduce suppressed_newline.
>

No matter how well we play with suppressed_newline, we still can't
achieve the best result by doing word diff between multiple minus
lines and multiple plus lines.

 ( i think the result of vimdiff can be considered as the best).

To achieve the best, we have to find the pairs of lines (one minus and
one plus for each pair) which most match each other, and then do the
word diff for each pair.


-- 
Ping Yin
