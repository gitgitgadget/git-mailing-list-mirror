From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 6/7] web--browse: use (x-)www-browser if available
Date: Sat, 4 Dec 2010 08:49:09 +0100
Message-ID: <AANLkTinG3moZFNOMBwrc7UTrXuGeUourQp+6OEH5Vcgh@mail.gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-7-git-send-email-giuseppe.bilotta@gmail.com>
 <7vaakmmrkj.fsf@alter.siamese.dyndns.org> <AANLkTinWD53M2VjiWgeA0Qwx3OHzR2A09Y+AB2B9o1df@mail.gmail.com>
 <20101204004225.GA15906@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 08:49:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POmsV-0000S1-Vk
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 08:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab0LDHtb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Dec 2010 02:49:31 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42892 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab0LDHta convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 02:49:30 -0500
Received: by iwn6 with SMTP id 6so830475iwn.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 23:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fIRtO4Xc7hnRAGp1rdEj3J5WdqfVmo6mxb/tiEIjapg=;
        b=Q7AfSsfrD1KLJp+vGAnmxEk5DTh3TAZOlJsmK5ydI8W1TM3uobMzzkTtUbOabSdVym
         oPEsxw3jNFsZaNEb23cuf66ABghiw8OmAjYR4erCLIXi2uAiLESLDB75jM3BF1FB5Hmp
         wkuiDiaYAdKK3YY54ciybBheZUaqkpzQaISWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FlJ2gUDJy1hESY3NCXDel1eLDdjaxvMVtbQu59jP4Anr6yIKnUgX/roX/9L4G6e4EP
         046PC2mFlIAzyCMHFAOLZHT9cXZ7nUIO6RjcW+O396yDPTyq/TLD4kSl6F9/tfNQXgBl
         aZ3KlrXqRjWfwoY4u07CYMemqCIvNoqff+nIw=
Received: by 10.231.36.12 with SMTP id r12mr2891743ibd.156.1291448969983; Fri,
 03 Dec 2010 23:49:29 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Fri, 3 Dec 2010 23:49:09 -0800 (PST)
In-Reply-To: <20101204004225.GA15906@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162889>

On Sat, Dec 4, 2010 at 1:42 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Giuseppe Bilotta wrote:
>
>> I do believe that Debian encourages the use of sensible-browser (tha=
t
>> does the BROWSER and *www-browser check itself) rather than manually
>> going to look at those specifications.
>
> My impression (by analogy with policy =A711.4 "Editors and pagers") i=
s
> that one is encouraged to make the default configurable at compile
> time and use
>
> =A0- first $BROWSER
> =A0- then something desktop-specific
> =A0- then the configured default
>
> and set that default to www-browser or x-www-browser, depending on
> whether your program uses X. =A0That way, non-Debian systems benefit
> from the changes you introduce, too.

I'm not entirely sure how non-Debian would benefit from the change at
the current state, but I'm willing to present patches for the
mechanism offered by other distributions (e.g. does anybody know how
RedHad/Fedora sets the preferred browser?)

>> An alternative approach would be to get rid of the *www-browser and
>> BROWSER patches, and just use xdg-open if it's available. Which agai=
n
>> raises the issue of how to enforce opening the page in a new tab.
>
> Yes, in this case that is the ideal (assuming xdg-utils has wide
> enough adoption).
>
> I think xdg-open has just as much a reason as we do to encourage
> opening the page in a new tab. =A0Would it be hard to make that happe=
n?

I have no idea. Also, it's sort-of outside the scope of our reach, and
we would have to wait for a change in that effect to 'trickle down'.

--=20
Giuseppe "Oblomov" Bilotta
