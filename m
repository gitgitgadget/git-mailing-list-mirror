From: Claire Fousse <claire.fousse@gmail.com>
Subject: Git-Mediawiki : Question about Jeff King's import script
Date: Thu, 26 May 2011 17:18:11 +0200
Message-ID: <BANLkTi=nLZV_QCyKT8LOhzkJYoJD6J4wPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "matthieu.moy" <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Thu May 26 17:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPcKJ-0001Mc-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab1EZPSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:18:12 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43404 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762Ab1EZPSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:18:11 -0400
Received: by pvg12 with SMTP id 12so347643pvg.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=aDqGnrOHuUnmctOP1ZVWMGr+0Z4IFG3jP3AosrsRmC8=;
        b=jlSCkCwZrWVmIfcHgmp5Dgc3/EvmZymNuARHD4nfGzKV4IOK47ErKv6+xxXzb7GVGH
         o5aSDUvy2Fvqisxo4HdPCV7Xgg6HEVcyVZEBNozPPsSs3xXQEntu7gf96Xz6qFZzp/7v
         zs0N1WRF02JglMGbEUjaSYiSwmB0sWPX4S24k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=nWREye5fsKMTRg2trbJIZ3gU2inTjcwyWH9PF5zdSyFc3bUX3/xIlrZTOgXlpRH1/9
         geJd/7xZTO0Exb3/IuPZkN3tWVw29foeK0v/Gh6lF3P+C6HwfUFbxYXPEFN5YHFEqkOA
         HtxNbPJ0p4IP9/F6vLFNkQtVTe8JTNswCon7Q=
Received: by 10.142.144.8 with SMTP id r8mr155161wfd.142.1306423091137; Thu,
 26 May 2011 08:18:11 -0700 (PDT)
Received: by 10.143.155.9 with HTTP; Thu, 26 May 2011 08:18:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174521>

Dear Jeff King,
We are the four students in charge of the Git-Mediawiki project
proposed by Matthieu Moy.
In case you skipped our email, here is a link to our last mail with a
few information about the project
http://www.spinics.net/lists/git/msg158701.html
We based our script on what you called a few months ago the "quick and
dirty perl script" for the import part and have a few questions about
it.
First of all, just in case, here is your original script :
http://article.gmane.org/gmane.comp.version-control.git/167560

It seems like you first used a hashmap for it to be transformed later
into a flat list / array. What is the reasoning behind this ? Why not
create an array right away ?

Thanks for the script and for any information you can give us,

Regards,
The Git-Mediawiki team, Arnaud Lacurie, David Amouyal, Claire Fousse &
Jeremie Nikaes.
