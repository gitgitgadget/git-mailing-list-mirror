From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 10:48:19 +0200
Message-ID: <fabb9a1e0904210148w4c6b869l396122baef1c0ee3@mail.gmail.com>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com> 
	<alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302> <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk> 
	<20090421024433.GC14479@coredump.intra.peff.net> <7vskk2bt3x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 10:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwBgC-00011t-8R
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 10:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbZDUIsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 04:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755692AbZDUIsh
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 04:48:37 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:50291 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881AbZDUIsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 04:48:35 -0400
Received: by bwz7 with SMTP id 7so1635991bwz.37
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RqEJoJoJb1OLC+jaXxzTE5LS6FHkNeKKcVlD7TpPSaI=;
        b=oK2AzoThPE9bu6sANNgtQFRPxeiYJUP/OmfgtY6Ydio0KMn86ntWfEheCuUi5lC5uU
         qG8xJmIjNAsC8bd63jccWmm/s/ukf2bV6pbShyXbe0dGLIK3avFYve7QTTzUzs40ePVf
         z4G2XfotAa1e7OpWUjycOndM2owkVHTgSTL3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Zm4XlEIbqZ/uiZnWioH9fxWycWaheFOQzTSoerA/4t2v1qopVZ8V+vIp1MiQnk/Aoq
         y6kCwYnpjI6Anyfiu29QDstKkx9tg35HU6DeHNfbDAdZKaQY5sWePxayawQkCdmI73ys
         Bf+O/ka0mjeQwxYaWoYmbn1hKwqkWQlabO35I=
Received: by 10.103.218.9 with SMTP id v9mr3638210muq.78.1240303714080; Tue, 
	21 Apr 2009 01:48:34 -0700 (PDT)
In-Reply-To: <7vskk2bt3x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117105>

Heya,

On Tue, Apr 21, 2009 at 05:09, Junio C Hamano <gitster@pobox.com> wrote:
> and sane projects would not have an empty file tracked anyway, so...

Except python projects that are full of empty __init__.py files.... no?

-- 
Cheers,

Sverre Rabbelier
