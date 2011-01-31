From: =?UTF-8?Q?Jo=C3=A3o_P=2E_Sampaio?= <jpmelos@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 20:36:55 -0200
Message-ID: <AANLkTikef6og4pttT0GKW1LUAtaKvVjTMVHTZaa3TO2h@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.1101311459000.8580@xanadu.home>
	<20110131210045.GB14419@sigill.intra.peff.net>
	<alpine.LFD.2.00.1101311621150.8580@xanadu.home>
	<7vpqrc4t1s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 23:37:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2Mq-0004sp-TO
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 23:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab1AaWg6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 17:36:58 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56482 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562Ab1AaWg5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 17:36:57 -0500
Received: by bwz15 with SMTP id 15so5751493bwz.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 14:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s4RBxfCyCXwxWR5NF2lwqnFn91CUaLqgce04a1jlRPM=;
        b=b7DmHPvlBINICEG2UqPjFuGaD/JDIS1AdSSaPQJexrOmDM6LYB5n59qHI+Xt+eUXoV
         qa03tdw739glK6JHzogSNeycn4uG1MjYv1RhGtRA3OaEiQ2TswfnW/kFOUWTkAMLIPgf
         ali+Zeipn4zLbvlhrBN3fkt+v9D06+F5BiFRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uAc4j3XwIe9Yv+XFysE+coF+ZkHFo1yvztK5RGmckpom0sAba7STc26gSNc6QH2c1M
         1s0xEiCEgfNdPueYbW3QeMZWf6Pi8UyaY6XXv+UX3984pLGrrpN7AURGMqXpVtHFEd3w
         orMKI6SOwzrk+zvEz6MkobNzIOt/CRw+qbKT0=
Received: by 10.204.101.133 with SMTP id c5mr1095257bko.124.1296513415246;
 Mon, 31 Jan 2011 14:36:55 -0800 (PST)
Received: by 10.204.66.6 with HTTP; Mon, 31 Jan 2011 14:36:55 -0800 (PST)
In-Reply-To: <7vpqrc4t1s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165767>

I think a good code hygiene is important, and some suggestions here
are relevant:

1) I also think there should be a directory for the source code
(namely, src/), and the top level should act as a table of contents.
As a newcomer myself who's trying to grasp Git, I can say an organized
project makes people more inclined join. Therefore, directories should
be named as clearly as possible: see item 2;

2) For item 1, t/ should be renamed to testsuite/. As Junio said, if
we get a more organized project, people could just "cd t" and tab to
autocomplete, or "cd tes" at the worst scenario, which is not such a
big hassle. About people expecting the testsuite to be inside t/, once
they type "cd t" and get an error, most people would look for an
alternative and eventually find the correct folder, or tabbing would
just suggest the name.

3) The top level should hold files that point people towards where
they want to go, helpful files like README and even some
Documentation/ files could get a promotion.

3) As 1.8.0 can be an inflexion for users, so could be for the
developers as well.

--=20
Jo=C3=A3o Paulo Melo de Sampaio
Computer Engineering Student @ UFSCar
Website: http://www.jpmelos.com
Twitter: twitter.com/jpmelos (@jpmelos)
