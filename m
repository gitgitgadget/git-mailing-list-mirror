From: skillzero@gmail.com
Subject: Per-branch receive.denyNonFastForwards?
Date: Sun, 7 Jun 2009 22:20:44 -0700
Message-ID: <2729632a0906072220n4dff5d39vaa863401c136c3c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 07:20:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDXHw-0003ct-Pb
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 07:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbZFHFUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 01:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbZFHFUn
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 01:20:43 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:58156 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZFHFUm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 01:20:42 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1929622ywb.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 22:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=nU7pmu5pGRG/vIt+0/z+GF57T/H9sX3eioDUVy6Ep7U=;
        b=q9wdQtk4krDkbzlqmYP90E6EvPOPhyZBnB1zeWAZkZYACVQt5FrgcCigrqKa9im4xB
         vAvYxN0tOzDjfEybCDyiy0RH8wrj5VGdbNMuhsAbrm2jOImT6nWxHExZDGS1Z6ttJrpL
         YHyN0JuZWeFxTa158woGzCSCq+R8KtZUenEwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=SzolAm74pOMB5BbN23NitgvzuVlcjA31OEmIela2NRaVnSEqmnuX/hgWsj658vaNak
         O46X4uYwLDYEyf1Lc9OIM7Dt87BBRL/PjvwfVyF6pLYAvmUfLDywSvNCiqhSGSVYXcwO
         m0WcWSKDa7GUOODRX3fPZx+6dGsHr78cFCetw=
Received: by 10.100.12.17 with SMTP id 17mr5669549anl.2.1244438444450; Sun, 07 
	Jun 2009 22:20:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121033>

Is there a way to deny non-fast forward pushes to only certain
branches? I'd like for people to be able to force push to their own
branches on the server, but for the master branch (and maybe a couple
other important branches), I want to prevent it. I basically want a
per-branch version of receive.denyNonFastForwards. Is there a way to
do this?
