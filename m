From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH v3] Introduce BEL<branch> as shortcut to the tracked 
	branch
Date: Fri, 20 Mar 2009 13:33:18 +0100
Message-ID: <adf1fd3d0903200533s2be08ee7t58a22180b1c886c0@mail.gmail.com>
References: <200903181448.50706.agruen@suse.de>
	 <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>
	 <20090320004029.GX23521@spearce.org>
	 <20090320004450.GY23521@spearce.org>
	 <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de>
	 <3F6729A7-76FA-43F4-9538-D644B30576D7@wincent.com>
	 <alpine.DEB.1.00.0903201053280.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 13:35:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkdw4-0001fH-Pl
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 13:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbZCTMdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 08:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbZCTMdW
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 08:33:22 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:62168 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbZCTMdW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 08:33:22 -0400
Received: by bwz17 with SMTP id 17so871144bwz.37
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 05:33:19 -0700 (PDT)
Received: by 10.103.169.18 with SMTP id w18mr1317292muo.73.1237552398922; Fri, 
	20 Mar 2009 05:33:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903201053280.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113948>

2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Fri, 20 Mar 2009, Wincent Colaiuta wrote:
>
>> El 20/3/2009, a las 10:29, Johannes Schindelin escribi=F3:
>>
>> >
>> >Often, it is quite interesting to inspect the branch tracked by a g=
iven
>> >branch.  This patch introduces a nice notation to get at the tracke=
d
>> >branch: 'BEL<branch>' can be used to access that tracked branch.
>> >
>> >A special shortcut 'BEL' refers to the branch tracked by the curren=
t branch.
>> >
>> >Suggested by Pasky and Shawn.
>>
>> What does BEL actually stand for? I read Shawn's suggestion, but it'=
s not
>> immediately clear to me what "BEL" means.
>
> It is the ASCII "bell" character, 007 (I always wanted to write that
> magic identifier into a patch).
>
> FWIW you could type it in a regular ANSI terminal using Control-v
> Control-g.

Can we use branch^{origin} instead? It is longer to type, but uses the
same syntax as the ^{tree}, ^{commit}, ^{tag} and you don't have to
know how to produce the bell character.

2 cents,
Santi
