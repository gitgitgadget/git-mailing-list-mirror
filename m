From: Johannes Walther <joh_walt@yahoo.de>
Subject: cogito: strange cg-switch -l behaviour
Date: Tue, 6 Mar 2007 20:53:02 +0100 (CET)
Message-ID: <20070306195306.43645.qmail@web27814.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 21:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOfpN-00034C-HG
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 21:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbXCFT7s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Mar 2007 14:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbXCFT7s
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 14:59:48 -0500
Received: from web27814.mail.ukl.yahoo.com ([217.146.182.19]:32081 "HELO
	web27814.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751038AbXCFT7r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2007 14:59:47 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Mar 2007 14:59:47 EST
Received: (qmail 43647 invoked by uid 60001); 6 Mar 2007 19:53:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0Bh68nMLyggwAXtkU14W7X+K6gx7QfMamR4N9K05E2vWYXCTgOwD07cvbK69FO7SDnymGhvb7Lp6uDTfxwHw2eGARrYN8SapQkLRUfAnd5kMpT2PlAVQe7RizAqN67oFKhW0/brHen2+qMmJ0mIvCBYuCVHaSna6izWeZ7FxeQA=  ;
X-YMail-OSG: inSsr1EVM1mNdowR8230IEX_qP_O5mqE7.TpSiQIQ2V0AGwleHGvkhgpVH62O8OrCQ--
Received: from [212.204.66.66] by web27814.mail.ukl.yahoo.com via HTTP; Tue, 06 Mar 2007 20:53:02 CET
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41590>

Hi,

I currently try getting in this git thing and looked
also into cogito.
I would prefer cg-switch over git-checkout because of
the -l (and also -p) switch that I hoped will do what
I want.

Because pure cg-switch leads to problems with
uncommitted local changes and quite different files in
the destination branch, I'd like to alias cg-switch to
cg-switch -l.

But if -l is always set, the following happens:

> master
  Testing

=46ile is in status of master.

$ cg-switch -l Testing
Saving local changes...
Switching to branch Testing...

   .cg-shelve-master =20
s  master
>  Testing

=46ile is in status of Testing.

$ cg-switch -l master
Saving local changes...
cg-commit: Nothing to commit

   .cg-shelve-master
>  .cg-shelve-Testing =20
s  master
s  Testing

=46ile is still in status of Testing.
But I'd expect getting my successfully saved master
status back.

Is that the desired behaviour?

Johannes




=09
	=09
___________________________________________________________=20
Der fr=FChe Vogel f=E4ngt den Wurm. Hier gelangen Sie zum neuen Yahoo! =
Mail: http://mail.yahoo.de
