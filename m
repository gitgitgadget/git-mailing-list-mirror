From: "Brett Ryan" <brett.ryan@gmail.com>
Subject: Does a `git pull' write to the origin repository in any way?
Date: Wed, 22 Oct 2008 20:00:11 +1100
Message-ID: <a65d095e0810220200q42936427o917cdac067d04135@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 11:01:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsZap-0006k2-Ey
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 11:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbYJVJAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 05:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbYJVJAO
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 05:00:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:45387 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYJVJAM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 05:00:12 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2855468rvb.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Umk3TGF8tZ58xD7DeCAvJAZ0Tvug+N3DYhwlb6d46TM=;
        b=KJwUCHiWQyloVF+paAxyIaMHB8aQ1noewC2ZWiM+I9vajbMiYncZxTFtKEd0fDa3Vy
         f8vZEK/rDPW/SFCPiCcF+hGatGSewARTiMMMJzvEDk6kvZ/p8IXUODnAxcoaiXpGOxFy
         twjKjBNNNrO2jtheJaY/ltRhFUNIraw82Uj/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=FZO7sva2HAgAgHJaaQHin4Md3F+wfhVDYzVVg5SeHhT3AyRCxShtp7O2O6ncN2/xhB
         pQgnRpM7VTt1g8vNIbcL7UFR86wYzthEV6yopF+5Ir26eDUnKRkBKrMtfyGYLKYUCLKv
         hT5LqW9OHEHpvfLAKEJX3vkgxazc31y95yEK0=
Received: by 10.141.15.19 with SMTP id s19mr6279079rvi.205.1224666011867;
        Wed, 22 Oct 2008 02:00:11 -0700 (PDT)
Received: by 10.141.145.6 with HTTP; Wed, 22 Oct 2008 02:00:11 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98851>

Greetings, the reason I ask this question is because my pattern of
development is to create local source git repositories on my home
directory, then pull them to the central location. I found myself
getting the error `unable to create temporary sha1 filename
.git/objects/11: File exists' which after investigation found that
there were paths in `.git/objects/' owned by root which is who I use
to do the pull from my home directory using sudo. `git log' shows all
commits as me.

Typical dev cycle.

cd ~/src/appl_bin
# make mods
git commit -a
cd $DEST
sudo git pull ~/src/appl_bin linux_test

Thankyou
-Brett
