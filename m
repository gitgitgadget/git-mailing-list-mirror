From: Massimo Manca <massimo.manca@micronengineering.it>
Subject: git clone and submodules
Date: Thu, 16 Jun 2011 15:13:30 +0200
Organization: Micron Engineering
Message-ID: <4DFA017A.5070206@micronengineering.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090307030401070407090807"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 15:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXCpx-0003xu-6C
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 15:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab1FPNmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 09:42:15 -0400
Received: from mp1-smtp-6.eutelia.it ([62.94.10.166]:59120 "EHLO
	smtp.eutelia.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752029Ab1FPNmO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 09:42:14 -0400
Received: from [127.0.0.1] (ip-227-68.sn1.eutelia.it [62.94.227.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.eutelia.it (Eutelia) with ESMTP id E610361C7A4
	for <git@vger.kernel.org>; Thu, 16 Jun 2011 15:14:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; it; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
X-Antivirus: avast! (VPS 110616-0, 16/06/2011), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175899>

This is a multi-part message in MIME format.
--------------090307030401070407090807
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello,
on my windows notebook I have a local repo: h:\Repositories\RepoWR; it
contains 2 branches: the master and the 1.1.0 (that is a bug correction
branch). At now the 1.1.0 it is not merged on the master because we will
correct more other bugs (one bug -> one branch).

1. I need to clone the Repo, I mean the repo, working directory and
complete branches and history.
Actually to do this I must make a brutal copy of the RepoWR folder
because if I use git clone git doesn't clone also the master branch but
only the 1.1.0 branch that it is the active one (I used git checkout to
activate it).

So I am sure that I miss something and that this is a very common
situation, what I am doing wrong?

2. RepoWR will contain a complex project developed by several engineers
and made of some subprojects (already existent) and some libraries. I
would manage them as submodules, these are my intents:
a) the library mclib (about 50 c files) has its repo on a different
location, I would "connect" its repo inside RepoWR as a submodule
because I am sure that we need to modify/extend the library and we would
to have the ability to modify it and propagate modifications to its
repo, forcing all users of mclib to see the modifications and to repeate
their regression tests
How can implement this situation? Where can I find info or documentation?

b) every module (not more the 4-5 c files) will be developed and unit
tested, so normally every engineer makes a unit test project
implementing/using the module to test with TDD workflow. During the
progress of the work the modules must be added and committed to RepoWR;
the modules are on the working directory of RepoWR (RepoWR\src) and the
test files on a specific subfolder (RepoWR\TestModuleOne\src).
Is this a viable solution or are there hidden problems and so better
solution to implement?

--------------090307030401070407090807
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


--------------090307030401070407090807--
