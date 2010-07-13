From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [BUG] 'diff A...B' fails with multiple merge bases
Date: Mon, 12 Jul 2010 19:49:46 -0500
Message-ID: <AANLkTilnl5sw4M5p8AdO_Z73zBWzlwcZ8hIcdGDXf6de@mail.gmail.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com> 
	<7vaapw8ehn.fsf@alter.siamese.dyndns.org> <7vocec6xlt.fsf@alter.siamese.dyndns.org> 
	<7viq4k6xea.fsf@alter.siamese.dyndns.org> <AANLkTinfo1QDguIbNgOt9w9V9xuJbhrCmusfe9g8fosm@mail.gmail.com> 
	<7vy6dg5hwl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pickens, James E" <james.e.pickens@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 02:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYThO-0004BT-Ng
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 02:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab0GMAuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 20:50:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48404 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab0GMAuH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 20:50:07 -0400
Received: by gwj18 with SMTP id 18so2457550gwj.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 17:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7PGGFDCPexCfQcQvVF8DApd5FuYvwqhzkCI2DWhQPko=;
        b=q1rk541b7HMZBoQxbQaSmTv4rxiUtarJHH9+mflWkLzOFfLi8Ht6x2xhEgrWwoZSIG
         c/+NtlUucdHC9eT8fVoDfuhSGG3zZ/gxBIqqd2hajLY7iI36IpHJa67e4faqAbEh28ha
         hJ/kbykwjnhvLrSgLJIMpL2FRfkEFF+68s1c0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LrTe9b36WGABgDmQbsTwGjVDfX/8ZOnJv4rLgLjizNBuz9h0AP4kaiYdrcosZ2M87K
         3q3+hZ57GtWIOfuYyzxf8ND7i9A0XzkSQA7G6Niusnqq5gYNQeXgHqGyBmsbGJS6s46u
         PiyBJ93Ijurm3j/kPhmr67cfTC1Zq0XsdPN2Q=
Received: by 10.150.218.18 with SMTP id q18mr6518998ybg.22.1278982206206; Mon, 
	12 Jul 2010 17:50:06 -0700 (PDT)
Received: by 10.150.93.19 with HTTP; Mon, 12 Jul 2010 17:49:46 -0700 (PDT)
In-Reply-To: <7vy6dg5hwl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150862>

Heya,

On Mon, Jul 12, 2010 at 19:45, Junio C Hamano <gitster@pobox.com> wrote=
:
> This will trigger only when you did something random like this.
>
> =C2=A0 =C2=A0$ git diff ^maint master ^next ^pu sr/frotz..
>
> What else would you say against such an input?

Something like "too many arguments, please specify at most two commits
to diff against"?

--=20
Cheers,

Sverre Rabbelier
