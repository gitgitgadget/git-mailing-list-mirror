From: Massimo Manca <massimo.manca@micronengineering.it>
Subject: Re: refactoring in GIT
Date: Tue, 28 Jun 2011 17:27:09 +0200
Organization: Micron Engineering
Message-ID: <4E09F2CD.6060309@micronengineering.it>
References: <loom.20110628T151105-908@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000803030603070201040701"
Cc: git@vger.kernel.org
To: eugene <eugene@oggtrading.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 17:50:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbaYL-0001Vk-3P
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 17:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757863Ab1F1Pfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 11:35:46 -0400
Received: from smtplq-out15.aruba.it ([62.149.158.35]:48541 "HELO
	smtplq02.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756377Ab1F1Peu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 11:34:50 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jun 2011 11:34:49 EDT
Received: (qmail 30720 invoked by uid 89); 28 Jun 2011 15:28:07 -0000
Received: from unknown (HELO smtp4.aruba.it) (62.149.158.224)
  by smtplq02.aruba.it with SMTP; 28 Jun 2011 15:28:07 -0000
Received: (qmail 13149 invoked by uid 89); 28 Jun 2011 15:28:07 -0000
Received: from unknown (HELO ?127.0.0.1?) (tecoff@micronengineering.it@83.211.66.238)
  by smtp4.ad.aruba.it with ESMTPA; 28 Jun 2011 15:28:06 -0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; it; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <loom.20110628T151105-908@post.gmane.org>
X-Enigmail-Version: 1.1.1
X-Antivirus: avast! (VPS 110628-0, 28/06/2011), Outbound message
X-Antivirus-Status: Clean
X-Spam-Rating: smtplq02.aruba.it 1.6.2 0/1000/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176404>

This is a multi-part message in MIME format.
--------------000803030603070201040701
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Il 28/06/2011 15.19, eugene ha scritto:

Hi,
 I'm new to GIT and have two questions about code refactoring. 

#1. I want to refactor class A into few classes B,C,D. How should I check them 
in and mark class A inactive so that development on A stops?

You can't. 
If you are working on a shared repository you have to modify the code in your private repository (or working directory), then verify if in the mean time another developer changed something, eventually apply other modification to your code (merge) and solve conflicts manually (if there are) in your working directory/private repository. After this you can push your code to the shared repository.

 Note, I do need A 
stay in repository for backward compt. with prior code releases.

#2. [related question] What if another developer already had A in his local 
repository, made changes and wants to commit after me. I just made A obsolete. 
Does he have drop his changes and take B,C,D from me and/or merge?

Same as for #1. The last developer that modifies module A has to update other modifications BEFORE and then apply her modifications.

Shortly: git doesn't block anything unstead git permits to merge changes coming from more the one developer.

It is my opinion that 2 developers haven't to work on the same module at the same time, but this for me is an organization matter it isn't related to git.

Sorry if this question was already answered, pls point me.

Thanks,
Eugene



--------------000803030603070201040701
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


--------------000803030603070201040701--
