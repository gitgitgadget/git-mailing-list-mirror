From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 2/2] completion: complete config variables for 
	--get/getall/unset/unset-all
Date: Tue, 12 May 2009 12:05:05 -0700
Message-ID: <780e0a6b0905121205r7a57a99as2cb0b94ead73199d@mail.gmail.com>
References: <1241832213-23070-1-git-send-email-bebarino@gmail.com> 
	<1241832213-23070-2-git-send-email-bebarino@gmail.com> <1241832213-23070-3-git-send-email-bebarino@gmail.com> 
	<20090509034438.GZ30527@spearce.org> <4A09071A.1030107@gmail.com> 
	<7vtz3q91up.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 21:05:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3xIF-0005u6-0Z
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 21:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbZELTF0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 15:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbZELTFZ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 15:05:25 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:52848 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbZELTFY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 15:05:24 -0400
Received: by wf-out-1314.google.com with SMTP id 26so127032wfd.4
        for <git@vger.kernel.org>; Tue, 12 May 2009 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Uqr2FhX70LEOmXAuUmAIOxZU1xD1w2XFJRoReBufMoA=;
        b=Cub7jpzxV/NrSvZxPFHiJzB1JKlL/L/v3G5fnr9XHjL+lzAxZHHUfeZfNqxxJ53JFG
         IuHCIttsBTRuYvWHxRpN3sAKXig2K1mt+noi5To9Yq8ZMBdfRGebNZAQ6bnw5QZJUjws
         npV2lCCW5daAlzIOopsiWkwPPv02sVJhn9vh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PHy/zkZRLE6IQuunPrmCfE6rearRGe5cmHi9ylB1eThzcUuFmW/Ps0S96JxRC39gbd
         CjgHGYxWoKdMiircNvPj3q7cnkgkL2qjoQLJB7s+226M9Kza+ZFi60JGmh3+Et76xTKy
         k10p3o3unQFmI+oJk6iqAJthpZevS//zW4hRA=
Received: by 10.143.9.9 with SMTP id m9mr9849wfi.41.1242155125070; Tue, 12 May 
	2009 12:05:25 -0700 (PDT)
In-Reply-To: <7vtz3q91up.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118946>

On Tue, May 12, 2009 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Stephen Boyd <bebarino@gmail.com> writes:
>
>> Shawn O. Pearce wrote:
>>> These probably could have been one patch, since the function
>>> is introduced only to support this one usage, and this patch
>>> is only 4 lines larger than the function definition anyway...
>>
>> Seeing that this hasn't been picked up yet, I'm fine with this being
>> squashed into one commit. Could you use this combination of the two
>> messages for the commit?
>>
>> ---8<----
>>
>> Subject: completion: complete config variables for
>> --get/getall/unset/unset-all
>
> Hmm, shouldn't this just be
>
> =C2=A0 =C2=A0Subject: completion: complete variable names for "git co=
nfig" command
>
> ?
>

This patch adds completion for set variable names when --get,
--get-all, --set, or --set-all has been specified. Completion of
variable names for git config already exists. Maybe this would be more
clear:

Subject: completion: complete set variable names for git config
--get/get-all/set-set-all
