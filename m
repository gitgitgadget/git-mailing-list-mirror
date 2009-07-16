From: Changsheng Jiang <jiangzuoyan@gmail.com>
Subject: how to fetch a new svn branch after clone?
Date: Thu, 16 Jul 2009 23:30:27 +0800
Message-ID: <eafc0afe0907160830m29e2f3d3jf5c0e9db29cace54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 17:31:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRSvN-0004Cg-LH
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 17:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbZGPPas convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 11:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbZGPPas
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 11:30:48 -0400
Received: from mail-vw0-f200.google.com ([209.85.212.200]:56807 "EHLO
	mail-vw0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbZGPPar convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 11:30:47 -0400
Received: by vwj38 with SMTP id 38so197215vwj.33
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=+kfNOgqW2C9gxQZLuj6CLd8HHR+0cIlwPMrFOQta3JQ=;
        b=kNLH3L1okX8N9HTVYpl/N6O0d7YSrJzX7We0jxqs0wowuy13CB03AFoOGvOBhHzneB
         w7p5AXJXCHSHkSlboyl+CHQ3Xyi0n52yM/FXJsr1WEuTgw0mcgCLxUWl7RvqT5BMTUeb
         y/2zjp055QwDWG+wRteNQCXCkLkUszfca3aww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=wQvdz8KIvH6AYw5ng0hsxbJ5Dcueox47sOkXP2PlWtS9DKPBvEV5/Bjb6a48lTzA7p
         f69gHvhZSnR9CIzk4anbWtr74Vhpb4N4fUl3P8mMhIKjV9QkaGXwWbyph37b7Qh9GM6N
         NjFihgQUPDQr0RRz7A7hYJxIbtt16t6FJ5W1o=
Received: by 10.220.94.69 with SMTP id y5mr13122200vcm.6.1247758247281; Thu, 
	16 Jul 2009 08:30:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123404>

Hi list,

I know how to clone a svn repository with all branches and tags at the
initial step, but I find no answers of how to fetch a new svn branch
after clone.

=46or example, this

git svn clone http://svn.example.com/project -T trunk -b branches -t ta=
gs

will clone all branches. but that clone, the svn repository has a new
branch test with url http://svn.example.com/project/test, how to clone
it as the initial step?

Thanks.

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Changsheng Jiang
