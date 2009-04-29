From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: "git config --edit" outside a Git repository
Date: Thu, 30 Apr 2009 01:24:08 +0300
Message-ID: <94a0d4530904291524n473e790ct22494132cf844299@mail.gmail.com>
References: <7v1vrptpn3.fsf@gitster.siamese.dyndns.org> <87fxg3ffv5.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Apr 30 00:25:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzIDl-0002wZ-Pq
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 00:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761524AbZD2WYM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761384AbZD2WYL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 18:24:11 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38146 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbZD2WYK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 18:24:10 -0400
Received: by fxm2 with SMTP id 2so1478488fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fegdVtwghW/MlcSAceQBKS43eMP1HEcc8xOvQmu+s/k=;
        b=OqxKVffpNAd4mfLtI5eRKwPDuF6VniiX9jjT81hptSOP6mevAuYhiIgpmTmdEPCZLK
         Urbwaw1KgMiVLNKehk3yAJcjZIrJIv/IegF6ylow7JQqQxFpkpIYR9BjvaO3Q1EX/YPq
         ULrWWK0vN+H5PuwXRCdsJ9GmT+WY4jqGdRC2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OVLZWXizmClbrsqVCZZfWA7ChHKx4CsMNcWWDlICXbGL0K9g7UFw7ZCqF8gYeMonYH
         bIDbtR+mJI8Yexsoj9KWFXf2LqpSC98ERnuJKStfv2mKyB/8sOTOinDZtu7EnLcF4jUQ
         nMezE5aaJRKX2SIGI0rz5kESUNMABDjT5HCzg=
Received: by 10.86.51.2 with SMTP id y2mr1194937fgy.3.1241043848772; Wed, 29 
	Apr 2009 15:24:08 -0700 (PDT)
In-Reply-To: <87fxg3ffv5.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117966>

On Mon, Apr 20, 2009 at 7:29 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
> On 2009-04-18 18:10 (-0700), Junio C Hamano wrote:
>
>> * git-config learned -e option to open an editor to edit the config
>> =C2=A0 file directly.
>
> There's a small flaw in this feature when "git config --edit" is run
> outside a Git repository. It launches $EDITOR but complains on saving
> that the file does not exist (tried with emacsclient and vim). I thin=
k
> it should check before if there's a repository around. "git config
> --global --edit" works.

Thanks, I just sent a patch that fixes that.

--=20
=46elipe Contreras
