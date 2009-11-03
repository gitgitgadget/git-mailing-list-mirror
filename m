From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Tue, 3 Nov 2009 14:05:12 -0800
Message-ID: <d411cc4a0911031405x60ea2396o35eea78a0b07fda9@mail.gmail.com>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
	 <7vzl74trmc.fsf@alter.siamese.dyndns.org>
	 <20091102235707.GV10505@spearce.org>
	 <7vtyxctpf8.fsf@alter.siamese.dyndns.org>
	 <20091103005815.GW10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 23:05:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5RVB-0001hY-QT
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 23:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbZKCWFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 17:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbZKCWFI
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 17:05:08 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:48137 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbZKCWFH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 17:05:07 -0500
Received: by mail-pz0-f188.google.com with SMTP id 26so4250926pzk.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 14:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bD8iLem3iarlraqLWGVNjtLjcEICcHhN+Gb0+13ehO0=;
        b=ZEsFDIHEwaAUg/EYt7WBPRbnFJqG8XNPXFG1Y6o7+lbQwhEbx0bdd+nLj2pd4dAMNR
         AYNCV+rnJ4tHJ6bDzjCxCsR3Ifjkhtj+DnqSbDu/cbGypLrQegLDhnLwLLbX9ZuIutb4
         YxzxTaYUOJ9kOFRfMa0aklTHX+jyOnj3CqzJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IyQ4Y9chBrKMk4hH0YXrBQbjRScWYaEfHxD+An1k8UqYxN0bul/MQm/rpZrf6J7HMU
         PxRg+DZglXytl1paoFcZMCu42trluF7mV0PdF6z3M1IkRf0vjPcGscQeEty52kB0f2rY
         pd5iJAMR1JbVSf/RS8SDXixwGLEX2e8ederA4=
Received: by 10.114.18.23 with SMTP id 23mr649053war.171.1257285912942; Tue, 
	03 Nov 2009 14:05:12 -0800 (PST)
In-Reply-To: <20091103005815.GW10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132002>

Junio,

On Mon, Nov 2, 2009 at 4:58 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> > Junio C Hamano <gitster@pobox.com> wrote:
>> > ...
>> >> Shouldn't we say "the client MUST NOT make reference update reque=
st if
>> >> everything is up to date" which would imply that in practice ther=
e is no
>> >> reason to send an empty pack data?
>
> Creating new branch quirk aside, I do agree with this. =C2=A0Clients
> shouldn't send no-op updates if it knows in advance the update is
> a no-op.
>
> --
> Shawn.
>

Would you prefer that I try to incorporate all these comments and
submit another patch, or are you going to modify it in-tree?

Thanks,
Scott
