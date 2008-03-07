From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 2/3] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat, 8 Mar 2008 00:50:01 +0800
Message-ID: <46dff0320803070850w290bfbe6hcdf74b20fcd7d8a4@mail.gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
	 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
	 <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
	 <7vabli7vhr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 17:50:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXfmM-0004z2-Rx
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 17:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409AbYCGQuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 11:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757437AbYCGQuE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 11:50:04 -0500
Received: from hs-out-0708.google.com ([64.233.178.251]:50820 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350AbYCGQuC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 11:50:02 -0500
Received: by hs-out-0708.google.com with SMTP id 4so492419hsl.5
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 08:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nnCs3nlwgH6k64QxAgNTciLLNOcamtOjyEMjk2kRaP8=;
        b=etXongJIjwk7iiwZGPNJXsI//6M4vWP3b32Woa+s5v6129rUXaZ9iy+arZfpLf8x8rFUtzvbw6VSZeqELws43jjMl7MECDFs5MRU6VFmYtCrkd86hdZY+0ah+fIXGTaT6zCm8Zl3Pf1om+0gUemXwtyy9s852QqwA3B/hzJydEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aQxS2QQdrgF+VHfwThj4qcmmOfhHZ3Y+Gr9XOm8DInR6Fs0//RkhTrQ7d62PiHnAyGNMHWFlasXiokFgSzH+AsMg3xYRcWmrxBJcl8GMqsB04Ki8c8n3f2WC36x2Uju1RKfQbDLv8mZDVVzx88srUuXwXwH1frgydjXgI2gHLd0=
Received: by 10.100.119.17 with SMTP id r17mr3724854anc.42.1204908601264;
        Fri, 07 Mar 2008 08:50:01 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Fri, 7 Mar 2008 08:50:01 -0800 (PST)
In-Reply-To: <7vabli7vhr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76500>

On Sat, Mar 1, 2008 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > +             test -z "$check_src" ||
>  > +             GIT_DIR="$name/.git" git-rev-parse --verify $sha1_src^0 >/dev/null 2>&1 ||
>  > +             unfound_src=t
>
>  You do not want to do ^0; you will not be bind a non-commit in gitlink
>  entry anyway.
>
Actually, i need ^0. "git-rev-parse --verify sha1" will always succeed
if sha1 is an valid
name with lenght 40 even if the sha1 doesn't belong to the repository.
But what i want
to verify is that the sha1 is not just valid/unique but also belongs
to the submodule
repository.


-- 
Ping Yin
