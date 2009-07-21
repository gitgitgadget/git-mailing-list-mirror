From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v2] FindBugs: don't use new String(String) in RefDatabase
Date: Tue, 21 Jul 2009 16:50:36 +0200
Message-ID: <200907211650.36831.robin.rosenberg.lists@dewire.com>
References: <49C20D4E.5020203@gmail.com> <551f769b0907130107j51d32e4er54e125f9dc61dd80@mail.gmail.com> <20090713145308.GI11191@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Simon <yann.simon.fr@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 16:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTGgA-0002IH-F6
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 16:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbZGUOup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2009 10:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbZGUOuo
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 10:50:44 -0400
Received: from mail.dewire.com ([83.140.172.130]:2944 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbZGUOun convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 10:50:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 124EA1481DB3;
	Tue, 21 Jul 2009 16:50:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id po9M045Jo5t7; Tue, 21 Jul 2009 16:50:38 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 7450F1481DB2;
	Tue, 21 Jul 2009 16:50:38 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090713145308.GI11191@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123659>

m=E5ndag 13 juli 2009 16:53:08 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
>  Yann Simon <yann.simon.fr@gmail.com> wrote:
>  > This method is quite clear.
>  > One line javadoc would make it even clearer... :p (and maybe make =
Robin happy)
> =20
>  Javadoc is overrated.  Private utility methods like this that are on=
e
>  line long don't need documentation.  The rationale for why this line
>  does what it does is something that `git blame` can answer better.

Sorry Yann, I'm with Shawn here. A comment wouldn't add anything here s=
ince
the method is pretty simple. Besides javadocs are for API's so an inlin=
e comment
would be better, but I don't think it is necessary.

Shawn, any references for the ability of JIT's abilities to stack alloc=
ate in this context? For
me learning, will commit anyway.

-- robina
