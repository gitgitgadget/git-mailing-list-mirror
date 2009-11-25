From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-subtree: directory mismatch
Date: Wed, 25 Nov 2009 14:48:13 -0500
Message-ID: <32541b130911251148v70a5dc77k9936881d0b382ec2@mail.gmail.com>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com> 
	<32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com> 
	<20091125080812.6117@nanako3.lavabit.com> <32541b130911251028h6db240d5yd171fa4941ef14ba@mail.gmail.com> 
	<7v7htexuxc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Marc Fournier <marc.fournier@camptocamp.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:48:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDNqy-00027K-Gb
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 20:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759560AbZKYTs2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 14:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759493AbZKYTs1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 14:48:27 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:38897 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759427AbZKYTs1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 14:48:27 -0500
Received: by yxe26 with SMTP id 26so55276yxe.4
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 11:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=g03E+DWbVL/DnySdjuFlSTGgUuelt/D2bRNJBKCbbaA=;
        b=kn0es1rdxNJKFs9q4n9DN87M32E956qUiPTQjeJrgl+Fq8wzwU3DgKPAAnvQw3J2Ca
         zhdyR2Hm0NYMc17FLVAH/yFaDyVSmLwyQIVLywvdPiT0nRaYczbzCGXYYNUoBdvqrVOp
         +aCoBxi7oiTTXFUWUWFWCjGH7bo3RDq3fhbQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mJ41DR9qpMXUcA2jdY8VuNf2K83IAbVwdy7TYoPRDs2Wz53CgSusXc16p43MoaYuwj
         /h1lXOXb6xVp5oDQGGUpFfww9lrpPB5326Z0sVAc1cI1/SqZsIh51EiFD7ePwghziVp2
         oauV+G86tegL5kWhE5H/ulx7w8h4y3BzEcb48=
Received: by 10.151.16.24 with SMTP id t24mr14332528ybi.151.1259178513214; 
	Wed, 25 Nov 2009 11:48:33 -0800 (PST)
In-Reply-To: <7v7htexuxc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133664>

On Wed, Nov 25, 2009 at 2:31 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> I've read through the thread (I do remember skimming it awhile ago)
>> but can't find patches for the syntax actually under discussion.
>
> I very much prefer gmane threading when following discussion over all=
 the
> other mail archives, but this shows one thing I really dislike about =
it.
[...]
> Look at http://github.com/gitster/git/commits/jc/merge-theirs/

I also tried simply searching for things like 'git "-xsubtree"' in
google, with no luck.  But thanks for the link.

> and found this series in there. =A0It applies to v1.6.0-rc0~245 (no, =
I won't
> be rebasing this myself---I don't have time for that while preparing =
for
> the pre-release feature freeze).

I did a test merge and it looks like a ton of conflicts, but they seem
to be pretty understandable ones, at least.  I don't mind doing the
rebase and resubmitting the patches, since it's sure less work than
figuring out how to do it from scratch myself.  Some questions though:

- What was the reason this never got merged?  What changes are needed
to rectify that?

- Considering the earlier discussion, do we want to leave out the
actual -Xtheirs feature and just have -Xours and -Xsubtree?

- If I rebase them and the changes turn out to be minimal, do they
still need a signed-off-by Junio?  (He obviously owns part of the
copyright and has previously signed off, but he also won't have signed
off the rebased patches verbatim, so I'm confused.)

Thanks,

Avery
