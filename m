From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Fwd: [PATCH 0/6] rebase: command "ref" and options --rewrite-{refs,heads,tags}
Date: Wed, 3 Aug 2011 15:32:41 +0200
Message-ID: <CAGdFq_jLv810a1H=+M14hEho9B_BS4OhdVUz1S-jjMBi6PP28g@mail.gmail.com>
References: <cover.1309133817.git.greg@quora.com> <BANLkTinDFYsw7-N=_Ex8i42So_0LzVAWvA@mail.gmail.com>
 <7vhb7bxgt9.fsf@alter.siamese.dyndns.org> <20110628104758.GS5771@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg Price <price@mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 03 15:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QobZh-0006OY-8q
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab1HCNd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 09:33:26 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55219 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab1HCNdV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 09:33:21 -0400
Received: by pzk37 with SMTP id 37so78612pzk.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KKAmRYbObJHB7bvGL6llTwiIEMS2M1Malsnf875xQQA=;
        b=VKe3PnFmsdUkQZCjJaac3q0WqjfD7SjF6q4XJpgLr4kzyXHJd2tKOQ4i4ZeKpkyz0+
         ba3aj8RzEsTd3RaMECr3x9cpAbpk+79fhtdmKP5D2jUoOXqbBI0efnxC8Of2U+tIk7fa
         JQQe8jbpkyuctOvb0wJtudYXhDIQspfwshNJM=
Received: by 10.142.121.35 with SMTP id t35mr5015097wfc.7.1312378401161; Wed,
 03 Aug 2011 06:33:21 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Wed, 3 Aug 2011 06:32:41 -0700 (PDT)
In-Reply-To: <20110628104758.GS5771@dr-wily.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178571>

Heya,

On Tue, Jun 28, 2011 at 12:47, Greg Price <price@mit.edu> wrote:
> I would also like to support that use case. =C2=A0In my personal
> experience, the case where the part$N are ancestors of the topic has
> actually been the more common case; typically it's that part1 is some
> topic, and then part2 is a further topic that depends on the changes
> in part1, so naturally it goes directly on top of it. =C2=A0So I'd be
> pleased to get the functionality of the present series in, even befor=
e
> supporting the more general case.

=46WIW, I'm having the exact same need while working on the remote-hg
series (which depends on my remote-helper follow-up series, which
depends on fast-export-fixes, which depends on my original
remote-helper series, which depends on peffs initial patches; luckily
the latter two have been merged to next :P). I'd really like having
this available, especially the rebase -i support.

--=20
Cheers,

Sverre Rabbelier
