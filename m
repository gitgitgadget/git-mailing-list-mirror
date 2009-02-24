From: Rafael Darder Calvo <rdarder@spiralti.com>
Subject: git-push error: Cannot write keep file
Date: Tue, 24 Feb 2009 15:04:55 -0200
Organization: Spiralti
Message-ID: <49A428B7.4000003@spiralti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050009070202040003000202"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 18:07:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc0jt-0000ER-Lx
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758541AbZBXRFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 12:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758376AbZBXRFH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:05:07 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:4453 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758183AbZBXRFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 12:05:06 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1091933yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 09:05:03 -0800 (PST)
Received: by 10.150.190.12 with SMTP id n12mr5656187ybf.162.1235495102950;
        Tue, 24 Feb 2009 09:05:02 -0800 (PST)
Received: from shiny.spiralti.com ([200.68.99.9])
        by mx.google.com with ESMTPS id i27sm241705elf.14.2009.02.24.09.05.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 09:05:01 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------050009070202040003000202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
	I am having the following error when I try to git push.


rdarder@shiny:~/Sources/promotoras$ git push origin ranto:ranto
Counting objects: 256, done.
Compressing objects: 100% (199/199), done.
Writing objects: 100% (213/213), 216.94 KiB, done.
Total 213 (delta 60), reused 1 (delta 0)

fatal: cannot write keep file

error: unpack failed: index-pack abnormal exit
To ssh://fherrero@10.7.1.20:2222/var/www/promotoras.git
  ! [remote rejected] ranto -> ranto (n/a (unpacker error))
error: failed to push some refs to 
'ssh://fherrero@10.7.1.20:2222/var/www/promotoras.git'


I couldn't find any significant description on the error "cannot write 
keep file". git-fsck passes without errors in both repositories, and I 
find no permission problems. Can anyone give me some directions on how 
to diagnose this?

Regards,

Rafael

--------------050009070202040003000202
Content-Type: text/x-vcard; charset=utf-8;
 name="rdarder.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rdarder.vcf"

begin:vcard
fn:Rafael Darder Calvo
n:Darder Calvo;Rafael
org:;Infraestructura
adr:;;Mitre 1017 Piso 5;Rosario;Santa Fe;S2000COU;Argentina
email;internet:rdarder@spiralti.com
title:Spiralti Rosario
tel;work:+54 341 5302041
url:www.spiralti.com
version:2.1
end:vcard


--------------050009070202040003000202--
