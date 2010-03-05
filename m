From: Mark Lodato <lodatom@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Thu, 4 Mar 2010 20:30:50 -0500
Message-ID: <ca433831003041730w7ccbc953kad3b600e7b112e0e@mail.gmail.com>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 02:51:23 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnMNr-0003lk-Nb
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 02:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab0CEBbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 20:31:12 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:51820 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab0CEBbM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 20:31:12 -0500
Received: by qw-out-2122.google.com with SMTP id 5so346987qwd.37
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 17:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hBr6sJVbr8kTn+xXb6+obkvGAMUxcl8azd5O8OZsHfw=;
        b=M+wi0wlQWGEjLWoG7tr2XvXhMYHAA1LXwe0pC1Or2EuC/dRpw4+kLCnL0jwN4ijF61
         PhysYfcYtNF0bcDEGFYFq/289g7q1HLri193ewLTUXg9lVIgVp4rKmLo8ebCDj75GqwY
         Ix+G53bd328bNfW1T4LC0QGrc4S4AvO+7wABo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=M6D/X38Z5DInBD/lZJVzlh8PZAn/BGhBdZqr6q4AeUWmDRqlgDXRBxppTLH3Ay22T8
         nuUP2isoqzgScAlzMcssttgNofcgZjasso0IDv/t1CnOzeY56+kggRhpKar6Z3Na0Y/Z
         kIcEYbf0DUVf8xNTNfRdr+ehtcofEyOh3Fp3M=
Received: by 10.224.43.157 with SMTP id w29mr1808606qae.313.1267752670153; 
	Thu, 04 Mar 2010 17:31:10 -0800 (PST)
In-Reply-To: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141550>

On Wed, Mar 3, 2010 at 7:02 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * ml/color-grep (2010-02-26) 3 commits
> =C2=A0- grep: Colorize selected, context, and function lines
> =C2=A0- grep: Colorize filename, line number, and separator
> =C2=A0- Add GIT_COLOR_BOLD_* and GIT_COLOR_BG_*
>
> There was a comment about not special casing filename coloring?

The disagreement is whether --name-only output should be colored or
not.  In the patch, it is not, which I argue makes more sense.  When
--name-only is given, the only thing output is filenames.  Having them
all be the same color adds no information, and I personally find it
annoying to see one big block of the same color. GNU grep does color
the filenames with --name-only.  Michael Witten argues that this makes
the output consistent: whenever it's a filename, it's colored. [1]  He
also thinks that matching GNU grep's behavior is important.  He didn't
convince me and I didn't convince him, so it would be nice to have
more opinions on this.
