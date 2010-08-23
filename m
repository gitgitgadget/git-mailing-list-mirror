From: Charles Brossollet <chbrosso@lltech.fr>
Subject: Re: git diff shows no output
Date: Mon, 23 Aug 2010 08:34:47 +0200
Message-ID: <5A25561B-B643-4203-82B7-BCED02EAFC61@lltech.fr>
References: <EBCC0FEA-1FF2-4909-BE80-DE280C9D6487@lltech.fr> <20100820133856.GC15736@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 08:35:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnQcj-0004iY-CJ
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 08:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab0HWGfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 02:35:08 -0400
Received: from zimbra-ne01.network-studio.com ([62.93.225.49]:60893 "EHLO
	zimbra-ne01.network-studio.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751978Ab0HWGfG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 02:35:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-ne01.network-studio.com (Postfix) with ESMTP id 70E658610EF;
	Mon, 23 Aug 2010 08:34:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra-ne01.network-studio.com
Received: from zimbra-ne01.network-studio.com ([127.0.0.1])
	by localhost (zimbra-ne01.network-studio.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BCNWaKs2KF2g; Mon, 23 Aug 2010 08:34:48 +0200 (CEST)
Received: from [192.168.0.2] (bne75-2-82-67-188-234.fbx.proxad.net [82.67.188.234])
	by zimbra-ne01.network-studio.com (Postfix) with ESMTPSA id 2D630860866;
	Mon, 23 Aug 2010 08:34:48 +0200 (CEST)
In-Reply-To: <20100820133856.GC15736@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154204>

That's right, nice guess!! thanks a lot!

Best
--=20
Charles

Le 20 ao=FBt 2010 =E0 15:38, Jonathan Nieder a =E9crit :

> Hi!
>=20
> Charles Brossollet wrote:
>=20
>> "git diff" shows nothing, while "git diff | cat" shows the diff, as
>> well as "git diff>output.txt" puts diff in output.txt.
>=20
> "git diff" paginates its output by default.  Perhaps your $LESS
> contains -F but not -X?
>=20
> Hope that helps,
> Jonathan
