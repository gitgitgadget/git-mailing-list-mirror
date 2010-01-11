From: Michael Witten <mfwitten@gmail.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Sun, 10 Jan 2010 23:29:52 -0600
Message-ID: <b4087cc51001102129n5d5ac022s4f6f3ee9512eefd2@mail.gmail.com>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com> 
	<alpine.LFD.2.00.1001101501520.10143@xanadu.home> <7v8wc5itlc.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001101556490.10143@xanadu.home> <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com> 
	<be6fef0d1001101757w7f54c9b2ye58c66179137efb1@mail.gmail.com> 
	<7vk4vpcs1q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 06:31:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUCs0-0002rv-OX
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 06:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab0AKFaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 00:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027Ab0AKFaT
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 00:30:19 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:10853 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab0AKFaO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 00:30:14 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1751118eye.19
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 21:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Mky3a2lMEPQIRKKuvQyhT7RLi1V1cufnXrXB+tT3Op0=;
        b=FAqE+w5b9F2n0/OCL5DSX9s2q1ZtIt9qIo/iTWG0mzGdz8oAGjP3+36Y51JfC25pv6
         EmwA43oAevd4CDhPiZh3bFcZnKwqLmL7wwBPY68fBL9mlUgtGRUnoZDh944zOPtljAmf
         tj3YbCm7UWcnLEQGoSto0xlMVUshNSVIEbDsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BYjFXtQM8unLAMKcKovEJr6xMMhCf1BaPIxox892NKKVUDJAhMOpxqlgepDB04BmIl
         nQmZk0nKd/CGB2xur4FB4SOPjCabfJdbfPF139G2dOWEsIa1EhkiKEor4SNZ+zfhGgd0
         ZtA1WxyQJFYsB3w8+KKdEBb2BDY7irfm18S4E=
Received: by 10.213.23.200 with SMTP id s8mr2800930ebb.52.1263187812140; Sun, 
	10 Jan 2010 21:30:12 -0800 (PST)
In-Reply-To: <7vk4vpcs1q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136604>

On Sun, Jan 10, 2010 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Until all the objects are safely transferred, none of the refs
> are updated, whether they are directly slurped into local branch name=
space
> or remote tracking branch namespace. =A0So no matter what the configu=
ration
> is, interrupted transfer, forced or otherwise, is safe.

I suggest adding this kind of information to the fetch/pull (and I
suppose push) documentation.
