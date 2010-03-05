From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH v5-j6t 2/3] git-core: Support retrieving passwords with 
	GIT_ASKPASS
Date: Fri, 5 Mar 2010 10:31:18 +0800
Message-ID: <1976ea661003041831n2573bda2xd0f528e03a1444de@mail.gmail.com>
References: <1267713364-2976-1-git-send-email-lznuaa@gmail.com>
	 <7vd3zk6j01.fsf@alter.siamese.dyndns.org>
	 <201003042059.51516.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Mar 05 04:21:51 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnNtx-0000Ey-VP
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 04:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418Ab0CECbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 21:31:20 -0500
Received: from mail-yx0-f185.google.com ([209.85.210.185]:39305 "EHLO
	mail-yx0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab0CECbT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 21:31:19 -0500
Received: by yxe15 with SMTP id 15so1806622yxe.25
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 18:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/UO0LyZgV8ae8126/DW0F7hIQwcwWs01lEpaJjoeIe4=;
        b=J8IiGalwkWSgKpkG8SOy9CbjB29jZ0kyPKE9Z4A1cPyrKY5d9R0L9DvnWaSKxjCEgc
         UV0J1P1u+kj3+AyOvpYjtfhia80J2q5M2Ne3OGYw0bNzgc9G7rmei8r9pA/kvBkhxeeW
         ydicom8MTKHP3jrRDTT4lrFVyelXnjXLIaqcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NkOyXraSNxozBC9qpA2TxngL1RWaiQpV5UEcN3KM9zH02Kb5sXbbejYM6z5vY7m2tj
         Oyl8lyWqJsjhAMIJtiO8YWUI4rARWdhtSggVwIUmj5tCyS8Sf3ivoySLbFKV9/jDsyIN
         62olYdv5PHRRGiHJ8D77cJt8O9OC29kJi8Yys=
Received: by 10.150.252.5 with SMTP id z5mr500677ybh.25.1267756278377; Thu, 04 
	Mar 2010 18:31:18 -0800 (PST)
In-Reply-To: <201003042059.51516.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141555>

>
> =A0I changed the code to make struct strbuf buffer itself static and =
fixed
> =A0the error message. I removed the comment about the memory leak aga=
in
> =A0because now the buffer is conceptually static even though behind t=
he
> =A0scenes it points to allocated memory.
>
> =A0Frank, I did not test it beyond the test suite. Please test and sa=
y
> =A0no or go.
>

        Thanks.
        I test it. It work rightly with prompted password
appliction(ssh-askpass).


best regards
=46rank Li
