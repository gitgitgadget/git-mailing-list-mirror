From: Frank Li <lznuaa@gmail.com>
Subject: Build Git with Visual Studio 2008
Date: Sat, 18 Jul 2009 21:35:52 +0800
Message-ID: <1976ea660907180635y20983ef9w1cc080ec8efac060@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 15:36:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSA56-0003Xq-3y
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 15:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbZGRNfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 09:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbZGRNfx
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 09:35:53 -0400
Received: from mail-px0-f185.google.com ([209.85.216.185]:64618 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbZGRNfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 09:35:52 -0400
Received: by pxi15 with SMTP id 15so1025775pxi.33
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Y66xSeTRR91AtNFY2ifPkGsQKjTo0WbEDX/Yo33aZIU=;
        b=yH8lLDEBgEQeMejimhg1Pyzt6sMF/ShmxEwGrRvF758uljW6ToPL3lNA2vRrH/bmKi
         VxxNMFkbTN/SaJ2k22nVDOjRZANSir5x7igUvbdizLUem+hEE6xEV6Fmqyd4QU+65yXx
         FCWL0mnp/K0YIArPVYFaHLbqXWAAQR7TaxnOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=JONklmo64mXa7EsnT5ssG8KcsK9569u2NEDDRa0Q+7uZN+Mo+XYlebf17RaL+oSD9n
         kIk1v4SJhJNYGUm89kecnmcBAG/dqitRPwG71y3esMgThzAA7X9q5JunzrklDBXqOo6D
         4vJeBR8efzs3HrreITclAMlWUrhqsbtUUnuqU=
Received: by 10.114.103.1 with SMTP id a1mr3467453wac.218.1247924152343; Sat, 
	18 Jul 2009 06:35:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123518>

I successfully build git with visual studio 2008.

I just simple test git-log is work right.
I want to submit my work to mail list.

But I have some questions.

I create directory "vcbuild" under root/git.
vcbuild include VS project file and some dumy head files and binary libzip.

But I found a contrib directory, does I should put "vcbuild" to
contrib directory.
