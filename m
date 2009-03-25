From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: reverting initial commit
Date: Wed, 25 Mar 2009 11:33:34 -0700
Message-ID: <8c9a060903251133x33749041oc2a5152097da0ae8@mail.gmail.com>
References: <49CA7428.70400@obry.net> <7v1vsl4fxo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pascal@obry.net, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:35:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXwl-0007tr-LP
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbZCYSdz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 14:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbZCYSdy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:33:54 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:53884 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZCYSdx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 14:33:53 -0400
Received: by qyk16 with SMTP id 16so355042qyk.33
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ip+4m/f6xFTU2gtCCp+WJ5byUANuMWxstQH+8NldCGA=;
        b=CkQU/Kh8M+skYT2uyzb5GM7qx9Js4LCXUBsQTvrgFXe+/Y35/+n4SeHXWvxPnqLrwT
         1N3tZx33Vbj9cxwy+OB2+PuHb+TXs1pp0+96is8XhjvH7NKvEF5D6qJ9SKYb8ufz9pJ1
         F1ucejhNLagmmpmXMht7Yq/oB3KZjhfR2ziUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PQ5rz0QGvCGIj6vaUNgvkv3RJ2UfsTT6DcdpDBNIOwjXuG+6qCAJliiinNU98Yioqs
         p8AAEzOtt+AtikLdxpSXE9AzGc4wzK2wcCklP3b60LXjO3Cg59n67dU2UxdrLbOFAN7u
         zXOm7/C6qPArQ8ybGgsg8O/QNMzjB4UxSiNLw=
In-Reply-To: <7v1vsl4fxo.fsf@gitster.siamese.dyndns.org>
Received: by 10.142.180.20 with SMTP id c20mr3782430wff.174.1238006031120; 
	Wed, 25 Mar 2009 11:33:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114640>

On Wed, Mar 25, 2009 at 11:26, Junio C Hamano <gitster@pobox.com> wrote=
:
> Pascal Obry <pascal@obry.net> writes:
>
>> Starting a new project I create a new repo and added some files for =
the
>> initial revision of the project, something like:
>>
>> mkdir repo.git
>> cd repo.git
>> git init
>> touch file
>> git add file
>> git ci -m "initial revision"
>>
>> Now one file was not meant to be committed, I wanted to revert this =
commit:
>
> That's not even an revert. =C2=A0Can't you simply amend it away?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git rm not-this-file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git commit --amend
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

This is obviously the easier way.  (Or a rebase --interactive)  I've
just got filter-branch on the brain, because of a git conversion.
