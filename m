From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to git-archive ignore some files?
Date: Tue, 06 May 2008 15:08:25 -0700
Message-ID: <7vk5i7gk6e.fsf@gitster.siamese.dyndns.org>
References: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br>
 <BAYC1-PASMTP023026B88005E512F95384AED60@CEZ.ICE>
 <4820CC35.3090202@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Victor Bogado da Silva Lins <victor@bogado.net>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 07 00:09:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtVLp-0003m7-Nc
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 00:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933398AbYEFWIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2008 18:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933342AbYEFWIl
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 18:08:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694AbYEFWIj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 18:08:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6EE552BB1;
	Tue,  6 May 2008 18:08:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BC7052BAE; Tue,  6 May 2008 18:08:30 -0400 (EDT)
In-Reply-To: <4820CC35.3090202@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Tue, 06 May 2008 23:23:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F8E1318C-1BB8-11DD-B313-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81383>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> To really solve this without external tools, git-archive needed to gr=
ow
> an --exclude option like git-ls-files, though.

Because exclude is never about ignoring what is already tracked, an opt=
ion
"like" git-ls-files would not help this case, I am afraid.
