From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Fri, 10 Jun 2011 19:38:52 +0700
Message-ID: <BANLkTimtBrvOFT41mZz_g8QgcBC=2KvNtQ@mail.gmail.com>
References: <20110607200659.GA6177@sigill.intra.peff.net> <7vvcwh4ako.fsf@alter.siamese.dyndns.org>
 <20110607214532.GB7663@sigill.intra.peff.net> <m3hb80dynr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 14:39:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV0zp-0006iB-5S
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 14:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649Ab1FJMjY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2011 08:39:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46090 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011Ab1FJMjX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2011 08:39:23 -0400
Received: by bwz15 with SMTP id 15so2143913bwz.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=foOTmxbQ8j+8obx/BoPCsCjn11fBhVRCpa1Zp83sHYU=;
        b=VwUv0Zi8jofy8Vf37c09qeV/BmjMZLzwreLCxOLx6oUl/zgikk0FRrxURKqt/ZK+BG
         55QM5EMYgrC7VM7lxuHdZTsFHQxT86vk9PXojYCzQMqB3FO1hJIzc2X7zDYsEowsZxnb
         JUry5zEl4CyMRey0T208KtsT0kyYE88JMOaFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GDOwQbNz3kwg/7fXerNQSSSPDzWhwCfsp+9lAO5bPXl3faMkwiiW3P4TtkiuCdzAoG
         K0jRd+lfQsbXt0Lm+bCqK2ILTfOm/+By6KSLYp39yJ7YrLrJS1G60tEpe6D3n37eSW5Z
         Qibp3cvSI990FPrmeSBLdAGwnVSAKUCTGiedA=
Received: by 10.204.75.85 with SMTP id x21mr148959bkj.170.1307709562147; Fri,
 10 Jun 2011 05:39:22 -0700 (PDT)
Received: by 10.204.50.150 with HTTP; Fri, 10 Jun 2011 05:38:52 -0700 (PDT)
In-Reply-To: <m3hb80dynr.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175606>

On Thu, Jun 9, 2011 at 12:25 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Perhaps we can use some character that is forbidden in ref names,
> doesn't make trouble when doing allowed operations on said refs, won'=
t
> confuse user, and is not trouble with shell... ehhh...
>
> * :tree: =C2=A0 might be mistaken for 'tree:' in index

Also may clash (or make it more ambiguous) with pathspec magic. Another=
 option

* +tree
--=20
Duy
