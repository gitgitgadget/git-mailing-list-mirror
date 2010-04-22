From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 16:57:56 -0500
Message-ID: <x2rb4087cc51004221457v1460ffctf29bc0fd90d75aee@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain> 
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home> <87sk6n4426.fsf@frosties.localdomain> 
	<7vsk6n2n48.fsf@alter.siamese.dyndns.org> <vpq7hnzcgjq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 22 23:58:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O54Pk-0001Di-6w
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 23:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab0DVV6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 17:58:20 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:41866 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab0DVV6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 17:58:19 -0400
Received: by bwz25 with SMTP id 25so10247655bwz.28
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qY2cFNggVpYeQ/n8JQ7m2s9lshv0exSiBt3tSJcehXA=;
        b=sA2SlbhrKQ1X8qL8ivxefDeckrAppRhbrI6fi6bBTZMak9CgfWvYf/RPrVYazOg6s+
         6XCJ7vOYpPYeBSkhF9A4vkD/MTPJpuKS9x/tnfzFVoLSkGlKLvec4dNhGxZyeuV9MSLp
         bwe3m6ae//rfMVpMKJ01KsXSUyF5NbCeldnzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bBsioApIOA6GCRO5TSrUnGNMxJBylJByEOEHQ39xW8I/pxUv/R2FJogL5+Z4qjIclz
         Hfg5XDc6fLqVyGh9T5WR6GualZxWMybNygIzC447X1EmViuWc07a490gvsPOuuaUYdKY
         5C6dBeh6oOoXmCaPdsyGaqTakPZePYVW/9spg=
Received: by 10.239.189.143 with HTTP; Thu, 22 Apr 2010 14:57:56 -0700 (PDT)
In-Reply-To: <vpq7hnzcgjq.fsf@bauges.imag.fr>
Received: by 10.239.189.83 with SMTP id s19mr928892hbh.185.1271973496170; Thu, 
	22 Apr 2010 14:58:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145570>

On Thu, Apr 22, 2010 at 16:40, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> There's another case where it would be hard to decide what's "The
> Right Thing":
>
> vi existing-file.c # do some changes
> vi new-file.c =C2=A0 =C2=A0 =C2=A0# create the file
> git add new-file.c
> git commit
>
> If you take the SVN semantics

The original feature request is pretty specific and still backwards
compatible with this case; indeed, the feature request is almost
99.9999% backwards compatible from what I've skimmed.
