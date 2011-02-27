From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Sun, 27 Feb 2011 00:26:27 -0800
Message-ID: <7vvd056fyk.fsf@alter.siamese.dyndns.org>
References: <4D0ED5EC.9020402@burntmail.com> <4D119015.6020207@burntmail.com>
 <4D2AB63D.7040803@burntmail.com>
 <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
 <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino>
 <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com>
 <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>
 <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com>
 <7voc69p4xu.fsf@alter.siamese.dyndns.org> <4D5F6E97.4000402@burntmail.com>
 <7vy65bkw72.fsf@alter.siamese.dyndns.org> <4D61EA4B.3020708@burntmail.com>
 <7vtyfxgdz2.fsf@alter.siamese.dyndns.org>
 <7vipwbbrcc.fsf@alter.siamese.dyndns.org>
 <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC -32@mail.gmail.com>
 <4D644FEE.5030004@burntmail.com> <7vaahnbmu2.fsf@alter.siamese.dyndns.org>
 <4D69DF29.8030701@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 09:27:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptby2-0000s2-51
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 09:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713Ab1B0I0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 03:26:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab1B0I0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 03:26:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7041623BB;
	Sun, 27 Feb 2011 03:28:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VM+8AZtm7G+bifAlx/VSww6BlUY=; b=p+jot9
	8HXxDwbah/BrR6pRVDVEH+5LczdRWqFLQ2c4HnwmBxgq5ZZ0TrNUkDlOWsNvOgVE
	iRsI5VuwL3BruP/qWA0lyfZySgMmJ8XerOe0BfSPwMWiAbVb0F1FMTvvSfc3b59x
	XXzxUpx8s8fD2MXk3L8AfvjzE7DClfYbzSXYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xu3IFojzITlGVVALvQAEOUwoEnBsVYTz
	Z7Jf89gHfTfAImK0fzKjRsRZBj02ascS+EBnAsOLroqnRvPhIuGyGe/KyhQ76q/A
	CPnTpETRXd5P/w3ZkjxPdGXHeLW2GwIwQM4rm1gq/5/I99LUuOoSUM+9JOYbKYN+
	/yNJnUHPMGU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EBCC923BA;
	Sun, 27 Feb 2011 03:27:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E472723B7; Sun, 27 Feb 2011
 03:27:44 -0500 (EST)
In-Reply-To: <4D69DF29.8030701@burntmail.com> (Guy Rouillier's message of
 "Sun\, 27 Feb 2011 00\:20\:41 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 78E3697A-424B-11E0-A222-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168011>

Guy Rouillier <guyr@burntmail.com> writes:

> As I suspected after reading how the cvspass file is read and written,
> CVSNT doesn't work with repositories with an equal sign in the
> repository name.  You can init it fine, and you can set up a password
> for it.  But if you try to login things go very wrong:
> ...
> Since CVSNT can't handle a repository with an equal sign in its name,
> I say we don't worry about this.  I say the same about the original
> CVS with a repository name with embedded spaces.  We certainly don't
> want to try to solve problems the original product doesn't solve.

Thanks; your observation matches my earlier suspicion.  So in short:

 - CVSNT does not work with repository path with an '=' in it, but does work
   with ones with a SP in it; and

 - CVS has trouble with repository path with a SP in it, but works with
   ones with an '=' in it just fine.

Have I summarized it correctly?

So I agree that cvsimport should not worry about supporting repository
path with an '=' in it, but we do need to make sure we work with one with
a SP in it, when we are reading from cvspass file for CVSNT.

Similarly when we are reading from cvspass file for CVS, we should make
sure we don't break with repository path with an '=' in it.

Do we already have such a solution in the thread?  Can somebody conclude
the discussion with a final, tested and applyable patch, please?
