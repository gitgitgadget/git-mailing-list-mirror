From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Mon, 30 Jul 2012 07:15:09 +0530
Message-ID: <CAMK1S_gQWkvmL59aDYMOL1zUv04Wf7WcV7dEi9Uz6=UP9g7AOA@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
	<7vehnvvyta.fsf@alter.siamese.dyndns.org>
	<20120729142458.GB16223@paksenarrion.iveqy.com>
	<CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
	<7vvch6uw89.fsf@alter.siamese.dyndns.org>
	<7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
	<CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
	<7vr4rut4u9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 03:45:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svf2t-0007x9-KM
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 03:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab2G3BpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 21:45:12 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47147 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753861Ab2G3BpL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 21:45:11 -0400
Received: by lahd3 with SMTP id d3so3143302lah.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 18:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ty1UM2JruWfR2jdxMZPzhLJFu7aChhowEmg66kwemys=;
        b=rtn94VfxwzsCErhM0H8MM+vAvDLtsVesp8Dz/4n+NlRXYTEDVy3h+qtqfM0Tk2H3WH
         vgBhxT70fGD3lOPQgZQCAWj5lm6bo2tkhbjaAanknXrsVXPXmaoEpACQyOXleLmZymbk
         kwSWJC8fTZYZ/uUku9/6lZBFcEvqreNF/NQq5aJgaEyGJxctJiVWRJPdj20OKEEGHmMR
         wHS/fmWTAwguYKpxeG1fwSDab3uL1is4WhMww+Fp9HQ0ysDONY8znDDgNew66l05EEVp
         lk0l3glNaZ3U3n9OOvbL2b73BbN+c7GgrJSH2tDNsIjnVShgkxwWo6dPElaHuOeGPxRM
         ou8Q==
Received: by 10.112.39.135 with SMTP id p7mr4559451lbk.78.1343612709396; Sun,
 29 Jul 2012 18:45:09 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Sun, 29 Jul 2012 18:45:09 -0700 (PDT)
In-Reply-To: <7vr4rut4u9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202518>

On Mon, Jul 30, 2012 at 6:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> As I may have said earlier, this interaction is far too site-specific
>> to be rolled into git itself.
>>
>> How about a new hook instead?  A pre-pack-protocol hook that acts as
>> if it was called by the remote user as a command, and if it exit's
>> with 0, then the real pack protocol starts else it gets aborted.  Let
>> him do whatever he wants in there.  Arguments to the hook will be repo
>> name and command (git-upload-pack mainly).
>
> Not very interested.  If it is _known_ to happen before Git protocol
> proper happens, why not give the user something like the gitolite
> command "D", that is interpreted by gitolite-shell without bothering
> Git at all?

Indeed.  In one of the earlier messages I already told him he should
copy and munge the fork command in gitolite to do precisely this.
