From: =?UTF-8?B?SsO8cmdlbiBNYW5nbGVy?= <juergen.mangler@univie.ac.at>
Subject: do without .netrc
Date: Wed, 06 Aug 2008 01:00:54 +0200
Message-ID: <4898DBA6.1060707@univie.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 01:13:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQViX-0004AX-QX
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 01:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbYHEXML convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 19:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762698AbYHEXMK
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 19:12:10 -0400
Received: from grace.univie.ac.at ([131.130.3.115]:36751 "EHLO
	grace.univie.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757283AbYHEXMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 19:12:08 -0400
X-Greylist: delayed 672 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Aug 2008 19:12:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=univie.ac.at; s=rev1; h=Message-ID:Date:From:MIME-Version:To:
	Subject:Content-Type:Content-Transfer-Encoding; bh=uFzU1uDDmgjDa
	SQIZyEbVhe8QWWAEWFYcKvVbLXAO2c=; b=b3sY8yhumFpw0lzeGUS7kQ/DuZwVK
	ayoRyqLCUnWIkygxMC8HCXAGLzKgwUKkIQER9rjWPvOM2Z/p0p7gZdXK6khtOMsr
	Uhk/CSNwUWm5DWXDO/pSSCpTw8ID17TGiTlWZxzO5Lsx2W0gQt5gbHMzAaRafUtt
	4u9znTnMo3y+eY=
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtp (Exim 4.69)
	(envelope-from <juergen.mangler@univie.ac.at>)
	id 1KQVWQ-0004V3-Vs
	for git@vger.kernel.org; Wed, 06 Aug 2008 01:00:54 +0200
Received: from [131.130.37.200] (helo=[172.17.19.72])
	by joan.univie.ac.at with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <juergen.mangler@univie.ac.at>)
	id 1KQVWQ-0000kx-Ui
	for git@vger.kernel.org; Wed, 06 Aug 2008 01:00:54 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080725)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91468>

"git clone http://a:b@donatello.pri.univie.ac.at/repositories/0/Data/"=20
is not working

also "git clone=20
http://a@donatello.pri.univie.ac.at/repositories/0/Data/" is not asking=
=20
for password. is it supposed to?

it is working without a:b@ part, but ~/.netrc instead

:-(, is it possible without .netrc

git version 1.5.4.3

thanks, regards

J=C3=BCrgen
