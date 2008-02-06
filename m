From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 3/4 v2] Add tests for .git file
Date: Wed, 6 Feb 2008 11:35:25 +0100
Message-ID: <8c5c35580802060235n52019c16j4404c06d53b47100@mail.gmail.com>
References: <7vfxw66a0s.fsf@gitster.siamese.dyndns.org>
	 <1202284583-24478-1-git-send-email-hjemli@gmail.com>
	 <7v7ihi32bv.fsf@gitster.siamese.dyndns.org>
	 <8c5c35580802060130i12fc261aqbe9c136f26218188@mail.gmail.com>
	 <7vr6fqz939.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:36:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMhdQ-00076Y-Hu
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761007AbYBFKf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 05:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760827AbYBFKf2
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:35:28 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:50530 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759966AbYBFKf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 05:35:26 -0500
Received: by wa-out-1112.google.com with SMTP id v27so388382wah.23
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 02:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zuokPTReIlqacIUJA7po51p+G/n5hUVec6Lf6bb+Sh0=;
        b=qb6TD/nel6d43d6RlS3zlJX5a0jkZOnkgpgHUuCtp9V2jOEww3+xO7ZjvMsnjZNIaUWx3uV0RmjZootQaoCSQVtFawbar09Yjou4hwWX7MdQ0PDHbYwqAG95U+v/YoEH8IsP7J0LnsypiCSBYutpo+8MMKwtkivduBlqNYecQN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M/etRDjmqnr5vIqVnQsAEdH/Qm1syj1ytTOKHwka+UA8D1mEwjE4cRG8/Tpj2dcsBAGKl6Zp6oSHVTx2Srp9hr62kjM9hNp69yzF0yhtjXMbtFW+Hl4ASfOSPFWSInVXJy7N770F2vZKrUM+TEsZRYmeKCb3O+/jVWtZhrQKfeg=
Received: by 10.115.47.1 with SMTP id z1mr4069011waj.117.1202294125114;
        Wed, 06 Feb 2008 02:35:25 -0800 (PST)
Received: by 10.115.73.7 with HTTP; Wed, 6 Feb 2008 02:35:25 -0800 (PST)
In-Reply-To: <7vr6fqz939.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72795>

On Feb 6, 2008 11:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > On Feb 6, 2008 9:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Lars Hjemli <hjemli@gmail.com> writes:
> >> > +objpath() {
> >> > +    echo $1 | sed -re 's|(..)(.+)|\1/\2|'
> >> > +}
> >>
> >> "sed -r"???  Please limit ourselves to the basics.
> >
> > Sorry, I didn't realize 'sed -r' wasn't kosher. Should I resend or is
> > this something you'd --amend?
>
> If we live in POSIX only world it is fine, but I try to be
> conservative when I am able.

Ok, good to know that my lack of experience doesn't pollute the codebase ;-)

> No need to resend; I've done something like this (there are
> other minor amends).
>...
>     +objpath() {
>     +    echo "$1" | sed -e 's|\(..\)|\1/|'
>     +}

Thanks.
--
larsh
