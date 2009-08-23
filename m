From: Jeffrey Ratcliffe <jeffrey.ratcliffe@gmail.com>
Subject: bundles with multiple branches
Date: Sun, 23 Aug 2009 22:36:01 +0200
Message-ID: <30e395780908231336p403c2171ie383a81c3d1bb020@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 22:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfJnP-0004zQ-LD
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 22:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934128AbZHWUgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 16:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934118AbZHWUgB
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 16:36:01 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35506 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934117AbZHWUgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 16:36:01 -0400
Received: by bwz19 with SMTP id 19so1180619bwz.37
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 13:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ChJR9yZ7lNdTegKmK/I5Tdaw2HEiS7ayDv2F4+Pie0M=;
        b=b4I5qR+5seiM7J8GRZFt2ENsF3KT86qGewEHgznauUOgzJVbTjAgEZnsojQFFWLAtS
         NeMjIvQ4EcSc0dSOZSrvBE8GJ7ZRTQJhh/FNA83euUubJyqfKAJBCpZxOLfRU7Z4fxj3
         oiURbiOM+TDCGqE3Av+fSqCIRIdq5dY3f/nYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=mGV1KVcRKwPV7ZWMfjF64cr79cKp9PgN9txMBoDC5iXlfE6ed2m3YTKIpKNff2r6Rt
         LomJOZz9N4euX7M/z8KuD9gv9fcy9hTDpUodtnzXZJ4PHdespuTAXyFNag12sv70BVkk
         dvsTCJzGDP0czxTb9ALkvTtwdRL9bU6mACfEQ=
Received: by 10.103.127.32 with SMTP id e32mr1517598mun.70.1251059761393; Sun, 
	23 Aug 2009 13:36:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126874>

I tend to work on multiple machines that don't have direct access to
each and therefore keep my git repositories in sync using bundles.

This works fine for single branches - but how can I set things up so
that I can just

$ git pull <bundle>

or

$ git fetch <bundle>

and have git update all branches?

Regards

Jeff
