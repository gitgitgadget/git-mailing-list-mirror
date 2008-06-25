From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Where does gitweb take the owner name from?
Date: Wed, 25 Jun 2008 17:41:04 +0300
Message-ID: <ce513bcc0806250741q3821e925uf8b6439b12062ba2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 16:42:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBWCK-0007BK-PI
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 16:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759701AbYFYOlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 10:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759160AbYFYOlG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 10:41:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:34486 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759279AbYFYOlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 10:41:04 -0400
Received: by rv-out-0506.google.com with SMTP id k40so8225740rvb.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=8ajZ/nnjgLeCWkJYt/8GqCwxKmaDbqIddH81ODB6nZk=;
        b=CGOGIMu8W31Mo38Z6V5G5W3IqxfRUDZ8Uc9gpAxGo8svLc8xyWtsrNyb9KwJyLBPVY
         S7XX8rK8wR4Q6lwhJXrp4g3Va+nDVkEQ0SPOBurtgt0v71Gmx8Layr9yJM5zZA7aX0an
         61CfNasFts/3o0zisIt4qi8jt6aeOjs3YaKow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=J3RLE0uCzvHWWSi4tpOVQR3AGDhUneQYy+WT9vhH9QEOhkIvnZEeI7nthScra/y7zb
         sCd33AXjztZIfnE2qsnMDhQXMtqI3JwWZgGLZIROR8lf51HsHlnSjNdb7g+kXuxtkpTw
         Brgeccfx3f/FViRIISIMjiSMA7mXYwGqzGD7g=
Received: by 10.141.75.17 with SMTP id c17mr16416098rvl.212.1214404864338;
        Wed, 25 Jun 2008 07:41:04 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Wed, 25 Jun 2008 07:41:04 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86282>

Hi,

On the main page of gitweb (the one that lists all projects), there's
an "Owner" column. On my gitweb, it is empty for all projects. Where
is this information taken from?

Here is how it looks on the server when I run 'ls -l':

drwxr-xr-x 7 erez.zilber linux 4096 Jun 25 17:36 my_test.git

Thanks,
Erez
