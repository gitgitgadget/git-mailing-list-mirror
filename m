From: Elijah Newren <newren@gmail.com>
Subject: Re: specifying one-side of a merge commit?
Date: Thu, 12 Aug 2010 00:01:21 -0600
Message-ID: <AANLkTimT1w6o41Pu6zoLMRpv2PrtpkJ+6qLTQmQvR89d@mail.gmail.com>
References: <AANLkTi=mnO8+XM4Bcjneaq+ngUSFesvZ_TYMRyy=f43a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 08:01:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjQr2-0002H6-UK
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 08:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab0HLGBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 02:01:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55872 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab0HLGBW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 02:01:22 -0400
Received: by bwz3 with SMTP id 3so635458bwz.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sryEVzK+2SRODvCxhx4Ls5+LANkrb+1KC5Nox7s6Zbs=;
        b=dYIRwmlHQVGJkKyn323MdwVTYAQu2gMt9i1YhX/L3RNKh3jsi+S61oAtehrucLUjiG
         gMZ8sYg4gl5wdDWBTWEw9lFjN7npIFNnCmPDxYX659hG1iJHQ+p7DRTsTAkvfFLOwfRO
         QQ0s9eDFmdXQW5Oa+UQbQnTlVdVxR9DQ+BEHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Tu7ATL2LhXJSIjg6tTWP59SwH1/TF9ThiFprjUTF1qbb5ItDta9gEUkmc0YkUcyUoq
         Hdhvtp+5rDghEk+k5dLjgY+BA27EW8GiOpffw6yRIR2bMYaBBYxLZm6QZDCHixx1y9Q2
         ViRNh7ijBOsl2dUrhPwancUFMQ9RSigTx0kVw=
Received: by 10.223.117.20 with SMTP id o20mr21058552faq.55.1281592881600; 
	Wed, 11 Aug 2010 23:01:21 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Wed, 11 Aug 2010 23:01:21 -0700 (PDT)
In-Reply-To: <AANLkTi=mnO8+XM4Bcjneaq+ngUSFesvZ_TYMRyy=f43a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153344>

On Wed, Aug 11, 2010 at 11:11 PM, Tay Ray Chuan <rctay89@gmail.com> wro=
te:
> Hi,
>
> I wonder how do you guys do this?
>
> So far, what I've come up with is this:
>
> =C2=A0$ git rev-list $MERGE ^$MERGE^ | head -2 | tail -1
>
> I'm sure there's a better way.

$MERGE^2

(^1 means first parent of a commit, ^2 means second parent, etc.
Plain '^' as suffix with no numeral implies ^1).
