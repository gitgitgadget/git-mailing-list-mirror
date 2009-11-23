From: Thomas Singer <thomas.singer@syntevo.com>
Subject: OS X and umlauts in file names
Date: Mon, 23 Nov 2009 17:37:22 +0100
Message-ID: <4B0ABA42.1060103@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 17:37:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCbum-00070A-Ia
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 17:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbZKWQhJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 11:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755258AbZKWQhJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 11:37:09 -0500
Received: from syntevo.com ([85.214.39.145]:35855 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898AbZKWQhI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 11:37:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id E9F7937C7B5
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133507>

I'm on an English OS X 10.6.2 and I created a sample file with umlauts =
in
its name (=DCberl=E4nge.txt). When I try to stage the file in the termi=
nal, I
can't complete the file name by typing the =DC and hitting the tab key,=
 but I
can complete it by typing an U and hitting the tab key. Unfortunately, =
after
executing

 git stage =DCberl=E4nge.txt

I invoked

 git status

and it still shows the file as new file. Should I set some environment
variable to be able to work with files containing umlauts in the name?

Thanks in advance,
Tom
