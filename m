From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: MIME headers in introductory message (git send-email --compose)
Date: Tue, 25 Mar 2008 16:59:31 -0400
Message-ID: <76718490803251359y53b505e4u781ded6df5364650@mail.gmail.com>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net>
	 <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org>
	 <200803252031.17017.tlikonen@iki.fi>
	 <76718490803251217q27ae4381h298ec6de8a4d965a@mail.gmail.com>
	 <7vhceuleeu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Teemu Likonen" <tlikonen@iki.fi>,
	git@vger.kernel.org, "Samuel Tardieu" <sam@rfc1149.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 22:00:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeGFj-0005xz-Mf
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 22:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbYCYU7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 16:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbYCYU7d
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 16:59:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:21238 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbYCYU7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 16:59:32 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2470927wra.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lF5elscuX9N1BE0toQKx7rw9YGlhxCh/0Rp51WmpkKw=;
        b=GCCC2+pQoSk4mT7KzJjpBk8YcS5pmZdwwgADEf3Sc1Sb4m0Qdbi2dbnHfIeRVrnHIG51mqXNwR6FKJ0mlR+wp0VxO8aaNyu9qRr02Dpd3MxhMcNcvm3fP40BeTme6hCgs1dcW59cz4T5KAJDKl3wETsP2MI75BtGsSOKuGwTGOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=itbUcvrDcxzp2DIso0BGce66lgT4G4+0R726EuwHbotqVUBc/FbygPnt+6GyGd6MrlgS7L0xNXVJpDGUfmA3VplC1L3xa9CvN4b66JAyfjA8Jmmig4vs7i0Uw+35Fp7B9jxP/ZcJ3D7n9LMnxJQGDQ59R0tt2Xkkxq+B6+YXa4Y=
Received: by 10.140.179.25 with SMTP id b25mr3772539rvf.186.1206478771577;
        Tue, 25 Mar 2008 13:59:31 -0700 (PDT)
Received: by 10.141.33.18 with HTTP; Tue, 25 Mar 2008 13:59:31 -0700 (PDT)
In-Reply-To: <7vhceuleeu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78220>

On Tue, Mar 25, 2008 at 4:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Jay Soffian" <jaysoffian@gmail.com> writes:
>
>  > I stuck this in my config and it works-for-me:
>  >
>  > [format]
>  >       headers = \
>  > "MIME-Version: 1.0\n\
>  > Content-Type: text/plain; charset=UTF-8\n\
>  > Content-Transfer-Encoding: 8bit\n"
>
>  I suspect that you shouldn't do this.  This would badly interfere both
>  with existing format-patch behaviour that adds these MIME-Version and
>  Content-Type headers by looking at the contents, and with recent
>  format-patch fix 6bf4f1b (format-patch: generate MIME header as needed
>  even when there is format.header, 2008-03-14) to make the detection based
>  on contents (and presense of format.headers).

Fair enough. But I never send out a patch w/o looking at it in an editor
first so I would've caught that. Thanks for the heads-up though.

j.
