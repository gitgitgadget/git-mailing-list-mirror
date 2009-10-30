From: Pascal Obry <pascal@obry.net>
Subject: Re: keeping track of where a patch begins
Date: Fri, 30 Oct 2009 08:25:31 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AEA94EB.8080304@obry.net>
References: <3a69fa7c0910210745r311cf18xf966f5c63650cde6@mail.gmail.com> <alpine.LFD.2.00.0910211402490.21460@xanadu.home> <7veiow4iqc.fsf@alter.siamese.dyndns.org> <200910221027.32739.trast@student.ethz.ch>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, E R <pc88mxer@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 30 09:27:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3mpN-000722-0c
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 09:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311AbZJ3I1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 04:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754318AbZJ3I1K
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 04:27:10 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:39658 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbZJ3I1J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 04:27:09 -0400
Received: by ewy28 with SMTP id 28so2752564ewy.18
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 01:27:13 -0700 (PDT)
Received: by 10.210.3.21 with SMTP id 21mr98386ebc.40.1256891232774;
        Fri, 30 Oct 2009 01:27:12 -0700 (PDT)
Received: from ?10.10.127.189? (dhcp-guest.act-europe.fr [212.99.106.127])
        by mx.google.com with ESMTPS id 7sm8086636eyb.16.2009.10.30.01.27.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 01:27:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <200910221027.32739.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131679>


Le 22/10/2009 10:27, Thomas Rast a =E9crit :
> I think this not only changes the model of branches, but also commits=
,
> to some extent.  Currently, commit have no intrinsic branch
> membership; if you say
>
>    git branch foo bar
>
> you cannot distinguish whether the commits on 'bar' were created on
> 'foo' or on 'bar'.  (By git's means; of course the decision would
> favour 'master' if I had used that instead.)

I have been looking for a way to know that. I've even post a question=20
about this on this mailing-list long time ago IIRC.

To me there is case where it is important to know which are the commits=
=20
done on a topic branch for example. When working on multiple topic it i=
s=20
difficult to remember which commits have been done on this specific=20
branch. This is needed to rebase onto:

    $ git rebase --onto somebranch <topic_base> <topic_head>

A common idiom, but one as to think hard (& right) to properly get the=20
topic_base today.

Just my 2 cents!

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
