From: Arthur <a.foulon@amesys.fr>
Subject: Re: git-p4 clone @all error
Date: Tue, 6 Nov 2012 00:55:40 -0800 (PST)
Message-ID: <1352192140569-7570622.post@n2.nabble.com>
References: <1351593879401-7570219.post@n2.nabble.com> <CABYiQp=1HEW=53U2Rck5vckhq0PB3C9iuanoXeVvNG6Xv5+oHg@mail.gmail.com> <20121103231305.GB11267@padd.com> <1352109747598-7570575.post@n2.nabble.com> <20121105221212.GA12003@padd.com> <20121106002515.5b7eba50@fenix.utopia.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 09:55:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVewu-0006SD-6x
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 09:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab2KFIzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2012 03:55:42 -0500
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:50777
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab2KFIzl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2012 03:55:41 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <a.foulon@amesys.fr>)
	id 1TVewe-0003A5-J4
	for git@vger.kernel.org; Tue, 06 Nov 2012 00:55:40 -0800
In-Reply-To: <20121106002515.5b7eba50@fenix.utopia.dhis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209103>

Thanks for your support,

If i get latest r=C3=A9vision on Perforce i have this errors :


/    590 errors reported
    Librarian checkout
depot/mainline/02_subsystem/10_arinc_429/00_cots/01_bsp_aim/original
files/api429decryption.txt failed.
    open for read:
depot/mainline/02_subsystem/10_arinc_429/00_cots/01_bsp_aim/original
files/api429decryption.txt,v: Le fichier spcifi est introuvable.
    Librarian checkout
depot/mainline/02_subsystem/10_arinc_429/00_cots/01_bsp_aim/original
files/api429linuxrelnotes.pdf failed.
    open for read:
depot/mainline/02_subsystem/10_arinc_429/00_cots/01_bsp_aim/original
files/api429linuxrelnotes.pdf,d\1.1150: Le chemin d'accs spcifi est
introuvable.
    Librarian checkout
depot/mainline/02_subsystem/10_arinc_429/00_cots/01_bsp_aim/original
files/lien vers readme.txt failed.
    .../

Perforce can't find the files because they were removed. (option
obliterate...)
So the error on the Perforce clone may come from this.


How i can show git-p4.branchList ?

My depot structure :

MAINLINE
  DEV_DATA
  RELEASE_1.0
  RELEASE_1.0.0




--
View this message in context: http://git.661346.n2.nabble.com/git-p4-cl=
one-all-error-tp7570219p7570622.html
Sent from the git mailing list archive at Nabble.com.
