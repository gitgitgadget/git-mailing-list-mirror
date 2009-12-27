From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [RESEND] [PATCH] Endianness bug in index cache logic
Date: Sun, 27 Dec 2009 13:39:24 +0100
Message-ID: <40aa078e0912270439i3948a38fw9784e23e7cdc4407@mail.gmail.com>
References: <20091204202928.GW17192@gradx.cs.jhu.edu>
	 <20091227061121.GP14941@gradx.cs.jhu.edu>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nathaniel W Filardo <nwf@cs.jhu.edu>
X-From: git-owner@vger.kernel.org Sun Dec 27 13:39:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOsPD-00017l-2V
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 13:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbZL0Mj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2009 07:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbZL0Mj0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 07:39:26 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64441 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbZL0Mj0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2009 07:39:26 -0500
Received: by ewy19 with SMTP id 19so1128158ewy.21
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 04:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HDaT6PId4S+qGPpV4xGSztxxG0cfavcHb91QgD9Cf7A=;
        b=Rh10Lf7RDwswscobJ75zrS1kg1+XkfndpKs0M1lZTjYd+v3S07Y8xIL40gH4luxLg6
         t7HLn5PYRyPPZTDEgShHOBsw0rKeWClBEZOoDx80hjzy9RJK42CmeIHUo29GCspvYi98
         As5u5e4YxYQm1ef9JSA3QuQDsoeR5QVmwMJxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Tt+C2YeIevwZFoFOtuGIy/W7Sf8ew3yzZjAWtIo2/riGwal5YlXqnYwWDsTbR8O9Vm
         1RbanDgq4TFTnoR9ceANOFjZM1NFdCNLpZ4jJrcjfkfuzQv1OAA6z8ZjXg56pSSuF4k5
         iOw8bI8ZXTP8uZl5bZa7X+pYLXI+zd2UlnkWY=
Received: by 10.216.89.138 with SMTP id c10mr5203654wef.47.1261917564472; Sun, 
	27 Dec 2009 04:39:24 -0800 (PST)
In-Reply-To: <20091227061121.GP14941@gradx.cs.jhu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135703>

On Sun, Dec 27, 2009 at 7:11 AM, Nathaniel W Filardo <nwf@cs.jhu.edu> w=
rote:
> I got some free time and tracked it down. =A0The following one-line d=
elta
> fixes this issue for me; AIUI on sparc64 "unsigned long" is 8 bits an=
d in

You mean 8 bytes, right?

--=20
Erik "kusma" Faye-Lund
