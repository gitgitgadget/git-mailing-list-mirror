From: Aghiles <aghilesk@gmail.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Sun, 11 Apr 2010 16:31:51 -0400
Message-ID: <k2r3abd05a91004111331ld522220ehfffeb65c45040a94@mail.gmail.com>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com> 
	<i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com> 
	<n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com> 
	<alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 22:32:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O13pN-0002tO-Jw
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 22:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab0DKUcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 16:32:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58501 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab0DKUcQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 16:32:16 -0400
Received: by wyb39 with SMTP id 39so1052293wyb.19
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 13:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6DPilqWXCNeNr4iAcVx5YiEHhnnntS3HYD7diCE80TU=;
        b=lQmwO+0H9/Nbg6m1FG6ab71F5RKoUFi/c2km+quFO73HZaJtZtzyOlIuiHCO1+oqH5
         aRLR+IanQC8tfEU5BLxrm3bI1VfLIGCrF3wrZIpRS/2B20Fk3unOiNKkkyfdNd82LCTd
         OvNqzfM5CtjlfordEsVxlvvVcQ54oAUDlssqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Tt/whFyAxDGNbXk8Mpg6fwFIZ9ac8WFKHYgnxIJA1kusIueeyyZ5PC0k6yQhj1603O
         QLb16x3oGCBPECinYMORNLCdbFDQ7A7ljT8atu3VRgSd/Df/PFJQ2dvBiXRn9aKWPpV4
         uXKRVure8kUeuYZJTb1/V0HYDr2qcwj6lb+WU=
Received: by 10.216.157.212 with HTTP; Sun, 11 Apr 2010 13:31:51 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
Received: by 10.216.165.5 with SMTP id d5mr1674667wel.143.1271017931122; Sun, 
	11 Apr 2010 13:32:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144680>

On Fri, Apr 9, 2010, Linus Torvalds wrote:
> Well, technically ".." means two different things
>
> =A0- for "set operations" (ie "git log" and friends) it's the "relati=
ve
> =A0 complement" of two sets (or "'reachable from A' \ 'reachable from=
 B'").
>
> =A0- for "edge operations" (ie "git diff" and friends) it's just two
> =A0 end-points (aka "range"). A diff doesn't work on sets, it only wo=
rks on
> =A0 the two endpoints.

OK.

> Most SCM's really talk about "ranges". Once you think in those terms,
> complex history doesn't work. Git very fundamentally is much about se=
t
> theory, and "ranges" is a bad word to use.

I see how ranges are not powerful enough for complex history. It is jus=
t
that for me (and maybe for some others), the ".." sign has a strong
association with "range".

Thank you very much for the explanation,

  -- aghiles
