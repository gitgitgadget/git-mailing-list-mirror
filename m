From: Massimo Manca <massimo.manca@micronengineering.it>
Subject: Fwd: installing git from sources
Date: Mon, 11 Jul 2011 18:36:55 +0200
Organization: Micron Engineering
Message-ID: <4E1B26A7.8030404@micronengineering.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000403010602000803050404"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 18:38:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgJUi-0008RR-2C
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 18:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758101Ab1GKQh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 12:37:58 -0400
Received: from smtplq-out17.aruba.it ([62.149.158.37]:50045 "HELO
	smtplq03.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1758083Ab1GKQh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 12:37:57 -0400
Received: (qmail 8392 invoked by uid 89); 11 Jul 2011 16:37:56 -0000
Received: from unknown (HELO smtp6.aruba.it) (62.149.158.226)
  by smtplq03.aruba.it with SMTP; 11 Jul 2011 16:37:56 -0000
Received: (qmail 2627 invoked by uid 89); 11 Jul 2011 16:37:55 -0000
Received: from unknown (HELO ?127.0.0.1?) (tecoff@micronengineering.it@62.94.226.18)
  by smtp6.ad.aruba.it with ESMTPA; 11 Jul 2011 16:37:55 -0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; it; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
X-Enigmail-Version: 1.1.1
X-Antivirus: avast! (VPS 110711-0, 11/07/2011), Outbound message
X-Antivirus-Status: Clean
X-Spam-Rating: smtplq03.aruba.it 1.6.2 0/1000/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176868>

This is a multi-part message in MIME format.
--------------000403010602000803050404
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit



-------- Messaggio originale --------
Oggetto: 	installing git from sources
Data: 	Mon, 11 Jul 2011 18:34:21 +0200
Mittente: 	Massimo Manca <massimo.manca@micronengineering.it>
Organizzazione: 	Micron Engineering
A: 	git@vger.kernel.org



Due that for ubuntu 10 last packed git is 1.7.0 release
I installed git in linux from sources in this way:

wget .../git-1.7.6.tar.gz (incomplete web address but I download correctly)

apt-get build-dep git-core
tar -zxvf git-1.7.6.tar.gz
cd git-1.7.6.tar.gz
./configure
|make prefix=/usr/local all
sudo make prefix=/usr/local install|

all these command executed from my user maggiordomo (it is the user that could be used for sudo)

the problem is that to execute git I need sudo permissions:

git --version doesn't work
sudo git --version works.

1. What I did wrong?
2. If I make some mistakes installing from sources normally I use sudo make uninstall (from source directory) 
and I can remove the application. With git this simple doesn't work.
What have I to search and to remove other then the source directory (that has also .o .sh and executables)?


--------------000403010602000803050404
Content-Type: text/x-vcard; charset=utf-8;
 name="massimo_manca.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="massimo_manca.vcf"

begin:vcard
fn:Massimo Manca
n:Manca;Massimo
org:Micron Engineering di Massimo Manca
adr:;;via della Ferriera, 48;Pordenone;PN;33170;ITALIA
email;internet:massimo.manca@micronengineering.it
tel;work:+39 0434 1856131
tel;fax:+39 0434 1851032 / 178 273 3543
tel;cell:+39 349 4504979
url:http://www.micronengineering.it
version:2.1
end:vcard


--------------000403010602000803050404--
