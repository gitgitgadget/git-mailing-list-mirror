From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-create.sh: Support for multiple {to,cc,bcc} options
Date: Sat, 9 Aug 2008 12:49:35 +0200
Message-ID: <36ca99e90808090349sf08fab5sa0a3194f8a68ead7@mail.gmail.com>
References: <1218141086-16063-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080809003357.GQ10151@machine.or.cz>
	 <7vbq039dfa.fsf@gitster.siamese.dyndns.org>
	 <20080809082701.GE32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Aug 09 12:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRm1x-0001gb-Oz
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 12:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbYHIKti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 06:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbYHIKti
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 06:49:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:52735 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYHIKth (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 06:49:37 -0400
Received: by wr-out-0506.google.com with SMTP id 69so983563wri.5
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 03:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iELkWNMbigZfHB+8qrhtXC/eOeB30jJoZP5E6Bm2FvE=;
        b=PyctHw92OmA3NP61NJEfOP/KCDwlCDKDWgIk0aRg865mit7/7XbEJ37Ps2ImwcYT1/
         lUwKS/VMZYHGhGANEb0TmBPj/TT8phvCsDhd/q7wVLcyzY9og2A0TAcbNz3p1CigjUEl
         MJioeZsPomQLvrsCwDXHp+Iow63KS2Qs5uhZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=o83ftpxrATr6mVOYFsDvUz27EjukEPk0jXnrrGpa1KGvSnft1Gkq9kTYH5Q3qUuHUR
         aelkMFXU7Gmp5NTkJRKBXeCS/ccOh0nrycyjsixS9Q9m4EhkUKT+tnhHVQnrVjKMUE/H
         681ArN1NBpOTKeS1z/zo4y+JWQV1YggR3S1+I=
Received: by 10.90.66.5 with SMTP id o5mr7879610aga.94.1218278975296;
        Sat, 09 Aug 2008 03:49:35 -0700 (PDT)
Received: by 10.70.28.18 with HTTP; Sat, 9 Aug 2008 03:49:35 -0700 (PDT)
In-Reply-To: <20080809082701.GE32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91764>

On Sat, Aug 9, 2008 at 10:27, Petr Baudis <pasky@suse.cz> wrote:
>> >> +
>> >> +  git config --get-all topgit.$1 2>/dev/null |
>> >> +          sed -e "s/^/$prefix /g"
>> >> +}
> I still don't understand the stderr redirect, though.
Just precaution, I think. It seems unnecessary.

Bert
>
>                                Petr "Pasky" Baudis
>
