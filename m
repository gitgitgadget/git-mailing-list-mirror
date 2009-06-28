From: Roy Lee <roylee17@gmail.com>
Subject: Re: [PATCH] clone: add --perm option to clone an shared repository
Date: Sun, 28 Jun 2009 22:30:26 +0800
Message-ID: <6eac7f470906280730pa22b63fh464cd79a76fa20b3@mail.gmail.com>
References: <1245586672-10894-1-git-send-email-roylee17@gmail.com>
	 <4A3F3E08.10602@gnu.org>
	 <alpine.DEB.1.00.0906221134090.4168@intel-tinevez-2-302>
	 <4A3F5AC0.20207@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jun 28 16:37:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKvVN-0004hv-1W
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 16:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbZF1OhC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Jun 2009 10:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbZF1OhB
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 10:37:01 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:62176 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbZF1OhB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jun 2009 10:37:01 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jun 2009 10:37:00 EDT
Received: by yxe26 with SMTP id 26so381012yxe.33
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rU5ajZkY4K28NSA6srODHm1zpLSyYzMnyNXHhA539Ko=;
        b=p6PkI1grA3racekLz6SugeUVwGe5OZAilhJodLfCNDPFyyWqQDR1ltEsQpR3hG7b9G
         tgRgDoxBe50KZ6+g4yOYABXPa4Ch1+XCjzCEeJDsqHeg1SLqE6Hoj44s9q9uP6ZTYKg7
         PyICjuFseIdwUn7ZOLQDrauGiBqitFoE/Z+Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ONIozZZDF5FXGRWP4mmlEP/Uw9PzpwtBwA9D70WOG+tx4h0KSfqVUlbLSKjj76Xcfp
         yLUMEbFUkaS/cXUoAk0M7w1J35gZfEbsSVPlDHgvytJHTuKqFqXdg3aC3iObHwbQdygi
         BZ652pnaz6E4qn5ij4pN4l7jYUfx0Z4Kj7poU=
Received: by 10.100.124.11 with SMTP id w11mr7616059anc.165.1246199427037; 
	Sun, 28 Jun 2009 07:30:27 -0700 (PDT)
In-Reply-To: <4A3F5AC0.20207@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122406>

Hi,

On Mon, Jun 22, 2009 at 6:19 PM, Paolo Bonzini<bonzini@gnu.org> wrote:
> Johannes Schindelin wrote:
>>
>> Hi,
>>
>> On Mon, 22 Jun 2009, Paolo Bonzini wrote:
>>
>>> Roy Lee wrote:
>>>>
>>>> The term 'shared' used here is in the same context with git init.
>>>> Unfortunately the 'shared' option has been taken, so I took the "p=
erm"
>>>> as a place holder in this patch. Any comments?
>>>
>>> I think it would make sense to add "perm" to git-init too (and poss=
ibly
>>> deprecate --shared).
>>
>> Agreed. =A0After we teach everybody on this planet that "perm" means
>> "shared", and "shared" does not.
>
> Or instead of teaching everybody on this planet that "shared" means "=
set
> permissions for sharing" in one context, and "use hard links and set =
up
> .git/objects/info/alternates, which by the way may be dangerous" in a=
nother.
> :-)
>
> But you made me think, and maybe it is better to remove argument-less
> --shared instead. =A0What Roy introduced seems much more useful in pr=
actice.
>
> Paolo
>

This patch intends to provide the functionality for git clone to conver=
t
existing repositories to "shared" ones.

Have we come to agreement to add such functionality?
If so, how do we get to the agreement on the used terms or other issues=
?
