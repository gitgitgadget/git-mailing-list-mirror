From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 07/32] tree.c: find_subtree() to search for a tree
Date: Tue, 24 Aug 2010 23:35:42 -0600
Message-ID: <AANLkTi=cuT9HiZyp67rMBM63KjuOpADjAVMYbQ-cfDWm@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-8-git-send-email-pclouds@gmail.com>
	<AANLkTi=5OoRWXND4x7YJKTU2kPaBAiUwYMFRocB8RC4A@mail.gmail.com>
	<AANLkTinAzJHt3Bc9R0t50dUWqYqP5PGKG6-5Vj3sM=pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 07:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo8eN-0008Nt-50
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 07:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab0HYFfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 01:35:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44110 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab0HYFfo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 01:35:44 -0400
Received: by fxm13 with SMTP id 13so97923fxm.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GlE7WgEnsMjf0ElcWYUWTYfsRdgjlCAeQFr4zB1ixtc=;
        b=JIj3I9l2Rsyf1YOZM28F4AKDUj7BIJb8CbYzlulR5Y5JACKWO1YPGIi5A9jmgsc6nN
         s5KpCAAZuZhqPtLJtnbIaakF2hqQWf1zSJv4QkvdeZ+WIiP6TWUeE/zpxDYGCtzujjsy
         H2MOZMo4zdJp9drWKz1GhIavaR3n5tNDqVGUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qd0fEMKNKevogSjiIr4MfjmQODGl+hQcGnTKiU1VLVPI3RxT/hpON8bBbkLSiiwFRk
         1dpw5tM+KdF6tTmkMgnROJMRIZMgSZsQn3wRL1yXLY2OtbEHECMZZVXyexVhToS8xmu5
         wsBHxhgqeUCu4AuJ5DDzqEHMnqow0zhQvRTEg=
Received: by 10.223.124.9 with SMTP id s9mr6862770far.91.1282714543014; Tue,
 24 Aug 2010 22:35:43 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 24 Aug 2010 22:35:42 -0700 (PDT)
In-Reply-To: <AANLkTinAzJHt3Bc9R0t50dUWqYqP5PGKG6-5Vj3sM=pA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154422>

On Tue, Aug 24, 2010 at 9:43 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
>> Also, when trying to apply your series locally on master, it seems t=
o
>> die on this patch. =C2=A0What commit is your series based on?
>
> c11969de, master at Aug 19.

Hmm...seems they don't apply there either, but the reason is because
gmane changed the order of your patches.  That's unfortunate.  :-/
